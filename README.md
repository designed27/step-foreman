# Foreman step

Install Heroku's Foreman. Optionally, run a command through foreman.

Issues and Pull Requests are encouraged and welcome on [github](https://github.com/designed27/step-foreman)!

Based on [wercker/step-heroku-deploy](https://github.com/wercker/step-heroku-deploy).


# What's new

- Installs full heroku toolbelt.

# Options

*  `run` (optional) Run a command through Foreman. This option can be used to run tests with the .env file active for example.
   
   The value supplied to `run` is injected as 'command' in `$ foreman run 'command'` 

*  `options` (optional, only used with run) Inject flags before the run command.

    For example, set `options: "--env .custom-env-file"` to pass any flags to `foreman`.

# Example

``` yaml
deploy:
    steps:
        - designed27/foreman-step:
            run: behave
```

# License

The MIT License (MIT)

# Changelog

## 0.0.4

* Add `options` parameter to inject any flags into the `foreman run` command.

## 0.0.3

* Create Readme.

## 0.0.2

* Initial release.
