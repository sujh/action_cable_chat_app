# README

This is the base app for [*Learn Enough Action Cable to Be Dangerous*](https://www.learnenough.com/action-cable).

To get started, fork the repo and clone it to your local machine, then run the following commands:

```
bundle install --without production
rake db:create
rake db:migrate
rake db:seed
rake test
```

The base app doesn't use Action Cable, but rather is designed as the starting point for the tutorial. To see the state of the app at the *end* of the tutorial, switch to the `action-cable-reference` branch:

```
git checkout action-cable-reference
```

When following the tutorial, you should be able to resolve any discrepancies by comparing with this reference app.