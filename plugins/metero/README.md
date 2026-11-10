# metero

A Claude Code plugin (`metero`) that acts as a Claude Mod, rendering a live context usage meter directly above the input prompt in Claude Code. It calculates estimated token consumption and cost in USD based on session messages, featuring a clean visual progress bar and color-coded status.

---

## Features

- **Above-Prompt Display**: Hooks into `ui.render` for `AbovePrompt` to render in real-time above the user input box.
- **Token & Cost Calculation**: Dynamically estimates total tokens used and current session cost in USD.
- **Visual Meter Bar**: Color-coded progress bar (`green`, `yellow`, `red`) indicating capacity usage.
- **Zero Frameworks**: Built cleanly using vanilla JavaScript / TypeScript and Claude Mod rendering primitives (`Box`, `Text`).

---

## Installation

Add this marketplace repository if you haven't already:

```bash
/plugin marketplace add shaikh-imran/s10i-claude-plugins
```

Install the `metero` plugin:

```bash
/plugin install metero@s10i-claude-plugins
```

---

## License

MIT
