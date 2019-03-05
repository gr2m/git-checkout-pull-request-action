workflow "Checkout code from pull request" {
  on = "pull_request"
  resolves = ["smoke test"]
}

action "smoke test" {
  uses = "./"
}
