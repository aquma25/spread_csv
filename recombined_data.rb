# user_data.jsonのデータをスプレッドシートのフォーマットに合わせて出力する

require "json"

class RecombinedData

  def initialize(ws)
    @ws = ws
  end

  def run
    File.open("user_data.json") do |file|
      users_data = JSON.load(file)

      # Column部分
      users_data[0].each.with_index(1) do |(k, v), i|
        @ws[1, i] = k.to_s
      end

      # Record部分
      users_data.each.with_index(2) do |hash, num|
        hash.each.each.with_index(1) do |(k, v), i|
          @ws[num, i] = v.to_s
        end
      end
    end

    @ws
  end

end
