# Shared agent config (cross-tool)

This folder is the single source of truth for personal, global AI-agent configuration shared across tools on this machine. It's symlinked into each tool's expected location so instructions and skills don't need to be duplicated.

## Layout

- `AGENTS.md`: global personal instructions
- `agents/`: global custom subagent definitions (markdown, one file per agent)
- `skills/`: Agent Skills **owned by this repo** (`skills/<name>/SKILL.md`). Skills installed from the internet never live here.
- `external-skills.json`: manifest of third-party skills (source repo + skill names), installed by `install-external-skills.sh` via `npx skills`
- `commands/`: global custom slash commands (tool-specific frontmatter, so files here are written for whichever tool actually reads them - currently Claude Code)

## Symlinked into

| Tool | Path | Target |
|---|---|---|
| OpenCode | `~/.config/opencode/AGENTS.md` | `AGENTS.md` |
| OpenCode | `~/.config/opencode/agents/` | `agents/` |
| GitHub Copilot | `~/.copilot/agents/` | `agents/` |
| Pi | `~/.pi/agent/AGENTS.md` | `AGENTS.md` |
| Claude Code, GitHub Copilot | `~/.claude/CLAUDE.md` | `AGENTS.md` (Copilot reads `~/.claude/CLAUDE.md` as a user-level fallback) |
| Claude Code | `~/.claude/agents/` | `agents/` |
| Claude Code | `~/.claude/commands/` | `commands/` |
| OpenCode, Copilot, Pi | `~/.agents/skills/<name>` | `skills/<name>` (per skill) |
| Claude Code | `~/.claude/skills/<name>` | `skills/<name>` (per skill) |

`~/.agents/skills/` and `~/.claude/skills/` are real directories, not symlinks into this repo, so skills installed from the internet (`npx skills add`, `railway skills`, marketplaces) don't leak into the dotfiles. To track a third-party skill, add it to `external-skills.json`; the setup scripts install it from its original source.

Pi has no custom-subagent feature, so `agents/` isn't symlinked there.

Managed by `~/dotfiles/arch/2-dotfiles.sh` via `_installSymLink`.

## Claude Code settings

`cross/claude/settings.json` is symlinked to `~/.claude/settings.json` by both setup scripts. It holds only portable, non-sensitive preferences (model, theme, plugin marketplaces, enabled plugins). Never put API keys, tokens or `env` secrets in it; machine-local overrides belong in `~/.claude/settings.local.json`.

### MCP servers

User-scope MCP servers are declared in `cross/claude/mcp-servers.json` and registered by `cross/claude/install-mcp.sh` (run by both setup scripts).
