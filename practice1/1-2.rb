#修正点：クラスの定義をやめる・Hash.new使わない・puts→printf

require 'csv'   # CSV読み込み用ライブラリ

# — データ読み込み —
entries = []
CSV.foreach("sample.csv", headers: true) do |row|
  entries << {
    date:   row["date"],
    item:   row["item"],
    amount: row["amount"].to_i
  }
end

# — 起票データ一覧表示（printfに変更） —
printf("【起票データ一覧】\n")
entries.each do |e|
  printf("日付：%s, 科目：%s, 金額：%d\n", e[:date], e[:item], e[:amount])
end

# — 月毎集計（Hash.new不使用、||で初期化） —
monthly_total = {}
entries.each do |e|
  month = e[:date][0,7]               # "YYYY-MM"
  monthly_total[month] = (monthly_total[month] || 0) + e[:amount]
end

printf("\n【月毎集計】\n")
monthly_total.each do |month, total|
  printf("%s: %d円\n", month, total)
end

# — 科目毎集計 —
item_total = {}
entries.each do |e|
  key = e[:item][0,5]                # 科目名の先頭5文字
  item_total[key] = (item_total[key] || 0) + e[:amount]
end

printf("\n【科目毎集計】\n")
item_total.each do |item, total|
  printf("%s: %d円\n", item, total)
end

# — 月＋科目毎集計 —
combo_total = {}
entries.each do |e|
  key = "#{e[:date][0,7]}-#{e[:item][0,5]}"
  combo_total[key] = (combo_total[key] || 0) + e[:amount]
end

printf("\n【月＋科目毎集計】\n")
combo_total.each do |key, total|
  printf("%s: %d円\n", key, total)
end
