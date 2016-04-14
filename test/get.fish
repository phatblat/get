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
