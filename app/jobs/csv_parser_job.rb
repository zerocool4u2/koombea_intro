class CsvParserJob < ApplicationJob
  queue_as :default

  def perform(csv_file)
    csv_file.parse_contacts
  end
end
