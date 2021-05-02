#Google Spreadsheetに処理を書き込んでいくMain処理

require "google_drive"
require_relative "recombined_data"
require_relative "mysql_access"

puts "Process Start"

session = GoogleDrive::Session.from_config("config.json")

SPREAD_SHEET_PATH = ARGV[0]
SHEET_TAB_NAME    = ARGV[1]
SQL_ENV           = ARGV[2]
DB_NAME           = ARGV[3]
TABLE_NAME        = ARGV[4]

spread_sheet = session.spreadsheet_by_url(SPREAD_SHEET_PATH)
work_sheet   = spread_sheet.worksheet_by_title(SHEET_TAB_NAME)

#jsonからまたはmysqlからデータを取得
wws = if SQL_ENV.nil?
        RecombinedData.new(work_sheet).run
      else
        MysqlAccess.new(work_sheet, SQL_ENV, DB_NAME, TABLE_NAME).run
      end

wws.save

puts "Process Finish"
