#!/usr/bin/env bash
# Shows a native macOS banner notification with sound for Claude Code Notification hook events.
# Includes context: agent name and working directory path.
# Reads hook JSON context from stdin.

set -o pipefail 2>/dev/null || true

# Read payload from stdin if available
PAYLOAD=""
if [ ! -t 0 ]; then
  PAYLOAD="$(cat)"
fi

CWD_FALLBACK="$(pwd)"
SOUND_NAME="${CLAUDE_NOTI_SOUND:-Glass}"

# Display native macOS notification via JavaScript for Automation (JXA)
osascript -l JavaScript - "$PAYLOAD" "$CWD_FALLBACK" "$SOUND_NAME" << 'EOF' >/dev/null 2>&1 || true
function run(argv) {
  var rawPayload = argv[0] || "{}";
  var fallbackCwd = argv[1] || "";
  var soundEnv = (argv[2] && argv[2].length > 0) ? argv[2] : "Glass";

  var data = {};
  try {
    data = JSON.parse(rawPayload);
  } catch (e) {
    data = {};
  }

  // 1. Path of the agent running on
  var cwd = (data && data.cwd) ? String(data.cwd) : fallbackCwd;
  var projectName = cwd ? cwd.replace(/[\/\\]+$/, "").split(/[\/\\]/).pop() : "Claude Project";

  // 2. Session ID (shortened to 8 characters)
  var sid = (data && data.session_id) ? String(data.session_id) : "";
  if (sid.length > 8) {
    sid = sid.substring(0, 8);
  }

  // 3. Name of the agent running on (check agent_name, agent, session_name, name)
  var agentName = "";
  if (data) {
    if (data.agent_name) {
      agentName = String(data.agent_name);
    } else if (data.agent) {
      agentName = String(data.agent);
    } else if (data.session_name) {
      agentName = String(data.session_name);
    } else if (data.name) {
      agentName = String(data.name);
    }
  }

  // Fallback: check transcript for custom title (set via /rename or --name)
  if (!agentName && data && data.transcript_path) {
    try {
      var app = Application.currentApplication();
      app.includeStandardAdditions = true;
      var transcript = app.read(Path(data.transcript_path));
      var lines = transcript.split('\n');
      for (var i = lines.length - 1; i >= 0; i--) {
        if (lines[i].indexOf('"type":"custom-title"') !== -1) {
          var parsed = JSON.parse(lines[i]);
          if (parsed && parsed.customTitle) {
            agentName = parsed.customTitle;
            break;
          }
        }
      }
    } catch (e) {}
  }

  var label = agentName || sid || projectName;
  var title = "Claude Code" + (label ? " [" + label + "]" : "");
  var subtitle = projectName;

  // 4. Notification message or event trigger type
  var message = (data && data.message) ? String(data.message) : "";
  if (!message && data && data.type) {
    if (data.type === "permission_prompt") {
      message = "Tool execution permission required";
    } else if (data.type === "idle_prompt") {
      message = "Claude is waiting for your input";
    } else {
      message = "Notification: " + data.type;
    }
  }

  // 5. Body with context (agent name and path)
  var bodyParts = [];
  if (message) {
    bodyParts.push(message);
  }
  var agentDisplay = agentName || label;
  bodyParts.push("Agent: " + agentDisplay);
  bodyParts.push("Path: " + cwd);

  var body = bodyParts.join("\n");

  var app = Application.currentApplication();
  app.includeStandardAdditions = true;
  app.displayNotification(body, {
    withTitle: title,
    subtitle: subtitle,
    soundName: soundEnv
  });
}
EOF

# Optional: directly play audio via afplay if CLAUDE_NOTI_AFPLAY is enabled
if [ "${CLAUDE_NOTI_AFPLAY:-0}" = "1" ] || [ "${CLAUDE_NOTI_AFPLAY:-0}" = "true" ]; then
  SOUND_FILE="/System/Library/Sounds/${SOUND_NAME}.aiff"
  if [ -f "$SOUND_FILE" ]; then
    afplay "$SOUND_FILE" >/dev/null 2>&1 &
  fi
fi

exit 0
