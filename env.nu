$env.STARSHIP_SHELL = "nu"

def create_left_prompt [] {
    starship prompt --cmd-duration $env.CMD_DURATION_MS $'--status=($env.LAST_EXIT_CODE)'
}

# Use nushell functions to define your right and left prompt
$env.PROMPT_COMMAND = { || create_left_prompt }
$env.PROMPT_COMMAND_RIGHT = ""

# The prompt indicators are environmental variables that represent
# the state of the prompt
$env.PROMPT_INDICATOR = ""
$env.PROMPT_INDICATOR_VI_INSERT = ": "
$env.PROMPT_INDICATOR_VI_NORMAL = "〉"
$env.PROMPT_MULTILINE_INDICATOR = "::: "

# Specifies how environment variables are:
# - converted from a string to a value on Nushell startup (from_string)
# - converted from a value back to a string when running external commands (to_string)
# Note: The conversions happen *after* config.nu is loaded
let-env ENV_CONVERSIONS = {
  "PATH": {
    from_string: { |s| $s | split row (char esep) | path expand --no-symlink }
    to_string: { |v| $v | path expand --no-symlink | str join (char esep) }
  }
  "Path": {
    from_string: { |s| $s | split row (char esep) | path expand --no-symlink }
    to_string: { |v| $v | path expand --no-symlink | str join (char esep) }
  }
}

# Directories to search for scripts when calling source or use
#
# By default, <nushell-config-dir>/scripts is added
let-env NU_LIB_DIRS = [
    ($nu.default-config-dir | path join 'scripts')
]

# Directories to search for plugin binaries when calling register
#
# By default, <nushell-config-dir>/plugins is added
let-env NU_PLUGIN_DIRS = [
    ($nu.default-config-dir | path join 'plugins')
]

# To add entries to PATH (on Windows you might use Path), you can use the following pattern:
# let-env PATH = ($env.PATH | split row (char esep) | prepend '/some/path')

$env.EDITOR = nvim

alias la = ls -a
alias cp = cp -r

alias vim = nvim
def cls [] { clear; ls }
def cla [] { clear; ls -a }
def fetch [] { clear; neofetch }

def connect [] {
    let choice = (gum choose "noah" "root")
    let target = $choice + "@mondkuchen.tech"
    ssh $target
}

alias mem = loop { clear; print (sys | get mem); sleep 2sec }
# cpu takes too long...
alias stats = loop {
    clear; print (sys | get cpu | reject brand vendor_id); print (sys | get mem); sleep 2sec
}

def switchvim [] {
    let choice = (gum choose "kickstart" "nyoom" "scratch")
    let current = (open ~/.config/nvim-configs/current)

    if $choice == $current {
        print ($choice + " is already set!")
        return
    } else {
        if $current == "kickstart" {
            mv ~/.config/nvim/* ~/.config/nvim-configs/kickstart/
        } else if $current == "nyoom" {
            mv ~/.config/nvim/* ~/.config/nvim-configs/nyoom/
        } else if $current == "scratch" {
            mv ~/.config/nvim/* ~/.config/nvim-configs/scratch/
        }

        if $choice == "kickstart" {
            mv ~/.config/nvim-configs/kickstart/* ~/.config/nvim
        } else if $choice == "nyoom" {
            mv ~/.config/nvim-configs/nyoom/* ~/.config/nvim
        } else if $choice == "scratch" {
            mv ~/.config/nvim-configs/scratch/* ~/.config/nvim
        }

        print ($'set to (ansi purple)' + $choice + (ansi reset))
        $choice | save -f ~/.config/nvim-configs/current
    }
}



def choose [pool: list] {
    let choice = ($pool | gum choose)
    if $choice == '' { return (-1) }
    let result = ($choice | split chars | $in.2? | into int)
    $result
}

def conf [] {
    let configs = [nu pkgs nvim starship zellij tmux]
    let paths = [
        '~/.config/nushell/env.nu',
        '~/pkgs.toml',
        '~/.config/nvim',
        '~/.config/starship.toml',
        '~/.config/zellij/config.kdl',
        '~/.config/tmux.conf'
    ]
    let choice = (choose $configs)
    if $choice == (-1) {
        return 
    }
    let path = ($paths | get $choice)
    nvim $path
}

# Nixos aliases
alias nixconf = sudoedit /etc/nixos/configuration.nix
alias nixrebuild = sudo nixos-rebuild switch
alias nuconf = nvim $nu.env-path

def toadd [pkg: string] {
    let pkgln = $pkg + "\n"
    $pkgln | save --append ~/toadd
}

def lspkgs [] {
    nix-store --query --requisites /run/current-system | fzf
}

# rust aliases
def cargobuild [lvl?: int] {
    if $lvl == null {
        gum spin --title $"Building with (ansi cyan)no(ansi reset) optimization..." --show-output -- cargo build
    } else if $lvl == 1 {
        gum spin --title $"Building with (ansi gb)basic(ansi reset) optimizations..." --show-output -- cargo --config profile.release.opt-level=1 build -r --profile release
    } else if $lvl == 2 {
        gum spin --title $"Building with (ansi yb)some(ansi reset) optimizations..." --show-output -- cargo --config profile.release.opt-level=2 build -r --profile release
    } else if $lvl == 3 {
        gum spin --title $"Building with (ansi rb)all(ansi reset) optimizations..." --show-output -- cargo --config profile.release.opt-level=3 build -r --profile release
    } else {
        print "Unknown optimization level, aborting..."
    }
}
def cargorun [lvl?: int] {
    if $lvl == null {
        cargo run
    } else if ($lvl >= 1 and $lvl <= 3) {
        let arg = "profile.release.opt-level=" + ($lvl | into string)
        cargo --config $arg run -r --profile release
    } else {
        print "Unknown optimization level, aborting..."
    }
}
alias oxide = cargorun 3

alias cr = cargorun
alias cb = cargobuild













