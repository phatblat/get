set -l fixtures $DIRNAME/fixtures

test "$TESTNAME - Read input and write it to standard output"
    (echo foo | get) = foo
end

test "$TESTNAME - Use --silent=num to read up to an arbitrary number of characters"
    (echo foo | get --silent=1 ^ /dev/null) = f
end

test "$TESTNAME - Use --prompt=msg to display a prompt"
    (cat $fixtures/prompt) = (echo | get --prompt=foo ^& 1)
end

test "$TESTNAME - Use --rule=regex to validate user input"
    123 = (
        echo 123 | get --rule="[0-9]"
        )
end

test "$TESTNAME - Display usage help"
    "Usage: get [--prompt=<msg>] [--error=<msg>] [--rule=<regex>] [--silent] [--quiet] [--no-case] [--no-cursor] [--help] -p --prompt=<msg> Set the prompt message -r --rule=<regex> Use regex to validate input -e --error=<msg> Set the error message --no-cursor Hide cursor --no-case Ignore case during validation -s --silent Hide user input as it is typed -q --quiet Suppress output -h --help Show usage help" = (
        get -h | xargs
        )
end
