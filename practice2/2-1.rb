#修正点：Dirを使わない、gnuplotを呼び出して実行
# ARGV に渡された CSV ファイルをすべて処理
#再修正：一つのファイルを指定したときに画像が出力されるようにした
#(例)ruby 2-1.rb 2020/0101.csv　と実行すればひとつのグラフだけ表示される

if ARGV.length != 1
  puts "ファイル名入力してください"
  exit 1
end
csv_file = ARGV.first
year     = File.dirname(csv_file)
name     = File.basename(csv_file, ".csv")
svg_file = "fig/#{year}/#{name}_1.svg"
date_title = "#{year}-#{name[0,2]}-#{name[2,2]}"

gnuplot_commands = <<~GP
  set datafile separator ","
  set terminal svg size 1000,600 font 'Arial,12' background rgb 'white'
  set output "#{svg_file}"
  set xdata time
  set timefmt '%H:%M:%S'
  set format x '%H:%M'
  set title "#{date_title} 温度と湿度とCO₂濃度のデータ"
  set xlabel '時刻'
  set ylabel '温度(℃) / 湿度(%)'
  set yrange [0:30]
  set ytics (      '0°C  0%%' 0,      '5°C 20%%' 5,      '10°C 40%%' 10,      '15°C 60%%' 15,      '20°C 80%%' 20,      '25°C 100%%' 25,      '30°C' 30)
  set y2label 'CO₂濃度(ppm)'
  set y2range [400:2200]
  set y2tics nomirror
  plot \\
    "#{csv_file}" using 1:2 with lines title '温度', \\
    "#{csv_file}" using 1:($3/4.0) with lines title '湿度', \\
    "#{csv_file}" using 1:4 axes x1y2 with lines title 'CO₂濃度'
GP

IO.popen("gnuplot", "w") { |io| io.puts gnuplot_commands }

puts "✅ グラフ出力完了: #{svg_file}"
