class Projects::CoverageController < Projects::ApplicationController
  include ExtractsPath

  # Authorize
  before_filter :authorize_read_project!
  before_filter :authorize_code_access!
  before_filter :require_non_empty_project

  before_filter :blob

  def show
  end

  private

  def blob
    @blob ||= @repository.blob_at(@commit.id, @path)

    return not_found! unless @blob

    @blob
  end
end
