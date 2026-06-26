# tmux — basic → advanced

tmux keeps terminal sessions alive (survives closing the terminal or SSH drops) and
splits one window into many panes. Everything starts with the **prefix**: `Ctrl-b`.
Press `Ctrl-b`, release, then the command key.

> This config (`~/.tmux.conf`): mouse on, true-color, 50k scrollback, `|`/`-` splits,
> `Ctrl-h/j/k/l` pane navigation (vim-aware), `prefix r` reloads config.

---

## 1. Mental model

```
server → sessions → windows (like tabs) → panes (splits within a window)
```
A **session** is a workspace (usually one per project). A **window** is a full-screen
tab inside it. A **pane** is a split region of a window.

## 2. Sessions (the persistence layer)

| Command | Action |
|---|---|
| `tmux` | start a new unnamed session |
| `tmux new -s dev` | start a session named `dev` |
| `tmux ls` | list sessions |
| `tmux attach -t dev` | re-attach to `dev` |
| `tmux kill-session -t dev` | kill `dev` |
| `prefix d` | **detach** (session keeps running in background) |
| `prefix s` | visual session switcher |
| `prefix $` | rename current session |

**Detach/attach is the killer feature:** `prefix d` leaves everything running; come back
later with `tmux attach`. Nothing is lost — long builds, servers, REPLs keep going.

## 3. Windows (tabs)

| Key | Action |
|---|---|
| `prefix c` | new window (opens in current path) |
| `prefix ,` | rename window |
| `prefix n` / `prefix p` | next / previous window |
| `prefix 0`…`9` | jump to window by number |
| `prefix w` | visual window list |
| `prefix &` | kill window |

## 4. Panes (splits)

| Key | Action |
|---|---|
| `prefix \|` | split vertical (this config) |
| `prefix -` | split horizontal (this config) |
| `Ctrl-h/j/k/l` | move between panes (also crosses into nvim splits) |
| `prefix z` | **zoom** pane to fullscreen (toggle) |
| `prefix x` | kill pane |
| `prefix {` / `prefix }` | swap pane left / right |
| `prefix space` | cycle through layouts |
| `prefix Ctrl-arrow` | resize pane (or drag with the mouse) |

## 5. Copy mode / scrollback

| Key | Action |
|---|---|
| `prefix [` | enter copy mode (scroll back) |
| arrows / `Ctrl-u` `Ctrl-d` | scroll |
| `/` `?` | search down / up in scrollback |
| `Space` then `Enter` | start selection, then copy (vi-style) |
| `q` | exit copy mode |
| mouse scroll | also enters copy mode (mouse is on) |

## 6. Config

| Key | Action |
|---|---|
| `prefix r` | reload `~/.tmux.conf` |
| `prefix ?` | list every key binding |

---

## 7. Scenarios — "how do I…?"

**Start a dev session: editor + server + logs**
```bash
tmux new -s myapp
# prefix |   → split for the dev server, run `npm run dev`
# prefix -   → split for logs / git
# Ctrl-h/k/l → hop between them, nvim splits included
```

**Leave work running and come back later**
`prefix d` to detach. Close the terminal, go home. Later: `tmux attach -t myapp` — exactly
as you left it, server still running.

**Keep a remote job alive over SSH**
```bash
ssh server
tmux new -s build      # start work inside tmux
# run the long job, then prefix d to detach
exit                   # drop the SSH connection — job keeps running
# reconnect later: ssh server → tmux attach -t build
```

**One session per project**
`tmux new -s api`, `tmux new -s web`, … then `prefix s` to flip between them, or
`tmux attach -t api` directly. Names keep them organized.

**Focus on one pane temporarily**
`prefix z` zooms the current pane to fullscreen; `prefix z` again to restore the layout.

**Resize panes**
Drag the borders with the mouse, or `prefix` then hold `Ctrl` + arrow keys.

**Copy terminal output to the clipboard**
`prefix [` to enter copy mode, navigate to the start, `Space` to begin selecting, move to
the end, `Enter` to copy. (Mouse drag also selects.)

**Run the same command in several panes**
`prefix :` then `setw synchronize-panes on` — keystrokes go to all panes at once
(great for editing the same file on multiple servers). `off` to stop.

---

## 8. Advanced

**Scripted session layout** — drop this in a project to spin up a full workspace:
```bash
#!/usr/bin/env bash
tmux new-session -d -s app -c ~/project
tmux send-keys -t app 'nvim .' C-m
tmux split-window -h -t app -c ~/project
tmux send-keys -t app 'npm run dev' C-m
tmux split-window -v -t app -c ~/project
tmux attach -t app
```

**Move a pane to its own window** — `prefix !`. **Join it back** — `prefix :` then
`join-pane -s <window>`.

**Jump to a session by name fast** — `tmux switch-client -t web` (from inside tmux), or
bind it. `prefix s` is the visual version.

**Persist sessions across reboots** — add the `tmux-resurrect` / `tmux-continuum`
plugins (via tpm) to save and auto-restore sessions. Ask and I'll wire it into the config.

---

## Cheat: the 10 you'll actually use daily

`tmux new -s x` · `tmux attach -t x` · `prefix d` · `prefix |` · `prefix -` ·
`Ctrl-h/j/k/l` · `prefix z` · `prefix c` · `prefix [` · `prefix r`
