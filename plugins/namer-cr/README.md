# namer-cr

Prompts you to name your Claude Code session and pick a chat color on startup.

Suggests names based on the current git branch and folder name.

## Features

- 🏷️ Prompts for a session name on startup or when resuming an unnamed session
- 🌿 Git-branch-aware name suggestions (e.g. `myproject-feature-xyz`)
- 🎨 Chat color picker — choose from `red`, `blue`, `green`, `yellow`, `purple`, `orange`, `pink`, `cyan`, or randomize
- ⚡ Non-blocking — runs after session start, never delays startup

## Install

```bash
/plugin marketplace add shaikh-imran/s10i-claude-plugins
/plugin install namer-cr@s10i-claude-plugins
```

Local:
```bash
/plugin install ./plugins/namer-cr
```

## How It Works

1. On `session.start`, checks if the session needs a name.
2. Detects the git branch and folder name to build suggestions.
3. Uses `$.ui.ask` to let you pick or type a name.
4. Runs `/rename` with your choice.
5. Prompts for a chat color and runs `/color`.

## File Structure

```
namer-cr/
├── .claude-plugin/plugin.json
└── hooks/
    ├── hooks.json
    └── register.tsx
```

## License

MIT
