set terminal pngcairo size 800,600 enhanced font "Arial,12"
set output OUT
set datafile separator ","
set title TITLE
set xlabel "t"
set ylabel "θ (deg)"
set grid
plot CSV using 1:2 with linespoints lw 2 pt 7 title TITLE
