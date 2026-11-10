# namer-cr

A [Claude Code](https://claude.ai/code) plugin that prompts you to name your session and choose a chat color on startup.

---

## Features

- 🏷️ **Automatic Session Naming**: Automatically prompts you to name your session upon startup or when resuming an unnamed session.
- 🌿 **Git Branch Awareness**: Smart naming suggestions incorporating your git branch and working directory folder name.
- 🎨 **Chat Color Customization**: Easily pick a vibrant chat color (`red`, `blue`, `green`, `yellow`, `purple`, `orange`, `pink`, `cyan`) or randomize it.
- ⚡ **Seamless Integration**: Hooks directly into Claude Code's session lifecycle using TypeScript/JSX hook modules.

---

## Installation

### Via Marketplace

1. Add the marketplace to Claude Code:
   ```bash
   /plugin marketplace add shaikh-imran/s10i-claude-plugins
   ```

2. Install the plugin:
   ```bash
   /plugin install namer-cr@s10i-claude-plugins
   ```

### Local / Development

To install or test directly from this repository:
```bash
/plugin install ./plugins/namer-cr
```

---

## How It Works

1. When a new session starts (`session.start`), the plugin checks if a session title is needed.
2. It detects the current git branch and folder name to offer smart naming options.
3. It uses Claude Code's interactive UI (`$.ui.ask`) to let you pick a session name.
4. It executes the built-in `/rename` command with your chosen name.
5. It then prompts you to choose a chat color and runs the `/color` command.

---

## File Structure

```text
namer-cr/
├── .claude-plugin/
│   └── plugin.json                     # Plugin manifest
└── hooks/
    ├── hooks.json                      # Hook configuration
    └── register.tsx                    # Session start hook module
```

---

## License

MIT
