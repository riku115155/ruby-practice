#修正点：Dirを使わない、gnuplotを呼び出して実行
# ARGV に渡された CSV ファイルをすべて処理

if ARGV.empty?
  printf("ファイル名を入力してください\n")
  exit 1
end
first_csv = ARGV.first           # ⇒ ARGV の配列から先頭要素を取り出す（文字列）
year      = File.dirname(first_csv)
ARGV.each do |csv_file|
  # 拡張子 .csv を取り除いたベース名
  name       = File.basename(csv_file, ".csv")
  # 出力 SVG のパス
  svg_file   = "fig/#{year}/#{name}.svg"
  # タイトル用の日付文字列 (例: "2020-01-01")
  date_title = "#{year}-#{name[0,2]}-#{name[2,2]}"

  # gnuplot を呼び出し
  system(
    "gnuplot",
    "-e", "CSV='#{csv_file}'",
    "-e", "OUT='#{svg_file}'",
    "-e", "TITLE='#{date_title} 温度と湿度とCO₂濃度のデータ'",
    "plot.gp"
  )
end

printf("✅ グラフ出力完了\n")
