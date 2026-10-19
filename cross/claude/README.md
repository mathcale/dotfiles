# Claude Code config

Personal, global Claude Code configuration, symlinked into `~/.claude` by the setup scripts.

## Layout

- `CLAUDE.md`: global personal instructions
- `settings.json`: portable, non-sensitive preferences (model, theme, plugin marketplaces, enabled plugins). Never put API keys, tokens or `env` secrets in it; machine-local overrides belong in `~/.claude/settings.local.json`.
- `agents/`: custom subagent definitions (markdown, one file per agent)
- `commands/`: custom slash commands
- `skills/`: skills **owned by this repo** (`skills/<name>/SKILL.md`). Skills installed from the internet never live here.
- `external-skills.json`: manifest of third-party skills (source repo + skill names), installed from their original source by `install-external-skills.sh` via `npx skills`
- `mcp-servers.json`: user-scope MCP servers, registered by `install-mcp.sh`

## Symlinks

| Path | Target |
|---|---|
| `~/.claude/CLAUDE.md` | `CLAUDE.md` |
| `~/.claude/settings.json` | `settings.json` |
| `~/.claude/agents/` | `agents/` |
| `~/.claude/commands/` | `commands/` |
| `~/.claude/skills/<name>` | `skills/<name>` (per skill) |

`~/.claude/skills/` is a real directory, not a symlink into this repo, so skills installed from the internet (`npx skills add`, `railway skills`, marketplaces) don't leak into the dotfiles. To track a third-party skill, add it to `external-skills.json`.
