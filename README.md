<a name="get"></a>

[![Build Status][travis-badge]][travis-link]
[![Slack Room][slack-badge]][slack-link]

# Get

**Get** is an interactive prompt reader for Fish. Use with `read(1)` to validate and store user input such as passwords and other data into variables.

## Install

With [Fisherman][fisherman]:

```fish
fisher install get
```

## Usage

By default, **get** prints the user input to standard output, so in this way it's not so different from `read(1)`.

```fish
get
```

![get](https://cloud.githubusercontent.com/assets/8317250/12975202/18dcee84-d0fd-11e5-9f4c-00348f3c7ede.gif)


Use `--prompt=<msg>` to display a prompt.

```fish
get --prompt "What's your name?\n-> "
```

![get](https://cloud.githubusercontent.com/assets/8317250/12975420/d32db93e-d0fe-11e5-813e-fb17c4935824.gif)


Use `--rule=<regex>` to validate the user input.

```fish
get --prompt="Enter a number:" --rule="[0-9]"
```

![get](https://cloud.githubusercontent.com/assets/8317250/12975525/d6f3ea60-d0ff-11e5-8180-2ec18cd228fa.gif)

Use `--error=<msg>` to display an error message when `--rule=<regex>` fails. The error message can be  `printf(1)` format string and the user input can be displayed using `%s`.

```fish
get --prompt="Enter a number:" --rule="[0-9]" --error="'%s' is not a valid number."
```

![get](https://cloud.githubusercontent.com/assets/8317250/12975598/50a6f9a6-d100-11e5-8d98-e7f28e125462.gif)

Use `--silent` to hide the user input and read a password into a variable.

```fish
get --prompt="Enter your password:" --silent
```

![get](https://cloud.githubusercontent.com/assets/8317250/12975660/e2514dac-d100-11e5-9464-0d926e65d7d5.gif)

Using `--silent` in combination with `--rule` and `--error` will hide the input from the error message using a star character `*`.

```fish
get --prompt="Enter your password:" --rule="[0-9]" --error="Invalid password '%s'" --silent
```

![get-6](https://cloud.githubusercontent.com/assets/8317250/12975740/7a158428-d101-11e5-9845-c514a0a4959e.gif)


Use `--no-cursor` to hide the cursor and `--count=<number>` to force reading up to `<number>` of characters.

```fish
get --prompt="Press any key to continue..." --count=1 --no-cursor --silent
```

![get](https://cloud.githubusercontent.com/assets/8317250/12975814/46e77664-d102-11e5-9379-29590c29e87d.gif)



## Options


## Documentation

See [`get(1)`][get-1] to read this document in you command line.

<!-- Badges -->

[slack-link]: https://fisherman-wharf.herokuapp.com/
[slack-badge]: https://img.shields.io/badge/slack-join%20the%20chat-00B9FF.svg?style=flat-square

[travis-link]: https://travis-ci.org/fishery/get
[travis-badge]: https://img.shields.io/travis/fishery/get.svg?style=flat-square

<!-- Install  -->

[fisherman]: https://github.com/fisherman/fisherman

<!-- Documentation -->

[get-1]: man/man1/get.md
