SESSION=a-sgPete
HIST_ID=$SESSION.main
new -n $SESSION -s $SESSION

neww -n home  -c ~/ "reatuns -l $SHELL"
neww -n sgPete -c ~/git/ASE/sas-ops "reatuns -l $SHELL"
neww -n sgPete-upstream -c ~/git/ASE/sas-ops "reatuns -l $SHELL"
neww -n sgPete-edgeb1 -c ~/git/ASE/sas-ops.edgeb1 "reatuns -l $SHELL"
neww -n sgPete-buki -c ~/git/ASE/sas-ops.adenijib "reatuns -l $SHELL"
neww -n otss -c ~/git/ASE/sas-ops "reatuns -l $SHELL"
neww -n sgp-711 -c ~/git/ASE/sas-ops.edgeb1 "reatuns -l $SHELL"
neww -n ssh -c ~/git/ASE/sas-ops.edgeb1 "reatuns -l $SHELL"
neww -n jenkins -c ~/git/ASE/sas-ops.edgeb1 "reatuns -l $SHELL"
# vim: ft=sh
