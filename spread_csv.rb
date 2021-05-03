#Google Spreadsheetに処理を書き込んでいくMain処理

require "google_drive"
require "json"
require 'benchmark'

require_relative "create_header_rows"
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

#jsonまたはmysqlからデータを取得
datum = if SQL_ENV.nil?
          File.open("user_data.json") { |file| JSON.load(file) }
        else
          MysqlAccess.new(SQL_ENV, DB_NAME, TABLE_NAME).run
        end

result = Benchmark.realtime do
  #表の見出しと行を生成する
  written_work_sheet = CreateHeaderRows.new(work_sheet, datum).run

  #実際に書き込んでいく
  written_work_sheet.save
end

puts "Process Finish"
puts "Processing Time: #{result} sec."
