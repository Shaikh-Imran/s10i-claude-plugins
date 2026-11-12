# ai-no

Remove AI writing patterns, corporate filler, and robotic phrasing from text — rewriting it into direct, natural, human prose.

Designed for drafting, editing, and reviewing prose in pull requests, documentation, design docs, emails, chat messages, and notes.

## Features

- ✍️ **Human-like prose**: Strips AI vocabulary, stacked hedges, empty signposting, and corporate buzzwords.
- 🎯 **Factual precision**: Preserves every fact, technical detail, and intended tone — fixes text in place without inventing details.
- 🛡️ **Code & syntax safe**: Leaves code, commands, identifiers, URLs, quotes, and domain terminology untouched.
- ⚡ **Zero dependencies**: Pure Claude Code skill — no external scripts or setup required.

## Install

Via marketplace:

```bash
/plugin marketplace add shaikh-imran/s10i-claude-plugins
/plugin install ai-no@s10i-claude-plugins
```

Local installation:

```bash
/plugin install ./plugins/ai-no
```

## How It Works

Once installed, the `ai-no` skill can be invoked whenever you need to clean up AI-generated text or refine your writing.

### Usage Examples

- *"Use ai-no to rewrite this pull request description."*
- *"Clean up this doc section using the ai-no skill."*
- *"Review this email draft with ai-no and remove the corporate fluff."*

### What It Cleans

- **AI vocabulary & buzzwords**: *additionally, delve, tapestry, robust, seamless, elevate, empower, intricate, landscape, pivotal, navigate, realm*.
- **Weak filler & hedges**: *it's worth noting that, in order to, due to the fact that, could potentially possibly*.
- **Unnatural structures**: Wh-cleft openers (*"What matters is..."*), false agency (*"the data tells us"*), superficial *-ing* tails (*"... ensuring seamless integration"*).
- **Formatting tells**: Em dashes, excessive bolding, and decorative emojis in technical prose.

## File Structure

```
ai-no/
├── .claude-plugin/
│   └── plugin.json
├── skills/
│   └── ai-no/
│       └── SKILL.md
└── README.md
```

## License

[MIT](../../LICENSE)
