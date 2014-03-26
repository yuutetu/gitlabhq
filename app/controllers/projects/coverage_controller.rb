class Projects::CoverageController < Projects::ApplicationController
  include ExtractsPath

  # Authorize
  before_filter :authorize_read_project!
  before_filter :authorize_code_access!
  before_filter :check_for_coverage_enable!
  before_filter :require_non_empty_project

  before_filter :blob

  def show
    response = Faraday.get @project.coverage_url_with_commit_id @commit.id
    formatter = Object.const_get("Gitlab")
                      .const_get("CoverageFormatter")
                      .const_get(@project.coverage_parse_type.classify)
    @coverage = formatter.parse response, @project, @path
  end

  private

  def blob
    @blob ||= @repository.blob_at(@commit.id, @path)

    return not_found! unless @blob

    @blob
  end

  def check_for_coverage_enable!
    return not_found! unless @project.coverage_enabled
  end
end
