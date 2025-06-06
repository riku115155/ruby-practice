#修正点：正規表現を使わずにファイル名から取り出す。コメント行と空行の処理を分かりやすく→空行はchompを使う。#は先頭一文字を取り出し、#であればスキップ
#再修正　計算途中で整数に変換していたが、最初から整数にした

require 'time'
total_work = 0

filename = "kinmu_kitagawa2025_04Apr.txt"
base_name = File.basename(filename, File.extname(filename))
parts = base_name.split('_')
year = parts[1][-4,4]
username = parts[1].gsub('2', '_').split('_')[0]     #2を_に置換し前半部分を取り出すことでusernameを取り出す
month = parts[2][0,2]

File.foreach(filename, encoding: "UTF-8") do |line|
  line = line.chomp  # 行末の改行文字を削除

  next if line.empty?           # 空行をスキップ
  next if line[0] == '#'        # 行頭が '#' の場合はスキップ

  cols = line.chomp.split      #空白文字を区切りとして文字列を分割し、配列を生成
  date        = cols[0]
  start_time  = cols[1]
  end_time    = cols[2]
  rate        = cols[3].to_i

  # 差分（秒）
  sabun_sec = Time.parse(end_time) - Time.parse(start_time)
  # 稼働秒数
  work_sec    = sabun_sec * rate / 100.0.to_i    #切り捨て

  total_work += work_sec

  hours   = (work_sec / 3600)
  minutes = ((work_sec % 3600) / 60)
end

total_hours =  (total_work / 3600)
total_minutes = ((total_work % 3600) / 60)

printf("%s %s-%s  %dh %dmin\n",username, year, month, total_hours, total_minutes)

