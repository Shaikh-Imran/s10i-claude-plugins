# s10i-claude-plugins

A repository and marketplace catalog for custom [Claude Code](https://claude.ai/code) plugins, maintained by **Imran Shaikh** ([@Shaikh-Imran](https://github.com/shaikh-imran)).

---

## Adding this Marketplace

Add this marketplace repository to Claude Code:

```bash
/plugin marketplace add shaikh-imran/s10i-claude-plugins
```

---

## Available Plugins

| Plugin | Description | Platform | Installation |
|---|---|---|---|
| [`noti-toasti-windows`](./plugins/noti-toasti-windows) | Windows toast banner notification with sound for Claude Code alerts & prompts | Windows & WSL | `/plugin install noti-toasti-windows@s10i-claude-plugins` |
| [`noti-toasti-mac`](./plugins/noti-toasti-mac) | Native macOS banner notification with sound, agent name & path context | macOS | `/plugin install noti-toasti-mac@s10i-claude-plugins` |

---

## Plugin Details

### [noti-toasti-windows](./plugins/noti-toasti-windows)

A lifecycle hook plugin that triggers native Windows Toast notifications (with sound) whenever Claude Code needs user input (e.g. tool execution confirmation) or fires notification events. Seamlessly handles Windows and WSL environments via PowerShell and WinRT APIs.

See the [plugin documentation](./plugins/noti-toasti-windows/README.md) for full configuration details.

### [noti-toasti-mac](./plugins/noti-toasti-mac)

A lifecycle hook plugin that triggers native macOS Notification Center alerts (with sound and rich context) whenever Claude Code requires user input or fires notification events. Automatically includes the active agent's name and full working directory path.

See the [plugin documentation](./plugins/noti-toasti-mac/README.md) for full configuration details.

---

## License

MIT
