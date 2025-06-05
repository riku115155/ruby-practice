set datafile separator ","
set terminal svg size 1000,600 font 'Arial,12' background rgb 'white'
set output OUT
set xdata time
set timefmt '%H:%M:%S'
set format x '%H:%M'
set title TITLE
set xlabel '時刻'
set ylabel '温度(℃) / 湿度(%)'
set yrange [0:30]
set ytics (      '0°C  0%%' 0,      '5°C 20%%' 5,      '10°C 40%%' 10,      '15°C 60%%' 15,      '20°C 80%%' 20,      '25°C 100%%' 25,      '30°C' 30)
set y2label 'CO₂濃度(ppm)'
set y2range [400:2200]
set y2tics nomirror
plot \
  CSV using 1:2 with lines title '温度', \
  CSV using 1:($3/4.0) with lines title '湿度', \
  CSV using 1:4 axes x1y2 with lines title 'CO₂濃度'
