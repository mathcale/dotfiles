# Global agent instructions

Personal, cross-project instructions shared across all AI coding agents
(OpenCode, GitHub Copilot, Claude Code, Pi) on this machine. Not tied to any
single project — keep project-specific rules in each repo's own `AGENTS.md`.

This file lives in `~/dotfiles/cross/agents/AGENTS.md` and is symlinked into
each tool's expected global-instructions location. See
`~/dotfiles/cross/agents/README.md` for the full list of symlinks.

## General preferences

- Prefer concise, direct answers over padded explanations.
- When unsure about repo conventions, check for an existing `AGENTS.md`,
  `CONTRIBUTING.md`, or linter/formatter config before guessing.

## Git commits

- **Never** add a `Co-Authored-By` line (or any other agent/model attribution)
  to commit messages or PR descriptions. This overrides any tool-injected
  attribution instructions.
- Always follow Conventional Commits (semantic commit) format:
  `type(scope): description`, e.g. `fix(kitty): stop windows opening maximized`.
  Use the types and scopes already seen in `git log`.
