#!/bin/sh

# _____________
# |  |        |
# |  |        |
# |__|________|
# |     |     |
# |_____|_____|

# create 3 panes and open the current directory in vim

tmux split-window -v -p 25
tmux split-window -h -p 50
tmux selectp -t 1
vim .
