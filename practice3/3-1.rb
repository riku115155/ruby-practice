#修正点：うるう年判定を標準ライブラリ関数にする、putsをprintfに →日付の引き算も標準ライブラリ関数で

require'date'
today = Date.today

#初回勤務日を入力
printf("初回勤務日を例の通りに入力してください(例：2020-01-01)\n")
first_date_str = gets.chomp

first_date = Date.parse(first_date_str)

difference = (today - first_date).to_i.abs

printf("%sから%sまでの暦日数は%d日です\n",first_date_str,today,difference)
