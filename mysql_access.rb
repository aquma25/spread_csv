#MySQLのデータを抽出する

require 'mysql2'

class MysqlAccess
  
  def initialize(work_sheet, env, db_name, table_name)
    @work_sheet = work_sheet
    @client = case env
      when "dev"
        Mysql2::Client.new(host: "localhost", username: "root")
      when "pro"
        #Mysql2::Client.new(host: "localhost", username: "root") #TODO:本番環境のホストとかを指定
      else
        raise "not supported #{env}"
      end
    @query = db_name.nil? || table_name.nil? ? "select * from practice_for_rails_development.users" : call_select_query(db_name, table_name)
  end

  def run
    begin
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
    rescue => error
      "Error: #{error.class}, Message: #{error.message}, BackTrace: #{error.backtrace}"
    end
  end

  def call_select_query(db_name, table_name)
    "select * from #{db_name.to_s}.#{table_name.to_s}"
  end
end


