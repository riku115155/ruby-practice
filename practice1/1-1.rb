#修正点：クラスの定義をやめる・Hash.new使わない・puts→printf

entries = [
  { date: "2024-11-03", item: "book",  amount: 2000 },
  { date: "2025-12-09", item: "taxi",  amount: 4500 },
  { date: "2025-02-15", item: "kosai", amount: 6000 },
  { date: "2025-02-02", item: "kosai", amount: 1200 },
  { date: "2025-02-31", item: "taxi",  amount: 3000 },
  { date: "2025-03-21", item: "kosai", amount: 5000 },
  { date: "2025-05-09", item: "taxi",  amount: 1400 },
  { date: "2025-06-04", item: "book",  amount:  900 },
  { date: "2025-06-12", item: "kosai", amount: 3200 },
]

# ——————————————————————————
# 1) 起票データ一覧表示
# ——————————————————————————
printf("【起票データ一覧】\n")
entries.each do |entry|
  printf("日付：%s, 科目：%s, 金額：%d\n", entry[:date], entry[:item], entry[:amount])
end

# ——————————————————————————
# 2) 月毎集計
# ——————————————————————————
monthly_total = {}
entries.each do |entry|
  month = entry[:date][0,7]
  monthly_total[month] = (monthly_total[month] || 0) + entry[:amount]
end

printf("\n【月毎集計】\n")
monthly_total.each do |month, total|
  printf("%s: %d円\n", month, total)
end

# ——————————————————————————
# 3) 科目毎集計
# ——————————————————————————
item_total = {}
entries.each do |entry|
  key = entry[:item]
  item_total[key] = (item_total[key] || 0) + entry[:amount]
end

printf("\n【科目毎集計】\n")
item_total.each do |item, total|
  printf("%s: %d円\n", item, total)
end

# ——————————————————————————
# 4) 月＋科目毎集計
# ——————————————————————————
combo = {}
entries.each do |entry|
  key = "#{entry[:date][0,7]}-#{entry[:item]}"
  combo[key] = (combo[key] || 0) + entry[:amount]
end

printf("\n【月＋科目毎集計】\n")
combo.each do |key, total|
  printf("%s: %d円\n", key, total)
end
