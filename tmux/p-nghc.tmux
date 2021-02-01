SESSION=a-nghc
HIST_ID=$SESSION.main
new -n $SESSION -s $SESSION

neww -n nghc  -c ~/ "reatuns -l $SHELL"
neww -n tess -c ~/git/tesseract/operations "source ~/.env.nghc dev"
neww -n ops -c ~/git/tesseract/operations.edgeb1 "source ~/.env.nghc dev"
neww -n sb -c ~/git/tesseract/operations.edgeb1 "source ~/.env.nghc sbox"
neww -n sb2 -c ~/git/tesseract/operations.edgeb1 "source ~/.env.nghc sbox2"
neww -n sb3 -c ~/git/tesseract/operations.edgeb1 "source ~/.env.nghc sbox3"
neww -n dev -c ~/git/tesseract/operations.edgeb1 "source ~/.env.nghc dev"
neww -n dev3 -c ~/git/tesseract/operations.edgeb1 "source ~/.env.nghc dev3"
neww -n dev4 -c ~/git/tesseract/operations.edgeb1 "source ~/.env.nghc dev4"
neww -n td1 -c ~/git/tesseract/operations.edgeb1 "source ~/.env.nghc td1"
neww -n prd2 -c ~/git/tesseract/operations.edgeb1 "source ~/.env.nghc prd2"
neww -n prd5x -c ~/git/tesseract/operations.edgeb1 "source ~/.env.nghc prd5x"
neww -n vnv5x -c ~/git/tesseract/operations.edgeb1 "source ~/.env.nghc vnv5x"
# neww -n stg -c ~/git/tesseract/operations.edgeb1 "source ~/.env.nghc stg"
# neww -n prd -c ~/git/tesseract/operations.edgeb1-alt "source ~/.env.nghc aws"
neww -n jk -c ~/git/tesseract/operations.edgeb1 "source ~/.env.nghc aws"
# vim: ft=sh
