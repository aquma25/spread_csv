#データを使用しスプレッドシートの見出しと行を生成する

class CreateHeaderRows

  def initialize(work_sheet, datum)
    @work_sheet = work_sheet
    @datum = datum
  end

  def run
    # Header
    @datum.first.each.with_index(1) do |(key, val), i|
      @work_sheet[1, i] = key.to_s
    end

    # Rows
    @datum.each_with_index do |hash, num|
      hash.each.each.with_index(1) do |(key, val), i|
        @work_sheet[num + 2, i] = val.to_s
      end
      puts "#{num + 1}/#{@datum.size}"
    end

    @work_sheet
  end

end
