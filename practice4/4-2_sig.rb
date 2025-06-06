def sigmo(x)
  180.0 / (1 + Math.exp(-6.0 * (x - 0.5)))
end

File.open("data_sigmoid.csv", "w") { |f|
  f.printf("t,theta\n")
  (0..20).each { |i|
    t     = i.to_f / 20
    basic = 180 * (1.0 / (1 + Math.exp(-6.0 * (t - 0.5))))
    theta = (basic - sigmo(0.5)) * 90 / (sigmo(1.0) - sigmo(0.5)) + sigmo(0.5)
    f.printf("%.5f,%.5f\n", t, theta)
  }
}
printf("✓ data_sigmoid.csv を生成しました\n")

# Gnuplot に渡す各変数を定義
data_file = "data_sigmoid.csv"
out_file  = "sigmoid.png"
title     = "sigmoid"

system(
  "gnuplot",
  "-e", "CSV='#{data_file}'",
  "-e", "OUT='#{out_file}'",
  "-e", "TITLE='#{title}'",
  "plot.gp"
)
printf("✓ グラフ出力完了\n")
