function get -d "Press any key to continue..."
    set -l rule
    set -l error
    set -l count
    set -l prompt
    set -l stdout /dev/stdout
    set -l hide_input 0
    set -l hide_cursor 0
    set -l ignore_case 0

    getopts $argv | while read -l 1 2
        switch "$1"
            case r rule regex
                set rule "$2"

            case e error
                set error "$2"

            case _ p prompt
                set prompt "$2"

            case q quiet
                set stdout /dev/null

            case s silent hide-input
                set hide_input 1
                set count "$2"

            case {no,ignore}-case
                set ignore_case 1

            case {no,hide}-cursor
                set hide_cursor 1

            case h help
                printf "Usage: get [--prompt=<msg>] [--error=<msg>] [--rule=<regex>] [--silent]\n"
                printf "           [--quiet] [--no-case] [--no-cursor] [--help]\n\n"

                printf "    -p --prompt=<msg>  Set the prompt message\n"
                printf "    -r --rule=<regex>  Use regex to validate input\n"
                printf "     -e --error=<msg>  Set the error message\n"
                printf "          --no-cursor  Hide cursor\n"
                printf "            --no-case  Ignore case during validation\n"
                printf "          -s --silent  Hide user input as it is typed\n"
                printf "           -q --quiet  Suppress output\n"
                printf "            -h --help  Show usage help\n"
                return

            case \*
                printf "get: '%s' is not a valid option\n" $1 > /dev/stderr
                get --h > /dev/stderr
                return 1
        end
    end

    if test $hide_input -eq 1
        stty -icanon -echo ^ /dev/null
    end

    if test $hide_cursor -eq 1
        tput civis > /dev/stderr
    end

    if test ! -z "$prompt"
        set prompt "$prompt "
    end

    if test "$count" -le 0
        set -e count
    end

    while true
        set -l done

        printf "$prompt" > /dev/stderr
        tput el > /dev/stderr

        if test -z "$count"
            head -n1
        else
            dd bs=$count count=$count

        end ^ /dev/null | if awk -v rule="$rule" -v ignore_case=$ignore_case '
            {
                print
                exit (ignore_case ? tolower($0) : $0) ~ rule
            }
            '
            set -e done

        end | read -p "" -l input

        if test $hide_input -eq 1
            echo > /dev/stderr
        end

        if set -q done
            tput el > /dev/stderr
            printf "%s\n" $input > $stdout
            break
        else
            tput el > /dev/stderr

            printf "$error\n" $input | awk \
                -v hide_input="$hide_input" \
                -v error="$error" \
                -v input="$input" '

                hide_input {
                    for (i = 1; i <= length(input); i++) {
                        secret = secret "*"
                    }
                    printf(error"\n", secret)
                    exit
                } { print }

            ' > /dev/stderr

            set -l cursor (printf "$prompt$error" | awk '{ n++ } END { print n }')

            echo cuu 1\ncuu $cursor | tput -S > /dev/stderr
        end
    end

    if test $hide_input -eq 1
        stty icanon echo > /dev/stderr ^ /dev/null
    end

    if test $hide_cursor -eq 1
        tput cvvis > /dev/stderr
    end
end
