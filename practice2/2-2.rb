if ARGV.empty?
  printf("ファイル名を入力してください\n")
  exit 1
end

first_csv = ARGV.first
year      = File.dirname(first_csv)

# ハッシュを使って月ごとに配列でデータをまとめる
data_hash = {}

ARGV.each do |csv_file|
  filename = File.basename(csv_file, ".csv")
  month = filename[0,2]

  # 月のハッシュがなければ作る
  data_hash[month] ||= { temp: [], humi: [], co2: [] }

  File.foreach(csv_file) do |line|
    row = line.chomp.split(",")

    temp = row[1].to_f
    humi = row[2].to_f
    co2  = row[3].to_f
    next if co2 < 0

    data_hash[month][:temp] << temp
    data_hash[month][:humi] << humi
    data_hash[month][:co2]  << co2      #末尾に要素が追加されていく
  end
end

def show(title, hash, key)
  printf("\n%s\n", title)
  printf("\n月\t平均\t最大値\t最小値\t中央値\n")
  hash.keys.sort.each do |month|
    values = hash[month][key]
    next if values.nil? || values.empty?
    ave = (values.sum.to_f / values.size).round(1)
    max = values.max.round(1)
    min = values.min.round(1)
    len = values.size
    sorted = values.sort
    med = if len.odd?
      sorted[len / 2]
    else
      ((sorted[len / 2 - 1] + sorted[len / 2]) / 2.0).round(2)
    end
    printf("%s\t%.1f\t%.1f\t%.1f\t%.1f\n", month, ave, max, min, med)
  end
end

show("温度(℃)", data_hash, :temp)
show("湿度(%)", data_hash, :humi)
show("CO2(ppm)", data_hash, :co2)
