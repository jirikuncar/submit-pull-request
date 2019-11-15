FROM ruby:slim

# https://github.com/octokit/octokit.rb/issues/1155
RUN gem install faraday -v 0.15.4 && \
    gem install octokit

COPY LICENSE README.md /

COPY entrypoint.rb /entrypoint.rb

ENTRYPOINT ["/entrypoint.rb"]
