# user_data.jsonのデータをスプレッドシートのフォーマットに合わせて出力する

require "json"

class RecombinedData

  def initialize(work_sheet)
    @work_sheet = work_sheet
  end

  def run
    File.open("user_data.json") do |file|
      users_data = JSON.load(file)

      # Header
      users_data[0].each.with_index(1) do |(key, val), i|
        @work_sheet[1, i] = key.to_s
      end

      # Rows
      users_data.each.with_index(2) do |hash, num|
        hash.each.each.with_index(1) do |(key, val), i|
          @work_sheet[num, i] = val.to_s
        end
        puts "#{num - 1}/#{users_data.size}"
      end
    end

    @work_sheet
  end

end
