# Neovim (LazyVim) — basic → advanced

`Space` is the **leader** key. Press it alone and a **which-key** menu shows every
option — discovery beats memorization. The whole language of Vim is **verb + motion**.

---

## 1. Mental model

- **Modes**: Normal (navigate/command), Insert (type), Visual (select), Command (`:`).
  `Esc` always returns to Normal.
- **Grammar**: a *verb* (`d`elete, `c`hange, `y`ank) + a *motion or text object*
  (`w`ord, `ip` paragraph, `i"` inside quotes). Learn the pieces, combine freely.
- **Repeat**: `.` repeats your last change. This is the single biggest time-saver.

## 2. Survival basics

| Key | Action |
|---|---|
| `i` / `a` | insert before / after cursor |
| `o` / `O` | open new line below / above |
| `Esc` | back to Normal |
| `:w` / `:q` / `:wq` | write / quit / write+quit |
| `u` / `Ctrl-r` | undo / redo |
| `.` | repeat last change |
| `:noh` | clear search highlight |

## 3. Moving around

| Key | Action |
|---|---|
| `w` `b` `e` | next / prev / end of word |
| `0` `^` `$` | line start / first non-blank / line end |
| `gg` `G` | top / bottom of file |
| `{` `}` | prev / next paragraph |
| `Ctrl-d` `Ctrl-u` | half page down / up |
| `%` | matching bracket |
| `f<c>` `t<c>` | jump to / before char on line (`;` `,` repeat) |
| `*` `#` | search word under cursor fwd / back |
| `Ctrl-o` `Ctrl-i` | jump back / forward in history |
| `''` | back to position before last jump |

## 4. Editing — verb + text object

**Verbs:** `d` delete · `c` change · `y` yank · `>`/`<` indent · `gu`/`gU` lower/upper case
**Text objects:** `iw` word · `ip` paragraph · `i"`/`i'` quotes · `i(` `i{` `i[` brackets · `it` HTML/JSX tag

| Example | Does |
|---|---|
| `ciw` | change inner word |
| `ci"` | change inside quotes |
| `di{` | delete inside `{ }` |
| `cit` | change inside JSX/HTML tag |
| `yy` `dd` | copy / delete line |
| `p` `P` | paste after / before |
| `>>` `<<` | indent / outdent line |
| `vaf` | select **a** whole **f**unction (treesitter) |

## 5. LazyVim leader keys (`Space` …)

| Keys | Action |
|---|---|
| `Space Space` | find files (Cmd+P) |
| `Space /` | grep text in project |
| `Space ,` | switch open buffers |
| `Space e` | file explorer |
| `Space g g` | lazygit (full git UI) |
| `Space c a` | code action (quick fix) |
| `Space c r` | rename symbol |
| `Space c s` | symbols outline |
| `Space s s` | jump to symbol in file |
| `Space s r` | search & replace across project |
| `Space b d` | close buffer |
| `Space q q` | quit all |

## 6. LSP — code intelligence (any code file)

| Key | Action |
|---|---|
| `gd` | go to definition |
| `gr` | find references |
| `gI` | go to implementation |
| `K` | hover docs / signature |
| `]d` `[d` | next / prev diagnostic |
| `]e` `[e` | next / prev error |
| `Space c f` | format file (Prettier) |

## 7. Treesitter — structural selection

| Key | Action |
|---|---|
| `Ctrl-Space` | **expand** selection by syntax node (press repeatedly) |
| `Backspace` | **shrink** selection |
| `vaf` / `vif` | select around / inner function |
| `vac` / `vic` | select around / inner class |
| `]f` `[f` | jump to next / prev function |
| `]c` `[c` | jump to next / prev class |

## 8. Buffers, splits, tabs

| Key | Action |
|---|---|
| `Shift-l` `Shift-h` | next / prev buffer (the top "tabs") |
| `Space ,` | buffer picker |
| `Ctrl-w s` / `Ctrl-w v` | split horizontal / vertical |
| `Ctrl-h/j/k/l` | move between splits **and tmux panes** |
| `Ctrl-w =` | equalize split sizes |
| `gt` `gT` | next / prev real tab page |

