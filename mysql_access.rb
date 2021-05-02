#MySQLのデータを抽出する

require 'mysql2'

class MysqlAccess
  
  def initialize(env, db_name, table_name)
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
      @client.query(@query)
    rescue => error
      "Error: #{error.class}, Message: #{error.message}, BackTrace: #{error.backtrace}"
    end
  end

  def call_select_query(db_name, table_name)
    "select * from #{db_name.to_s}.#{table_name.to_s}"
  end
end


