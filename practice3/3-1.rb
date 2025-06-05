#修正点：うるう年判定を標準ライブラリ関数にする、putsをprintfに

require 'date'

# 今日の日付
def today_date
  Date.today
end

printf("初回勤務日を例の通りに記入してください(例:2020-01-01)\n")
first_date = gets.chomp

# 入力された日付を年・月・日に分割して整数に変換
first_year = first_date[0, 4].to_i
first_month = first_date[5, 2].to_i
first_day = first_date[8, 2].to_i

today = today_date
today_year = today.year
today_month = today.month
today_day = today.day

# 標準ライブラリのうるう年判定を使用

# 月ごとの日数（2月はうるう年で補正）
MONTH_DAYS = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

# 西暦1年1月1日からの日数を求める
def days_from_0001(year, month, day)
  total_days = 0

  # 年単位の加算
  (1...year).each do |y|
    total_days += Date.leap?(y) ? 366 : 365
  end

  # 月単位の加算
  (1...month).each do |m|
    if m == 2 && Date.leap?(year)
      total_days += 29
    else
      total_days += MONTH_DAYS[m - 1]
    end
  end

  # 日の加算
  total_days += day

  return total_days
end

# 通算日数に変換
first_from_0001 = days_from_0001(first_year, first_month, first_day)
today_from_0001 = days_from_0001(today_year, today_month, today_day)

# 差を計算
result = (today_from_0001 - first_from_0001).abs

# 結果表示
printf("%sから%sまでの暦日数は%d日です\n",first_date,today,result)
