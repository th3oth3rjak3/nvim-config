# Portable Neovim on Windows

This repository is the Neovim configuration directory.

It assumes this relative layout:

```text
nvim-win64/
├── bin/
│   └── nvim.exe
└── config/                ← this Git repository
    ├── init.lua
    ├── lua/
    └── nvim-portable.cmd
```

## Portable launcher

Create `nvim-portable.cmd` in this repository's root (`config/`) with:

```bat
@echo off
setlocal

rem The launcher is in config/, so its parent is the Neovim root.
for %%I in ("%~dp0..") do set "NVIM_ROOT=%%~fI"

rem Neovim configuration: <NVIM_ROOT>\config
set "XDG_CONFIG_HOME=%NVIM_ROOT%"
set "NVIM_APPNAME=config"

rem Runtime files remain beside the portable installation.
set "XDG_DATA_HOME=%NVIM_ROOT%\data"
set "XDG_STATE_HOME=%NVIM_ROOT%\state"
set "XDG_CACHE_HOME=%NVIM_ROOT%\cache"

rem Forward all supplied arguments to Neovim.
"%NVIM_ROOT%\bin\nvim.exe" %*
```

The launcher uses its own location to calculate all paths. No user-specific path is embedded in the file.

## Launching Neovim

From the `config` repository folder:

```powershell
.\nvim-portable.cmd
```

Open the current folder:

```powershell
.\nvim-portable.cmd .
```

Open a file:

```powershell
.\nvim-portable.cmd .\init.lua
```

The launcher sets `XDG_CONFIG_HOME`, `XDG_DATA_HOME`, `XDG_STATE_HOME`, and `XDG_CACHE_HOME` only for the Neovim process it starts. It does not depend on permanent Windows environment variables.

## Optional `nv` command for the current PowerShell session

PowerShell already uses `nv` as an alias for `New-Variable`, so it must be replaced.

From the `config` repository folder, run:

```powershell
$env:Path = "$(Get-Location);$env:Path"
Set-Alias -Name nv -Value nvim-portable.cmd -Option AllScope -Force
```

Then use:

```powershell
nv
nv .
nv .\init.lua
```

The first command adds the current repository folder to `PATH` for this PowerShell session only. The second command makes `nv` run `nvim-portable.cmd`.

This is intentionally session-specific: it keeps the repository portable and avoids storing a machine-specific absolute path in a PowerShell profile.

## Plugin data

Plugin managers such as `lazy.nvim` can use Neovim's standard paths:

```lua
vim.fn.stdpath("data")
vim.fn.stdpath("state")
vim.fn.stdpath("cache")
```

When Neovim is started through `nvim-portable.cmd`, those paths resolve under the portable Neovim installation instead of Windows AppData.

## Version control

Track configuration files, including:

```text
init.lua
lua/
nvim-portable.cmd
lazy-lock.json
```

Do not add generated runtime directories to this repository. The launcher places them outside this repository as sibling directories:

```text
../data/
../state/
../cache/
```
