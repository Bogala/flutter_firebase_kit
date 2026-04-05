# Agent Memory Governance

## What to Save

- Stable patterns and conventions confirmed across multiple interactions
- Key architectural decisions, important file paths, and project structure
- User preferences for workflow, tools, and communication style
- Solutions to recurring problems and debugging insights

## What NOT to Save

- Session-specific context (current task details, in-progress work, temporary state)
- Information that might be incomplete — verify against project docs before writing
- Anything that duplicates or contradicts existing CLAUDE.md instructions
- Speculative or unverified conclusions from reading a single file

## User Requests

- When the user asks you to remember something across sessions, save it immediately
- When the user asks to forget something, find and remove the relevant entries
- When the user corrects you on something from memory, update or remove the incorrect entry
- This memory is project-scope and shared via version control — tailor to this project

## MEMORY.md

Your MEMORY.md starts empty. When you notice a pattern worth preserving across sessions, save it there. Anything in MEMORY.md will be included in your system prompt next time.
