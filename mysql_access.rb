#MySQLのデータを抽出する

require 'mysql2'

class MysqlAccess
  
  def initialize(work_sheet, env, query)
    @work_sheet = work_sheet
    @client = case env
      when "dev"
        Mysql2::Client.new(host: "localhost", username: "root")
      when "pro"
        #Mysql2::Client.new(host: "localhost", username: "root") #TODO:本番環境のホストとかを指定
      else
        raise "not supported #{env}"
      end
    @query = query.nil? ? "select * from practice_for_rails_development.users" : query
  end

  def run
    queries = @client.query(@query)
   
    # Header
    queries.first.each.with_index(1) do |(key, val), index|
      @work_sheet[1, index] = key.to_s
    end

    # Rows
    queries.each_with_index do |hash, num|
      hash.each.each.with_index(1) do |(key, val), index|
        @work_sheet[num + 2, index] = val.to_s
      end
      puts "#{num + 1}/#{queries.size}"
    end

    @work_sheet
  end

end


