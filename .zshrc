setopt promptsubst # reevaluate PS1 each time it's displaying a prompt

export PS1="%{$(tput setaf 34)%}"$'${(r:$COLUMNS::\u2500:)}'"%{$(tput setaf 46)%}%~ %{$(tput sgr0)%}%# "
export RPROMPT="%(?.%{$(tput setaf 34)%}[✓].%{$(tput setaf 196)%}[%?])%{$(tput sgr0)%}"

export LC_ALL=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8

