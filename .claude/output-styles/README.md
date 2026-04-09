# Output Styles

This directory contains customization for how Claude Code formats output in your IDE.

## Files

- `colors.json` - Color scheme for syntax highlighting and UI elements
- `icons.json` - Custom icons for agents, commands, and skills
- `formatting.json` - Text formatting rules (indentation, wrapping, etc.)

## Usage

Styles are automatically loaded from this directory and applied to:
- Agent responses
- Skill output
- Command results
- Error messages

## Example Color Scheme

```json
{
  "success": "#22c55e",
  "error": "#ef4444",
  "warning": "#f59e0b",
  "info": "#3b82f6"
}
```

See individual files for detailed configuration options.
