---
name: git-fixup-autosquash
description: Create targeted git fixup commits for changes that should be folded into earlier commits in a supplied revision range, then run an autosquash rebase. Use when the user asks to split current staged or unstaged changes into fixup commits, amend prior commits, autosquash a stack, or repair a commit series without making a new standalone commit.
---

# Git Fixup Autosquash

## Overview

Use this skill to inspect current working tree changes, map each change to the
most likely commit inside a user-provided revision range, create `fixup!`
commits, and autosquash them safely.

Require the user to provide a revision range before inspecting destination
commits. Do not inspect candidate destination commits outside that range.

## Required Inputs

Ask for missing input before proceeding:

- `revision-range`: the commit range containing possible fixup targets, such as
  `main..HEAD`, `origin/main..HEAD`, or `abc123..HEAD`.
- `range-base`: the base passed to `git rebase -i --autosquash`. Derive it from
  `revision-range` when unambiguous. If ambiguous, ask.

## Initial Inspection

Run these commands first, before planning fixups:

```bash
git status --short
git diff --stat
git diff
git diff --cached
```

Then inspect only candidate destination commits inside the provided range:

```bash
git log --oneline --name-status <revision-range>
```

Do not use broader history commands such as unrestricted `git log`, `git blame`,
or searches outside the range to choose target commits unless the user
explicitly approves.

## Grouping Rules

Group current changes by likely target commit in this priority order:

1. Exact file ownership first. If a changed file was introduced or last
   materially changed by one commit in the revision range, prefer that commit.

2. Domain or module match second. If exact ownership is not decisive, match by
   nearby paths, package/module boundaries, frontend/backend split, tests near
   implementation, or feature naming in commit subjects.

3. Hunk-level split only when one file clearly belongs to multiple commits. Use
   hunk-level staging for files containing unrelated edits that map cleanly to
   different commits. Do not force a split when the hunks are interdependent.

4. Mark ambiguous changes as requiring user decision. If multiple commits are
   plausible, do not guess. Put those files or hunks in an `ambiguous` section
   and ask the user to choose.

Treat staged and unstaged changes as part of the same planning surface. Preserve
the distinction only when it matters for safe staging.

## Present The Plan

Before committing anything, present a plan and wait for approval.

Use this format:

```text
fixup! feat: add docx review session persistence and read API
  target: fd475489a1
  files:
    legalos/src/backend/...

fixup! feat: add docx review supervision frontend
  target: 6dc8bf2e86
  files:
    legalos/src/frontend/...

ambiguous:
  files:
    path/to/file
  decision needed:
    choose between fd475489a1 and 6dc8bf2e86
```

Include hunk-level notes when only part of a file belongs to a group.

## After Approval

For each approved group:

1. Ensure the index contains only that group.
2. Stage the group with pathspecs or hunk staging as appropriate:

```bash
git add <paths>
git add -p <file>
```

3. Verify the staged diff matches only the intended group:

```bash
git diff --cached --stat
git diff --cached
```

4. Create the fixup commit:

```bash
git commit --fixup=<target-sha>
```

Repeat until every approved group has been committed.

## Final Verification And Autosquash

After creating all fixup commits:

```bash
git status --short
git diff --stat
git diff
git diff --cached
```

Verify there are no unintended staged or unstaged leftovers. If leftovers
remain, report them and do not rebase unless the user explicitly approves
continuing.

Then run:

```bash
GIT_SEQUENCE_EDITOR=true git rebase -i --autosquash <range-base>
```

## Stop Conditions

Stop immediately and report if:

- A merge or rebase conflict occurs.
- A change cannot be mapped confidently to a target commit.
- The staged diff includes files or hunks outside the approved group.
- The worktree has unexpected leftovers before autosquash.
- The revision range or range base is ambiguous.
- A command fails in a way that could affect repository history.

When stopping, report the current state, the failed command, and the safest next
action.
