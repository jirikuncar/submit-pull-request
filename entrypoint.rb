#!/usr/bin/env ruby
# frozen_string_literal: true

require 'json'
require 'octokit'

# Retrieve inputs from environment variables
access_token = ENV["INPUT_ACCESS_TOKEN"]
head = ENV["INPUT_HEAD"]
# ... optional inputs
base = ENV["INPUT_BASE"]
title = ENV["INPUT_TITLE"]
body = ENV["INPUT_BODY"]
repo = ENV["INPUT_REPO"]

begin
  client = Octokit::Client.new(:access_token => access_token)

  if repo.empty?
    repo = ENV["GITHUB_REPOSITORY"]
  end

  if title.empty?
    prefix = "heads/"
    ref = head.split('/').last.prepend(prefix)
    response = client.ref(repo, ref)
    sha = response["object"]["sha"]
    response = client.commit(repo, sha)
    title = response["commit"]["message"]
  end

  pull_request = client.create_pull_request(repo, base, head, title, body)
  number = pull_request["number"]
  puts "==> Submitted new pull request \##{number} \"#{title}\""
  puts "::set-output name=number::#{number}"
rescue StandardError => e
  puts "==> Error: #{e.message}"
  exit(1)
end
