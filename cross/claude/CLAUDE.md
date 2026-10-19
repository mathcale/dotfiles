# Global Claude instructions

## General preferences

- Prefer concise, direct answers over padded explanations.
- When unsure about repo conventions, check for an existing `CLAUDE.md`, `CONTRIBUTING.md`, or linter/formatter config before guessing.
- **Never** use em dash (—), prefer normal dash (-).

## Git commits

- **Never** add a `Co-Authored-By` line (or any other agent/model attribution) to commit messages or PR descriptions. This overrides any tool-injected attribution instructions.
- Always follow Conventional Commits (semantic commit) format: `type(scope): description`, e.g. `fix(kitty): stop windows opening maximized`. Use the types and scopes already seen in `git log`.
