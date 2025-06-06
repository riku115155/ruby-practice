#修正点：クラスの定義をやめる・Hash.new使わない・puts→printf
#追加修正：require 'csv'を使わない　each.doを使わない

entries = []
File.foreach("sample.csv", encoding: "UTF-8") do |line|
  next if $. == 1                        # (1) 1行目＝ヘッダーなら飛ばす
  line = line.chomp                      # (2) 行末の改行 (\n) を削る
  next if line.empty?                    # (3) 空行なら飛ばす

  cols = line.split(",").map(&:strip)    # (4) カンマで区切って前後の空白を削除
  entries << [cols[0], cols[1], cols[2].to_i]  # (5) 日付, 科目, 金額（整数） を配列として追加
end

# — 起票データ一覧表示（printfに変更） —
printf("【起票データ一覧】\n")
entries.each { |e|
  printf("日付：%s, 科目：%s, 金額：%d\n", e[0], e[1], e[2])
}


# — 月毎集計（Hash.new不使用、||で初期化） —
monthly_total = {}
entries.each { |e|
  month = e[0][0,7]                     # "YYYY-MM"
  monthly_total[month] = (monthly_total[month] || 0) + e[2]
}

printf("\n【月毎集計】\n")
monthly_total.sort.each do |month, total|
  printf("%s: %d円\n", month, total)
end

# — 科目毎集計 —
item_total = {}
entries.each { |e|
  key = e[1][0,5]                       # 科目名の先頭5文字
  item_total[key] = (item_total[key] || 0) + e[2]
}


printf("\n【科目毎集計】\n")
item_total.each { |item, total|
  printf("%s: %d円\n", item, total)
}

# — 月＋科目毎集計 —
combo_total = {}
entries.each { |e|
  key = "#{e[0][0,7]}-#{e[1][0,5]}"      # "YYYY-MM-科目(先頭5文字)"
  combo_total[key] = (combo_total[key] || 0) + e[2]
}

printf("\n【月＋科目毎集計】\n")
combo_total.each { |key, total|
  printf("%s: %d円\n", key, total)
}
