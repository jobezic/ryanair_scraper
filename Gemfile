# frozen_string_literal: true

source 'https://rubygems.org'

ruby File.read('.ruby-version').strip[/\A[^-]+/]

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

gem 'rspec'
gem 'webmock'
