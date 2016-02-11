set -l IFS \t

get -h | __fisher_complete get
complete -xc get -d "Press any key to continue..." -a "\t"
