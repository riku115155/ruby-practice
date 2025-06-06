#!/usr/bin/env ruby
N = 21
File.open("data_linear.csv", "w") do |f|
  f.puts "t,theta"
  N.times do |i|
    t     = i.to_f / (N - 1)
    theta = t * 180
    f.printf("%.2f,%.1f\n", t, theta)
  end
end
puts "✓ data_linear.csv を生成しました"

# Gnuplot用スクリプトを一時ファイルに書き出す
File.open("plot.gp", "w") do |f|
  f.puts <<~GP
    set terminal pngcairo size 800,600 enhanced font "Arial,12"
    set output "linear_1.png"
    set datafile separator ","
    set title "linear"
    set xlabel "t"
    set ylabel "θ (deg)"
    set grid
    plot "data_linear.csv" using 1:2 with linespoints lw 2 pt 7 title "linear"
  GP
end

# execでプロセスをgnuplotに置き換えて実行
exec("gnuplot", "plot.gp")
