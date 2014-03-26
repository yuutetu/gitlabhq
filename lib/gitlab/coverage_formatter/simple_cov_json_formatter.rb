module Gitlab
  module CoverageFormatter
    module SimpleCovJsonFormatter
      extend self

      # parse response
      def parse response, project, path
        if response.headers['Content-Type'] == "application/json"
          json = JSON.parse(response.body)
          json["files"].each do |file_hash|
            if file_hash['filename'] == "#{project.coverage_base_path}#{path}"
              return file_hash["coverage"]
            end
          end
        end
        []
      end

      # short description
      def desc
        "Rails/SimpleCov/Json"
      end
    end
  end
end