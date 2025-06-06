N = 21
File.open("data_linear.csv", "w") { |f|
  f.printf("t,theta")
  N.times { |i|
    t     = i.to_f / (N - 1)
    theta = t * 180
    f.printf("%.2f,%.1f\n", t, theta)
  }
}
printf("✓ data_linear.csv を生成しました\n")

# Gnuplot に渡す各変数を定義
data_file = "data_linear.csv"
out_file  = "linear.png"
title     = "linear"

system(
  "gnuplot",
  "-e", "CSV='#{data_file}'",
  "-e", "OUT='#{out_file}'",
  "-e", "TITLE='#{title}'",
  "plot.gp"
)
printf("✓ グラフ出力完了\n")
