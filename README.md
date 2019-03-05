# git-checkout-pull-request-action

> GitHub Action to assure code is checked out from pull requests

A GitHub action has access to the git repository. But when an action is triggered on `pull_request` and said pull request is coming from a fork, the pull request base is checked out, not its head. This action assures that the code is checked out correctly, no matter if the pull request comes from a fork or not.

## Example workflow

This workflow shows how to run `npm test` on pull requests

```workflow
workflow "Test" {
  on = "pull_request"
  resolves = ["npm test"]
}

action "checkout pull request" {
  uses = "gr2m/git-checkout-pull-request-action@master"
  secrets = ["GITHUB_TOKEN"] # Token needed for private repositories only
}

action "npm ci" {
  needs = "checkout pull request"
  uses = "docker://node:alpine"
  runs = "npm"
  args = "ci"
}

action "npm test" {
  needs = "npm ci"
  uses = "docker://node:alpine"
  runs = "npm"
  args = "test"
}
```

## License

[MIT](LICENSE)