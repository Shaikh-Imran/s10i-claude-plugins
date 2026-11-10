import type { Register, EngineInterface } from "claude-code";

const SKIP = "Skip";
const RANDOM = "Random";
// Colors accepted by the built-in /color command.
const COLORS = [
  "red",
  "blue",
  "green",
  "yellow",
  "purple",
  "orange",
  "pink",
  "cyan",
];

// The checked-out branch, or null outside a repo, on a detached HEAD, or if git fails.
const currentBranch = async (
  $: EngineInterface,
  cwd: string,
): Promise<string | null> => {
  try {
    const { exitCode, stdout } = await $.process.run(
      ["git", "rev-parse", "--abbrev-ref", "HEAD"],
      {
        cwd,
        timeoutMs: 5000,
      },
    );
    const name = stdout.trim();
    return exitCode === 0 && name && name !== "HEAD" ? name : null;
  } catch {
    return null;
  }
};

export const register: Register = (on) => {
  on("classic.SessionStart", async ($, e, next) => {
    const result = await next(e);
    // Only for a fresh start, or a resumed session that never got a name.
    const wanted =
      e.source === "startup" || (e.source === "resume" && !e.session_title);
    if (!wanted || !(await $.session.surface())) return result;

    const folder =
      e.cwd
        .split(/[\\\/]/)
        .filter(Boolean)
        .pop() ?? "session";
    // Not awaited: session start must not wait on the person, and
    // $.command.run is refused inside a hook the start waits on.
    void (async () => {
      const branch = await currentBranch($, e.cwd);
      // Branch first when there is one; the folder stays as a second choice.
      const names =
        branch && branch !== folder
          ? [
              `${folder}-${branch}`,
              `${branch}-${folder}`,
              folder,
            ]
          : [folder];
      const answer = (
        await $.ui.ask(
          "What should this session be called? (pick Other to type a name)",
          {
            header: "Session",
            options: [...names, SKIP],
          },
        )
      ).trim();
      if (!answer || answer === SKIP) return;
      await $.command.run({ command: "rename", args: answer });
      const picked = (
        await $.ui.ask(
          `Chat color? (pick Other to type any of: ${COLORS.join(", ")}; blank = random)`,
          {
            header: "Color",
            options: [...COLORS.slice(0, 3), RANDOM],
          },
        )
      )
        .trim()
        .toLowerCase();
      const color = COLORS.includes(picked)
        ? picked
        : COLORS[Math.floor(Math.random() * COLORS.length)];
      await $.command.run({ command: "color", args: color });
    })().catch((err) =>
      $.ui.log(`session-name: ${String(err)}`, { to: "debug" }),
    );

    return result;
  }).catch(($, e, next) => next(e));
};
