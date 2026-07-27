# Dev Constitution

A vendor-neutral development constitution for AI-assisted software engineering.

The goal of this repository is to provide a small, opinionated, and reusable set of rules that improve consistency across coding assistants, including ChatGPT, Claude, Gemini, Copilot, Cursor, Windsurf, Continue, Cline, and future tools.

## Files

| File                         | Purpose                                         |
| ---------------------------- | ----------------------------------------------- |
| `readme.md`                  | Human-friendly overview and usage instructions. |
| `constitution.md`            | Canonical and complete constitution.            |
| `constitution-compressed.md` | Token-optimized version for AI assistants.      |

## Usage

### Humans

Read and maintain `constitution.md`. It is the single source of truth for all development rules.

### AI Assistants

Prefer `constitution-compressed.md` whenever token usage matters.

Examples:

```text
Please follow the rules defined in constitution-compressed.md.
```

```text
Use constitution-compressed.md as the primary development constitution for this repository.
```

### Repository Integration

Reference `constitution-compressed.md` from:

* `AGENTS.md`
* `CLAUDE.md`
* `GEMINI.md`
* `.cursorrules`
* `.github/copilot-instructions.md`
* `.windsurfrules`
* `cline`
* `continue`

Example:

```md
# AGENTS.md

Follow the rules defined in:

- constitution-compressed.md

Priority:

1. Explicit user instructions.
2. Existing codebase conventions.
3. constitution-compressed.md.
```

## Design Goals

* Minimal and readable.
* Vendor-neutral.
* TypeScript-first.
* Functional programming oriented.
* Optimized for AI-assisted development.
* Suitable for long-term maintenance.

## Philosophy

* Keep responses short.
* Prefer minimal diffs.
* Preserve existing behavior.
* Favor readability over cleverness.
* Maintain consistency across people and tools.

## License

MIT.
