  # Google Spreadsheetに処理を書き込んでいく

  require "google_drive"
  require_relative "recombined_data"

  puts "Process Start"

  session = GoogleDrive::Session.from_config("config.json")

  spread_sheet_path = ARGV[0]
  sheet_tab_name = ARGV[1]

  sp = session.spreadsheet_by_url(spread_sheet_path.to_s)
  ws = sp.worksheet_by_title(sheet_tab_name.to_s)

  ws = RecombinedData.new(ws).run

  ws.save

  puts "Process Finish"
