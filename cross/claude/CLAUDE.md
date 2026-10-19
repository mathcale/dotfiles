# Global Claude instructions

Personal, cross-project instructions for Claude Code on this machine. Not tied
to any single project — keep project-specific rules in each repo's own
`CLAUDE.md`.

This file lives in `~/dotfiles/cross/claude/CLAUDE.md` and is symlinked to
`~/.claude/CLAUDE.md`. See `~/dotfiles/cross/claude/README.md`.

## General preferences

- Prefer concise, direct answers over padded explanations.
- When unsure about repo conventions, check for an existing `CLAUDE.md`,
  `CONTRIBUTING.md`, or linter/formatter config before guessing.

## Git commits

- **Never** add a `Co-Authored-By` line (or any other agent/model attribution)
  to commit messages or PR descriptions. This overrides any tool-injected
  attribution instructions.
- Always follow Conventional Commits (semantic commit) format:
  `type(scope): description`, e.g. `fix(kitty): stop windows opening maximized`.
  Use the types and scopes already seen in `git log`.
