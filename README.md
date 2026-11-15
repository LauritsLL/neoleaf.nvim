<div align="center">

# ✨ neoleaf.nvim ✨

**Write your Overleaf projects in Neovim, live, together with your collaborators.**

*Real-time sync · your own plugins · local compiling · a time machine for your whole project*

</div>

---

Ever wished you could write a thesis in your own editor while your supervisor leaves comments in the browser, at the same time? 🎓 That is exactly what this plugin does. Your edits are sent to [Overleaf](https://www.overleaf.com) as they happen using Operational Transformation (OT), and everyone else's edits flow into your buffer. Treesitter, LSP, snippets, Copilot: everything you already love keeps working. 💚

## 🌱 Where this comes from

This project grew out of [overleaf.nvim by richwomanbtc](https://github.com/richwomanbtc/overleaf.nvim) and has gone its own way since. Compared with that project's README, this version adds:

| | overleaf.nvim | ✨ neoleaf.nvim ✨ |
|---|---|---|
| ↩️ **Undo** | Vim's own undo, which can also revert collaborators' text | A custom undo that only touches *your* changes |
| 🛟 **Sync safety** | Basic OT | Correct transforms for multi-part and overlapping edits, and a rejoin that keeps your unsynced edits |
| 📥 **Download** | Documents on connect | Every document *and* binary file, throttled and retried |
| 🗂️ **File management** | Fixed targets | Acts on whatever you are pointing at, new files land in the right folder |
| 📤 **Uploading** | One file at a time | Many files, globs, tab completion, optional auto-upload |
| ✏️ **Renames and moves** | Not covered | Collaborators' renames and moves follow into your tree, disk and buffers |
| 🔨 **Compiling** | "Compile and open the PDF" | Local latexmk, XeLaTeX, compile-on-write, Okular inverse search |
| 🧯 **Compile errors** | `vim.diagnostic` | Also the quickfix list, with file and line |
| 🕰️ **History** | View the version list | Whole-project diff by content, file-by-file review, restore |
| 🌈 **Statusline** | None | Colourful connection, collaborators and compile status |
| 📝 **Logging** | Log level | Full log file, quiet one-liners, popups for the important stuff |

## 🎁 Features

- 🤝 **Real-time collaboration** with other Overleaf users via OT
- ↩️ **Collaborator-safe undo**: `u` and `<C-r>` only ever undo *your own* changes
- 🛟 **Resilient sync**: correct OT transforms, and a rejoin that never throws your unsynced work away
- 🧩 **Full Neovim ecosystem**: treesitter, LSP (texlab, ltex, harper_ls), snippets, Copilot
- 🌳 **File tree sidebar** where new files appear under their own folder
- 🎯 **Context-aware file management**: create and delete based on what you are pointing at
- 📤 **Easy uploads**: several files or globs at once, or let the plugin auto-upload
- 🔄 **Live renames and moves** from collaborators
- 📥 **Full project download** on connect
- 🔌 **Auto-reconnect** after disconnects and restores
- 🔨 **Local LaTeX compiling** with latexmk, XeLaTeX support and optional compile-on-write
- 📄 **PDF preview with inverse search** in Okular
- 💬 **Comments and reviews**: view, reply, resolve
- 👀 **Collaborator cursors**
- 🔎 **Project-wide search**
- 🕰️ **History time machine**: diff the whole project against any version and restore it
- 🌈 **Statusline component** for lualine (or anything else)
- 🧯 **Compile errors in quickfix**, with the first error one command away
- 🩺 **Diagnostics**: chktex plus LaTeX compile errors via `vim.diagnostic`
- 💾 **Local file sync** so external tools (Claude Code and friends) can edit your project
- 🤫 **Quiet, complete logging**: no "Press ENTER" prompts, ever

## 📋 Requirements

- Neovim **0.10** or newer
- Node.js **18** or newer
- An [Overleaf](https://www.overleaf.com) account
- Chrome / Chromium (for automatic cookie extraction), or a session cookie

## 📦 Installation

### lazy.nvim

```lua
{
  'LauritsLL/neoleaf.nvim',
  config = function()
    require('overleaf').setup()
  end,
  build = 'cd node && npm install',
}
```

Node.js not on your PATH (Homebrew on macOS, for example)?

```lua
{
  'LauritsLL/neoleaf.nvim',
  config = function()
    require('overleaf').setup({
      node_path = '/opt/homebrew/bin/node',
    })
  end,
  build = 'cd node && npm install',
}
```

### Manual

```sh
git clone https://github.com/LauritsLL/neoleaf.nvim ~/.local/share/nvim/lazy/neoleaf.nvim
cd ~/.local/share/nvim/lazy/neoleaf.nvim/node && npm install
```

## 🔑 Authentication

### Option 1: Chrome (automatic) 🪄

Log in to [overleaf.com](https://www.overleaf.com) in Chrome and you are done. The plugin picks up the session cookie by itself. With several Chrome profiles it asks which one to use.

### Option 2: Manual cookie 🍪

Put this in a `.env` file in your working directory:

```
OVERLEAF_COOKIE=your_overleaf_session2_cookie_here
```

or pass it in `setup`:

```lua
require('overleaf').setup({
  cookie = 'your_overleaf_session2_cookie_here',
})
```

> ⚠️ **Careful:** this cookie gives full access to your Overleaf account. Don't commit a config that contains it to a public dotfiles repo.

To get it by hand: open overleaf.com, press F12, go to Application → Cookies → `www.overleaf.com`, and copy the value of `overleaf_session2` (it starts with `overleaf_session2=s%3A...`).

## 🚀 Quick start

1. `:Overleaf` to authenticate and pick a project
2. The file tree opens: press `Enter` on a document
3. Type away; your edits sync in real time
4. `:w` compiles locally (with `sync_dir` enabled) and opens the PDF in Okular
5. Shift+click in Okular to jump back to the exact spot in Neovim
6. `:Overleaf tree` to hop between files

## ⌨️ Commands

| Command | What it does |
|---------|--------------|
| `:Overleaf` | Connect (or show status if connected) |
| `:Overleaf connect` | Connect to Overleaf |
| `:Overleaf disconnect` | Disconnect |
| `:Overleaf compile` | Compile the project |
| `:Overleaf errors` | Put the compile errors of the latest log in quickfix and jump to the first |
| `:Overleaf tree` | Toggle the file tree |
| `:Overleaf open` | Open a document |
| `:Overleaf projects` | Switch project |
| `:Overleaf status` | Show connection status |
| `:Overleaf preview` | Preview a binary file (images, etc.) |
| `:Overleaf new [name]` | New document in the folder you are pointing at |
| `:Overleaf mkdir [name]` | New folder in the folder you are pointing at |
| `:Overleaf delete` | Delete the entry you are pointing at (asks first) |
| `:Overleaf rename` | Rename a file or folder |
| `:Overleaf upload [paths]` | Upload files, globs or a path with spaces (tab-completes) |
| `:Overleaf main` | Set the project's main `.tex` file |
| `:Overleaf search [pattern]` | Search across all documents |
| `:Overleaf comments` | List all comments |
| `:Overleaf comments refresh` | Refresh comments from the server |
| `:Overleaf history` | Time machine: diff against a past version, optionally restore |
| `:Overleaf sync` | Sync all documents to and from disk |
| `:Overleaf sync import` | Import external changes from disk to Overleaf |
| `:Overleaf sync export` | Export all documents to disk |

## 🎹 Keymaps

**Default**

| Key | What it does |
|-----|--------------|
| `<leader>oc` | Connect |
| `<leader>od` | Disconnect |
| `<leader>ob` | Build (compile) |
| `<leader>ot` | Toggle file tree |
| `<leader>oo` | Open document picker |
| `<leader>op` | Preview file |
| `<leader>or` | Read comment at cursor |
| `<leader>oR` | Reply to comment |
| `<leader>ox` | Resolve or reopen comment |
| `<leader>of` | Find in project |

**In the file tree** 🌳

| Key | What it does |
|-----|--------------|
| `Enter` | Open document |
| `a` | New document (in the folder under the cursor) |
| `A` | New folder (in the folder under the cursor) |
| `d` | Delete |
| `r` | Rename |
| `u` | Upload file (into the folder under the cursor) |
| `m` | Set as main `.tex` |
| `R` | Refresh tree |
| `q` | Close tree |

## 🕰️ History: the time machine

`:Overleaf history` lists the project's recent versions, newest first (40 at a time). Pick one, and the plugin compares **the whole project** with it.

**The summary tab** lists every file that differs, and tells you what a restore would do to it:

| Mark | Meaning |
|------|---------|
| 🟢 `+` | *will be DELETED* — it exists now but not in that version |
| 🔴 `-` | *will be RESTORED* — it existed then, but is gone now |
| 🟡 `~` | *will be REVERTED* — the content differs |
| 🟡 `?` | could not be compared (never hidden) |

Unchanged files are not listed at all.

> 💡 The comparison is by **path and content**, not by Overleaf's own change labels. After an earlier restore Overleaf calls re-created files "added" even if nothing changed. Comparing the text at both versions avoids that trap.

Some things to know:
- 🖼️ Binary files (images, PDFs) can't be compared as text. They are only counted in the header, so check those in Overleaf's own history.
- 🔀 A renamed file shows up as one `-` and one `+`.

| Key (summary tab) | What it does |
|-------------------|--------------|
| `<CR>` | Side-by-side diff of the file under the cursor (old left, current right), in its own tab |
| `<leader>R` | Restore the **whole project** to this version (asks `y/N`, shows how many files change) |
| `q` | Close |

Inside a file diff, lines wrap at word boundaries, both cursors move together, `]c` and `[c` jump between changes, `zo` `zc` `za` `zR` `zM` open and close folds in **both** windows, and `q` takes you back to the summary.

**Restoring** uses Overleaf's own "restore project", which Overleaf records as a *new* version, so you can always restore back. 🛡️ Before it runs:

- it refuses if any open document still has unsynced edits (wait a moment, retry)
- every open buffer is saved to `~/.local/state/nvim/overleaf-restore-backup/<timestamp>/`

Afterwards all Overleaf buffers are wiped, the project is re-synced, and the files you had open are reopened if they still exist, so no buffer is left pointing at a file that is gone. Windows showing those buffers close.

## 🌈 Statusline

`require('overleaf.statusline').status()` gives you a coloured string with the connection state, who is online 👥, and the compile result (`⟳` running, `✔` ok, `✘` errors). It is empty while you are not connected, so your normal statusline stays untouched.

**lualine**

```lua
sections = {
  lualine_x = {
    {
      function() return require('overleaf.statusline').status() end,
      cond = function() return require('overleaf.statusline').active() end,
    },
  },
}
```

**Plain statusline**

```lua
vim.o.statusline = '%f %m%=%{%v:lua.require("overleaf.statusline").status()%} %l:%c'
```

The colours come from the highlight groups `OverleafOn`, `OverleafOff`, `OverleafUsers` and `OverleafWarn`. They are only defaults, so override them in your colourscheme. 🎨

## 🧯 Compile errors

After every local compile the log is parsed. Errors show up through `vim.diagnostic`, and **every** error lands in the quickfix list with its file and line. `:Overleaf errors` opens the list and jumps to the first one. Besides `file:line: message` errors it catches LaTeX `!` errors (`File ... not found`, missing fonts) and missing `.bib` files.

File and line numbers need `-file-line-error`. The plugin's latexmk arguments should include it, otherwise errors appear without a location.

## 🗂️ Working with files

### Context-aware create and delete

`:Overleaf new`, `:Overleaf mkdir`, `:Overleaf delete` and the tree keys `a`, `A`, `d` and `u` work on whatever you are pointing at:

- 🌳 **In the tree:** the entry under the cursor. On a folder, new items go inside it. On a file, they go next to it. On a root-level file, they go to the project root.
- 📝 **In an Overleaf buffer:** the folder of the file you are editing (for delete: that file).
- 🌍 **Anywhere else:** new items go to the project root, and `:Overleaf delete` shows a picker.

Delete always asks `y/N` first.

### Uploading

`:Overleaf upload` takes paths, globs or a single path with spaces, and tab-completes local paths:

```
:Overleaf upload Pictures/*.png
:Overleaf upload ~/figures/plot1.png ~/figures/plot2.png
```

- A file inside the sync directory is uploaded into the matching Overleaf folder. Anything else goes to the project root (or the folder you picked with `u` in the tree).
- Uploads run two at a time, and one summary line tells you how many were uploaded, skipped or failed.
- A path that already exists in the project is skipped, unless `upload_overwrite` is set.
- A file whose folder doesn't exist in the project is skipped with a warning. The plugin won't create folders for you.

> ⚠️ **Known issue:** uploading a text file such as `.tex` can fail with `422 invalid_filename` from Overleaf, even with a perfectly valid name, and the cause isn't found yet. For a new text document use `:Overleaf new`, which works. Images and other binary files are what uploads are meant for.

### Auto-upload 🤖

Set `auto_upload = true` and the plugin watches your sync directory. When a new local file shows up, say a figure your script just saved into `Pictures/`, it is uploaded to the matching Overleaf folder.

- It waits until the file stops growing, so half-written files are never uploaded.
- It ignores hidden files, editor swap and temp files, LaTeX build output (`.aux`, `.log`, `.out`, `.toc`, `.xdv`, `.bbl`, `.synctex.gz`, ...), and a PDF sitting next to a `.tex` of the same name (that's your own compile output).
- `auto_upload_ext` limits it to certain extensions.
- One watcher runs per project folder. Folders created after you connected are picked up by the next `:Overleaf sync`.

### Collaborator renames and moves 🔄

When someone renames or moves a file or folder on Overleaf:

- your file tree updates, with entries under their new folder
- the file or directory is renamed or moved on disk too, including everything inside a moved folder
- open buffers keep working: their path, buffer name and file watcher are updated

If the target already exists on disk, the plugin leaves the old path alone and warns you instead of overwriting anything.

## ↩️ Undo that respects your collaborators

Overleaf buffers use their own undo stack. Vim's undo restores old text for whole regions, which would silently revert your collaborators' edits too. Here:

- `u` and `<C-r>` (buffer-local, counts like `3u` work) only undo and redo **your own** changes
- consecutive typing, and consecutive insert-mode deletions, are grouped into one step; a collaborator's edit starts a new one
- each step is checked before it runs. If a collaborator edited the exact text a step would change, the step is skipped with a message instead of overwriting their work
- Vim's native undo is turned off for these buffers, so `:undo`, `:redo` and `U` do nothing there
- the history lives for one session and is not saved to disk. A full buffer replacement (after a rejoin, say) makes older steps unusable, and they are skipped safely

## 🛟 Sync and rejoin

**Downloading the project 📥.** On connect (and on `:Overleaf sync`) every text document is fetched and written to disk, and binary files such as images are downloaded if they are not on disk yet. Fetches run three at a time and each is retried up to three times. If any still fail, a warning lists exactly which files.

**Rejoin.** If the editor and the server drift apart (a version mismatch or a failed update), the plugin rejoins the document, and your unsynced edits survive:

- if their surroundings can be found unambiguously in the server's text, they are merged on top of it and sent again
- otherwise your version is saved to `~/.local/state/nvim/overleaf-conflicts/<path>.<timestamp>.bak`, and you get a warning with the path

**Concurrent edits.** Multi-part edits (like replace = delete + insert) and edits that overlap a collaborator's are transformed correctly, and any keystroke not yet processed is folded in before a remote edit is applied, so your buffer and the server's view stay aligned.

## 🔨 Compile and PDF preview

With `sync_dir` set, the plugin compiles your synced files with latexmk (pdfTeX, XeLaTeX and LuaTeX all work), optionally on every `:w`, and opens the PDF once per compile.

### Okular inverse search 🔙

To Shift+click in the PDF and land on the source line:

1. Open Okular → Settings → Editor
2. Set Command to: `nvim --remote-expr "OlInverseSearch('{file}',{line})"`
3. Save and restart Okular

The plugin sets Okular up as the vimtex viewer with synctex support for you.

## 📝 Logging

- 🗒️ **Log file:** everything (debug and up) goes in full to `~/.local/state/nvim/overleaf.log` (`vim.fn.stdpath('state') .. '/overleaf.log'`). Follow it with `tail -f`, or open it in a split with `:lua require('overleaf.config').show_log()` (or `:OverleafLog`).
- 🖥️ **On screen:** only messages at or above `log_level` (default `warn`) show, and they never trigger "Press ENTER":
  - info and debug appear as one short, truncated line
  - warnings and errors show their **full text**: a short one as a normal notification, a long or multi-line one in a floating popup in the top-right corner that closes itself after `popup_ms` (default 12 s)

## ⚙️ Configuration

```lua
require('overleaf').setup({
  -- Path to .env file containing OVERLEAF_COOKIE (default: '.env')
  env_file = '.env',

  -- Session cookie (overrides .env)
  cookie = nil,

  -- Path to Node.js binary (default: 'node')
  node_path = 'node',

  -- Overleaf instance URL (default: 'https://www.overleaf.com')
  base_url = 'https://www.overleaf.com',

  -- PDF viewer command (nil = auto-detect: 'open' on macOS, 'xdg-open' on Linux)
  pdf_viewer = nil,

  -- PDF output directory (nil = system temp directory)
  pdf_dir = nil,

  -- Local sync directory for external tools and local compiling (default: nil = disabled)
  -- When set: documents are mirrored to disk, latexmk compiles locally,
  -- and external changes sync back
  sync_dir = '~/.overleaf',

  -- Minimum level shown on screen: 'debug', 'info', 'warn', 'error' (default: 'warn')
  log_level = 'warn',

  -- Minimum level written to the log file; 'off' disables it (default: 'debug')
  log_file_level = 'debug',

  -- Log file location (nil = stdpath('state')/overleaf.log)
  log_file = nil,

  -- How long a long warning/error popup stays open, in ms (default: 12000)
  popup_ms = 12000,

  -- Watch sync_dir and upload new local files automatically (default: false)
  auto_upload = false,

  -- Only auto-upload these extensions (nil = anything that is not ignored)
  auto_upload_ext = { 'png', 'jpg', 'jpeg', 'pdf', 'svg', 'eps', 'csv', 'bib', 'tex', 'sty' },

  -- Upload even if the path already exists in the project (default: false = skip)
  upload_overwrite = false,

  -- Set to false to disable the default keymaps
  keys = true,
})
```

## 🤖 Working with external tools (Claude Code and friends)

Normally Overleaf documents are virtual buffers with no file on disk, so external tools can't see them. Set `sync_dir` and that changes:

```lua
require('overleaf').setup({
  sync_dir = '~/.overleaf',  -- or any directory
})
```

When you connect, all text documents are mirrored to `~/.overleaf/<project-name>/`. External tools can read and edit those files, and changes sync back to Overleaf automatically.

**How it works**

- 📥 **On connect:** all documents and binary files are fetched and written to disk
- ⌨️ **Neovim edits:** debounced writes keep the disk files current
- 🌐 **Remote edits:** disk files are updated when collaborators edit
- 🔄 **Remote renames and moves:** files and folders on disk follow
- 🛠️ **External edits:** file watchers detect changes and send them to Overleaf via OT
  - open documents: the buffer is updated, which triggers the normal OT pipeline
  - closed documents: the change goes straight through the bridge
- 📤 **New local files:** uploaded automatically if `auto_upload` is on

**Sync commands**

- `:Overleaf sync` — re-sync everything (fetch from Overleaf, write to disk)
- `:Overleaf sync import` — push all external disk changes to Overleaf
- `:Overleaf sync export` — write all documents to disk

**Using Claude Code**

```bash
cd ~/.overleaf/My\ Project
claude
```

Claude Code can now read all your LaTeX files, and its edits sync back to Overleaf live. ✨

## 🩹 Troubleshooting

- **`File ... not found` while compiling:** look at the path in the `.tex` file first. A bare filename only works if `\graphicspath` covers its folder; otherwise use the full path from the project root (for example `Pictures/B/plot.png`).
- **A `fontspec` font error:** the font exists on Overleaf but not on your machine. Install it, or use a metric-compatible free font (Tinos or Liberation Serif for Times New Roman).
- **A warning says documents could not be downloaded:** it lists them. Run `:Overleaf sync` to retry, and look in the log file for the error.
- **"Rejoin replaced unsynced edits":** your text was saved under `~/.local/state/nvim/overleaf-conflicts/`. Copy back what you need.
- **A restore went wrong:** your open buffers were saved to `~/.local/state/nvim/overleaf-restore-backup/<timestamp>/` first, and the restore itself is a new version in Overleaf's history, so you can restore back.
- **The history summary shows almost everything as changed:** double-check the version you picked. The diff is by content, so a long list means the project really differs from it.
- **Anything else:** full details, including debug output, are in `~/.local/state/nvim/overleaf.log`.

## 🔧 How it works

The plugin starts a Node.js bridge process that connects to Overleaf's real-time collaboration server over Socket.IO. Your edits are turned into OT operations and sent to the server, and other people's edits are transformed and applied to your buffer as they arrive.

With `sync_dir` enabled, documents are mirrored to disk and compiled locally with latexmk. Changes from external tools or other users are detected and synced both ways. Compile results show up through `vim.diagnostic` and the quickfix list, and Okular's forward and inverse search work through vimtex.

## ⚠️ Disclaimer

This is an **unofficial** plugin. It is not affiliated with, endorsed by, or supported by [Overleaf](https://www.overleaf.com). It relies on Overleaf's internal real-time protocol, which is undocumented and can change at any time. A change could make the plugin stop working or, in the worst case, cause document corruption or data loss.

Overleaf keeps a version history for every project, so you can restore earlier versions from the web interface if something goes wrong.

**Use at your own risk, and keep backups of important work.** 💾

## 🤖 AI-assisted development

Parts of this plugin were written with the help of an AI assistant ([Claude](https://claude.ai) by Anthropic), including much of the undo stack, the sync and rejoin logic, the history diff and restore, the statusline and the compile-error parsing. I direct the work, run it against my own Overleaf projects, and review and test the changes, but AI-written code can contain mistakes that I haven't found yet.

Because this plugin edits live documents and can restore whole projects, please treat it with the same care as any young software: keep backups, try risky features (such as restoring a version) on a throwaway project first, and report anything odd as an issue.

## 🙏 Acknowledgments

- [overleaf.nvim by richwomanbtc](https://github.com/richwomanbtc/overleaf.nvim), where this project started
- [AirLatex.vim](https://github.com/dmadisetti/AirLatex.vim) (MIT) by David Hartmann, a Neovim plugin for Overleaf. Referenced for the Chrome cookie extraction approach and Socket.IO connection patterns.
- [Overleaf-Workshop](https://github.com/iamhyc/Overleaf-Workshop) (AGPL-3.0), a VS Code extension for Overleaf. Referenced for protocol details such as the v2 connection scheme, OT update hashing and `joinDoc` parameters.

The code here is an independent implementation in Lua and Node.js, and no source code was copied from the two reference projects.

## 📜 License

MIT
