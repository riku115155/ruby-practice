IO.popen("gnuplot", "w") do |gp|
  gp.puts <<~GP
    set terminal pngcairo size 800,600 enhanced font "Arial,12"
    set output "cos.png"
    set datafile separator "\\t"
    set title  "coscurve"
    set xlabel "t "
    set ylabel "θ (deg)"
    set grid
    plot "data_cosine.tsv" using 1:2 with linespoints lw 2 pt 7 title "coscurve"
  GP
end

puts "✓ cos.png を生成しました"

IO.popen("gnuplot", "w") do |gp|
  gp.puts <<~GP
    set terminal pngcairo size 800,600 enhanced font "Arial,12"
    set output "sig.png"
    set datafile separator "\\t"
    set title  "sigmoidcurve"
    set xlabel "t "
    set ylabel "θ (deg)"
    set grid
    plot "data_sigmoid.tsv" using 1:2 with linespoints lw 2 pt 7 title "sigmoidcurve"
  GP
end

puts "✓ sig.png を生成しました"

