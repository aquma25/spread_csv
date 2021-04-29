#Google Spreadsheetに処理を書き込んでいくスクリプト

require "google_drive"
require_relative "recombined_data"
require_relative "mysql_access"

puts "Process Start"

session = GoogleDrive::Session.from_config("config.json")

SPREAD_SHEET_PATH = ARGV[0]
SHEET_TAB_NAME    = ARGV[1]
SQL_ENV           = ARGV[2]
QUERY             = ARGV[3]

spread_sheet = session.spreadsheet_by_url(SPREAD_SHEET_PATH)
work_sheet   = spread_sheet.worksheet_by_title(SHEET_TAB_NAME)

wws = if SQL_ENV.nil?
        RecombinedData.new(work_sheet).run
      else
        MysqlAccess.new(work_sheet, SQL_ENV, QUERY).run
      end

wws.save

puts "Process Finish"
