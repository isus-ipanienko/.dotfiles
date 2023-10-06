autoload -U colors && colors

autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git svn
zstyle ':vcs_info:git:*' formats '‹%b›'
precmd() { vcs_info }
setopt prompt_subst

source ~/.zsh/zsh-fzf/fzf-zsh-plugin.plugin.zsh
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# PROMPT
local user_color="%{$fg[blue]%}"
local host_color="%{$fg[cyan]%}"
local dir_color="%{$fg[green]%}"
local ret_color="%{$fg[red]%}"
local git_color="%{$fg[red]%}"
local no_color="%{$reset_color%}"

local user_host="$user_color╭─%n$no_color$host_color@%m$no_color"
local current_dir="$dir_color%~$no_color"
local git_branch='$git_color${vcs_info_msg_0_}$no_color' # vcs_info needs single quotes
local user_symbol="$user_color╰─%(!.#.$)$no_color"
local return_code="%B%(?..$ret_color%? ↵$no_color)%b"

PROMPT="${user_host} ${current_dir} ${git_branch}
${user_symbol} "
RPROMPT="${return_code}"

PATH="$PATH:$HOME/.scripts"
SAVEHIST=1000
HISTFILE=~/.zsh_history