## 9. Surround & comments

| Key | Action |
|---|---|
| `gsaiw"` | wrap word in quotes (add surround) |
| `gsd"` | delete surrounding quotes |
| `gsr"'` | replace `"` with `'` |
| `gcc` | toggle comment line |
| `gc` + motion | comment region (`gcip` = paragraph) |

---

## 10. Scenarios — "how do I…?"

**Open a project and find a file**
`cd project && nvim .` → `Space Space` (file finder) or `Space e` (tree). `Space /` to grep.

**Rename a symbol everywhere**
Cursor on the symbol → `Space c r` → type new name → `Enter`. LSP updates every reference.

**Change a function's body**
`vif` selects the inner body; or `cif` to delete it and start typing. `vaf`/`daf` for the whole thing.

**Replace every occurrence in a file**
`:%s/old/new/g` (add `c` to confirm each: `:%s/old/new/gc`).
Or the visual way: cursor on word → `*` to search it → `cgn` to change → `n` `.` `n` `.` to repeat.

**Search & replace across the whole project**
`Space s r` (Grug-far) → type find/replace → apply.

**Fix lint errors / format**
`]e` jumps to each error, `Space c a` offers the fix. `Space c f` formats the file (Prettier on save is already on).

**Git: stage, commit, view diff**
`Space g g` opens lazygit — `Space` to stage, `c` to commit, arrows to browse diffs, `q` to quit.

**Multi-cursor-style edit**
`*` to find the word, then `cgn` to change the first, then `.` to repeat on each next match (skip one with `n`).

**Edit a JSX/HTML tag**
Inside the tag: `cit` changes the contents, `cat` changes the whole element, `vat` selects it.

**Jump back to where I was**
`Ctrl-o` walks backward through your jump history, `Ctrl-i` forward. `` `. `` jumps to last edit.

**Comment out a block**
Visual-select with `V` + motion, then `gc`. Or `gcip` to comment the whole paragraph.

**Open a terminal inside nvim**
`Ctrl-/` toggles a terminal. `Esc` then `Ctrl-/` to hide it.

---

## 11. Advanced

**Macros** — record a sequence, replay it:
`qa` start recording into register `a` → do edits → `q` stop. `@a` replays, `@@` repeats, `10@a` runs 10×.

**The dot + search combo** — the poor-man's multicursor:
`/foo` → `cgnBar<Esc>` → `n.` `n.` to change each match selectively.

**Registers** — named clipboards: `"ayy` yanks line into register `a`, `"ap` pastes it.
`"0p` pastes the last *yank* (survives deletes). `"+y` yanks to the system clipboard.

**Marks** — `ma` sets mark `a`; `` `a `` jumps back to it. Great for bouncing between two spots.

**Global command `:g`** — run a command on every matching line:
`:g/console.log/d` deletes all console.log lines. `:g/TODO/normal A  // done` appends to each.

**`:normal`** — run Normal-mode keys on a range: `:%normal A;` appends `;` to every line.

**Quickfix list** — collect locations and step through them:
`Space s g` (grep) populates it; `]q` / `[q` move next / prev; `:copen` shows the list.

**Folds** — `za` toggle fold under cursor, `zR` open all, `zM` close all.

**Command-line window** — `q:` opens an editable history of `:` commands; edit and `Enter` to run.

---

## 12. Customizing

- `:LazyExtras` — toggle language packs (Python, Go, Rust, Tailwind, Docker…) and features with one key.
- `:Mason` — manage LSP servers / formatters / linters.
- `:Lazy` — plugin manager UI (update with `U`, sync with `S`).
- `:checkhealth` — diagnose problems.
- Config lives in `~/.config/nvim/lua/` → `plugins/` to add plugins, `config/keymaps.lua` for keys.
