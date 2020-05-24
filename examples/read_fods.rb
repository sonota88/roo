$LOAD_PATH.unshift File.expand_path('../lib', __dir__)
TEST_FILE_DIR = File.expand_path('../test', __dir__)

require 'roo'

module Roo
  class LibreOfficeFlatXml < LibreOffice
    def supported_extension
      '.fods'
    end

    def open_oo_file(options)
      roo_content_xml_path = ::File.join(@tmpdir, 'roo_content.xml')
      FileUtils.cp @filename, roo_content_xml_path
    end

    def cell_elements(table_element)
      table_element.children
        .reject { |child| child.is_a? Nokogiri::XML::Text }
    end
  end
end


lo = Roo::LibreOffice.new(File.join(TEST_FILE_DIR, 'files/simple_spreadsheet.ods'))
lo.default_sheet = lo.sheets.first
p lo.cell('b', 3)
#=> "Start time"

lofx = Roo::LibreOfficeFlatXml.new(File.join(TEST_FILE_DIR, 'files/simple_spreadsheet.fods'))
lofx.default_sheet = lofx.sheets.first
p lofx.cell('b', 3)
#=> "Start time"
