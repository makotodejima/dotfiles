---
name: obsidian
description: Search, read, create, and update notes in the Obsidian vault.
disable-model-invocation: true
---

You have access to the Obsidian vault via the `obsidian` MCP server.

## Tools

- **File**: `read_note`, `write_note`, `patch_note`, `delete_note`, `move_note`,
  `move_file`
- **Directory**: `list_directory`
- **Batch**: `read_multiple_notes`
- **Search**: `search_notes` — multi-word matching with BM25 relevance reranking
- **Metadata**: `get_frontmatter`, `update_frontmatter`, `get_notes_info`,
  `get_vault_stats`
