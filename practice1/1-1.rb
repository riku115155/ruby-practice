#修正点：クラスの定義をやめる・Hash.new使わない・puts→printf
#追加修正→.each doは使わない・データの定義を改める・sortを利用して順番通りになるように

entries = [
  ["2024-11-03", "book",  2000],
  ["2024-12-09", "taxi",  4500],
  ["2025-02-15", "kosai", 6000],
  ["2025-02-02", "kosai", 1200],
  ["2025-02-28", "taxi",  3000],
  ["2025-03-21", "kosai", 5000],
  ["2025-05-09", "taxi",  1400],
  ["2025-06-04", "book",   900],
  ["2025-06-12", "kosai", 3200],
]

# ——————————————————————————
# 1) 起票データ一覧表示
# ——————————————————————————
printf("【起票データ一覧】\n")
entries.each { |entry|
  printf("日付：%s, 科目：%s, 金額：%d円\n", entry[0], entry[1], entry[2])
}

# ——————————————————————————
# 2) 月毎集計
# ——————————————————————————
monthly_total = {}
entries.each { |entry|
  month = entry[0][0,7]  # "YYYY-MM"
  monthly_total[month] = (monthly_total[month] || 0) + entry[2]
}

printf("\n【月毎集計（古い順）】\n")
monthly_total.sort.each { |month, total|
  printf("%s: %d円\n", month, total)
}

# ——————————————————————————
# 3) 科目毎集計
# ——————————————————————————
item_total = {}
entries.each { |entry|
  key = entry[1]  # 科目
  item_total[key] = (item_total[key] || 0) + entry[2]
}

printf("\n【科目毎集計】\n")
item_total.sort.each { |item, total|
  printf("%s: %d円\n", item, total)
}

# ——————————————————————————
# 4) 月＋科目毎集計
# ——————————————————————————
combo = {}
entries.each { |entry|
  key = "#{entry[0][0,7]}-#{entry[1]}"  # "YYYY-MM-科目"
  combo[key] = (combo[key] || 0) + entry[2]
}

printf("\n【月＋科目毎集計】\n")
combo.sort.each { |key, total|
  printf("%s: %d円\n", key, total)
}
