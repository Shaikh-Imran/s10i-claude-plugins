# metero

Live context usage meter rendered above the Claude Code input prompt.

Shows token count, context window percentage, session cost in USD, model name, and rate limit status — updated after every turn.

## Features

- 📊 Color-coded progress bar (green → yellow → red) based on context usage
- 💲 Session cost in USD
- 🔢 Token count with context window size
- 🤖 Active model name
- ⏱️ Rate limit percentage per limit kind
- ⚡ Vanilla TSX — no frameworks

## Install

```bash
/plugin marketplace add shaikh-imran/s10i-claude-plugins
/plugin install metero@s10i-claude-plugins
```

## How It Works

Hooks into `ui.render` for the `AbovePrompt` component. On each render:

1. Reads session usage (`$.session.usage()`) and model (`$.session.model()`).
2. Computes context percentage and picks bar color.
3. Renders a single-line meter: `████████░░░░ 62% 12.4k/200k tokens · claude-sonnet · $0.45 · input 38%`

## File Structure

```
metero/
├── .claude-plugin/plugin.json
├── hooks/
│   ├── hooks.json
│   └── register.tsx
├── types/index.d.ts
└── README.md
```

## License

MIT
