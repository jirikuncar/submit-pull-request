# Publish pull request with Github Action

An action that publishes a pull request.

## Usage

Minimal example for submiting pull request to the same repository.

```yaml
- name: Publish pull request
  uses: jirikuncar/pushlish-pull-request@master
  with:
    github_token: ${{ secrets.GITHUB_TOKEN }}
    head: ${{ github.pull_request.head.ref }}
```
