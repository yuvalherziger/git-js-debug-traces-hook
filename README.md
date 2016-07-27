# What is git-js-debug-traces-hook?
Just a small git pre-commit hook that is aimed towards catching traces of debugging code you may have forgotten, specifically in JavaScript/CoffeeScript files that are intended to be exposed.

# How to install

```bash
~ cp pre-commit.sh /path/to/your/project/.git/hooks/pre-commit
~ chmod +x /path/to/your/project/.git/hooks/pre-commit
```

# What to expect

Assuming you forgot to remove a `console.log(this);` line here and a `debugger;` breakpoint, you commit your changes and then the pre-commit hook throws this wonderful tantrum at you:

![Throw a tantrum](/screenshots/tantrum.png "Optional Title")

# What to do when you actually want to commit debugging code

```bash
~ git commit --no-verify
```
