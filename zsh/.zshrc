source ~/.zsh/zsh-fzf/fzf-zsh-plugin.plugin.zsh
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# PROMPT
local user_host="%B%(!.%{$fg[red]%}.%{$fg[green]%})%n@%m%{$reset_color%} "
local current_dir="%B%{$fg[blue]%}%~ %{$reset_color%}"
local user_symbol='%(!.#.$)'
local return_code="%(?..%{$fg[red]%}%? ↵%{$reset_color%})"
PROMPT="╭─${user_host}${current_dir}
╰─%B${user_symbol}%b "
RPROMPT="%B${return_code}%b"
