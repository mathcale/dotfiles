# Shared agent config (cross-tool)

This folder is the single source of truth for personal, global AI-agent configuration shared across tools on this machine. It's symlinked into each tool's expected location so instructions and skills don't need to be duplicated.

## Layout

- `AGENTS.md`: global personal instructions
- `agents/`: global custom subagent definitions (markdown, one file per agent)
- `skills/`: global Agent Skills (`skills/<name>/SKILL.md`)
- `commands/`: global custom slash commands (tool-specific frontmatter, so files here are written for whichever tool actually reads them - currently Claude Code)

## Symlinked into

| Tool | Path | Target |
|---|---|---|
| OpenCode | `~/.config/opencode/AGENTS.md` | `AGENTS.md` |
| OpenCode | `~/.config/opencode/agents/` | `agents/` |
| OpenCode | `~/.agents/skills/` | `skills/` |
| GitHub Copilot | `~/.claude/CLAUDE.md` | `AGENTS.md` (Copilot reads `~/.claude/CLAUDE.md` as a user-level fallback) |
| GitHub Copilot | `~/.copilot/agents/` | `agents/` |
| GitHub Copilot | `~/.agents/skills/` | `skills/` (already shared with OpenCode) |
| Pi | `~/.pi/agent/AGENTS.md` | `AGENTS.md` |
| Pi | `~/.agents/skills/` | `skills/` (already shared with OpenCode/Copilot) |
| Claude Code | `~/.claude/CLAUDE.md` | `AGENTS.md` (same file Copilot's fallback points at) |
| Claude Code | `~/.claude/agents/` | `agents/` |
| Claude Code | `~/.claude/commands/` | `commands/` |
| Claude Code | `~/.claude/skills/<name>/` | `skills/<name>/` (linked per-skill, not as one dir - `skills/synced/` under `~/.claude/skills/` holds real marketplace content and can't be replaced by a directory symlink) |

Pi has no custom-subagent feature, so `agents/` isn't symlinked there.

Managed by `~/dotfiles/arch/2-dotfiles.sh` via `_installSymLink`.

## Claude Code settings

`cross/claude/settings.json` is symlinked to `~/.claude/settings.json` by both setup scripts. It holds only portable, non-sensitive preferences (model, theme, plugin marketplaces, enabled plugins). Never put API keys, tokens or `env` secrets in it; machine-local overrides belong in `~/.claude/settings.local.json`.

### MCP servers

User-scope MCP servers are declared in `cross/claude/mcp-servers.json` and registered by `cross/claude/install-mcp.sh` (run by both setup scripts).
