# Preferences

- Prefer simple, readable code over clever solutions — even if slightly more verbose
- Minimize diff noise: avoid unnecessary reformatting, reordering, or "improvements" unrelated to the task
- Research existing codebase patterns before proposing new approaches — ask "how does the codebase already handle this?"
- Prefer fakes over mocks in tests. Use existing fake implementations when available
- Verify claims with evidence — trace actual code paths rather than offering plausible-sounding explanations

## Plans

- Show only the final recommended approach. Remove rejected alternatives and deliberation
- For each proposed change, include: file path, line numbers, and a code snippet
- Use `// ADD THIS`, `// CHANGED`, `// REMOVE` markers in plan snippets to highlight what's changing
- Never include plan markers in actual implemented code — committed code should be production-ready
