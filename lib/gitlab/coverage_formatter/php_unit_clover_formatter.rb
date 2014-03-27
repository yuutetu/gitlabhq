require "rexml/document"

module Gitlab
  module CoverageFormatter
    module PhpUnitCloverFormatter
      extend self

      # parse response
      def parse response, project, path
        parse_result = []

        if response.headers['Content-Type'] == "application/octet-stream"
          document = ::REXML::Document.new(response.body)
          file = document.elements["coverage/project/file[@name='#{project.coverage_base_path}#{path}']"]
          if file
            file.elements.each "line" do |line|
              parse_result[line.attributes["num"].to_i-1] = line.attributes["count"].to_i
            end
          end
          parse_result
        end
        parse_result
      end

      # short description
      def desc
        "PHP/PHPUnit/CloverXML"
      end
    end
  end
end