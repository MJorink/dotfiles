# ~/.bashrc: interactive bash
PS1='\w \$ '
set -o vi
bind 'set show-mode-in-prompt on'
# mode strings are drawn at the right edge: save cursor, jump right, print, restore
bind 'set vi-ins-mode-string "\1\e7\e[999C\e[4D(ins)\e8\2"'
bind 'set vi-cmd-mode-string "\1\e7\e[999C\e[4D(cmd)\e8\2"'

alias ..='cd ..'
alias ls='ls -a'
alias lg='lazygit'
alias vim='nvim'
