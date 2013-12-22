require 'active_support/all'
require 'octokit'

Octokit.configure do |c|
  c.auto_paginate = true
end

class HubMeme
  attr_reader :login

  def initialize(login)
    @login = login
  end

  def meme
    contributed_repositories.sum do |repo, contribution|
      (repo.stargazers_count * contribution).tap do |repo_meme|
        yield repo, contribution, repo_meme if repo_meme.round > 0 && block_given?
      end
    end
  end

  def contributed_repositories
    return enum_for(:contributed_repositories) unless block_given?

    candidate_repositories.each do |repo|
      begin
        contributors = Octokit.contributors(repo.full_name)
      rescue Octokit::NotFound
        next
      end
      own_contribution = 0
      total_contributions = contributors.sum do |contributor|
        if contributor.login == login
          own_contribution = contributor.contributions
        end
        contributor.contributions
      end
      if own_contribution.nonzero?
        yield repo, own_contribution.to_f / total_contributions
      end
    end
  end

  def candidate_repositories
    (user_repositories +
      organization_repositories +
      starred_repositories +
      watched_repositories +
      pull_requested_repositories).
      reject { |repo| repo.fork || repo.private }.
      uniq { |repo| repo.name }.
      sort_by { |repo| repo.full_name.downcase }
  end

  def user_repositories
    Octokit.repositories(login, :query => {:type => 'all'})
  end

  def organization_repositories
    organizations.flat_map do |org|
      Octokit.organization_repositories(org.login)
    end
  end

  def organizations
    Octokit.organizations(login, :query => {:type => 'all'})
  end

  def starred_repositories
    Octokit.starred(login)
  end

  def watched_repositories
    Octokit.watched(login)
  end

  def pull_requested_repositories
    Octokit.user_public_events(login).
      select { |event| event.type == 'PullRequestEvent' }.
      map { |event| event.payload.pull_request.base.repo }
  end
end
