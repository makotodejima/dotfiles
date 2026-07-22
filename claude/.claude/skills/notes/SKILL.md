---
name: notes
description: Use this skill when the user wants to create, update, or read markdown notes in the shared note repository at "~/Library/Mobile\ Documents/iCloud~md~obsidian/Documents/Obsidian".

allowed-tools:
  - rg
  - find
  - ls
  - cat
  - sed
  - tail
  - deno
---

# Notes

General purpose note-taking in the shared markdown repository.

## Path

- `~/Library/Mobile\ Documents/iCloud~md~obsidian/Documents/Obsidian`.

## Retrieval

- `rg`, `find`, `ls`, `cat`, `sed`, and `tail` are available.
- Otherwise simply read the files in the repository.

## Editing

- Simply create or update markdown files in the repository as needed.
- Run `deno fmt` after edting.

## Important Notes

- Do not use `obsidian` command line tool.
