N = 21
File.open("data_cos.csv", "w") do |f|
  f.printf("t,theta_cos")
  (0...N).each do |i|
    t     = i.to_f / (N - 1)           # 0.00, 0.05, …, 1.00
    theta = 180 * (1 - Math.cos(Math::PI * t)) / 2
    f.printf("%.2f,%.3f\n", t, theta)
  end
end

printf("✅ data_cos.csv を生成しました\n")
# Gnuplot に渡す各変数を定義
data_file = "data_cos.csv"
out_file  = "cos.png"
title     = " cosine"

system(
  "gnuplot",
  "-e", "CSV='#{data_file}'",
  "-e", "OUT='#{out_file}'",
  "-e", "TITLE='#{title}'",
  "plot.gp"
)
printf("✅ グラフ出力完了\n")
