SESSION=a-local
HIST_ID=$SESSION.main
new -n $SESSION -s $SESSION

neww -n admin "reatuns -l $SHELL"
neww -n sh      "reatuns -l $SHELL"
neww -n tmp      "cd ~/tmp; reatuns -l $SHELL"
neww -n dn      "cd ~/Downloads; reatuns -l $SHELL"
neww -n l       "cd ~/l; reatuns -l $SHELL"
neww -n g       "cd ~/g; reatuns -l $SHELL"
neww -n trn     "cd ~/l/training; reatuns -l $SHELL"
# vim: fg=sh
