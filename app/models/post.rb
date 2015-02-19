class Post < ActiveRecord::Base
  belongs_to :user

  def self.week(year, week)
    this_week = Date.commercial(year.to_i, week.to_i).to_time
    where(created_at: this_week.beginning_of_week..this_week.end_of_week).order(created_at: :desc)
  end

  def self.month(year, month)
    this_month = Time.new(year, month)
    where(created_at: this_month.beginning_of_month..this_month.end_of_month).order(created_at: :desc)
  end

  def self.year(year)
    this_year = Date.new(year)
    where(created_at: this_year.beginning_of_year..this_year.end_of_year).order(created_at: :desc)
  end

  def self.graph
    progress_days = Post.count_days_with_posts

    calendar = {}
    last_year_beautiful = Date.parse((1.year.ago).strftime("%Y-%m-%d"))..Date.parse(Date.today.strftime("%Y-%m-%d"))

    last_year_beautiful.each do |day|
      val = progress_days.keys.include?(day) ? progress_days[day] : 0
      calendar[day] = val
    end
    return calendar.to_a.reverse.to_h
  end

  def self.count_days_with_posts
    last_year = (1.year.ago).beginning_of_day..Date.today.end_of_day

    # hash of arrays looks like [date, how_many_posts_on_this_date]
    posts_on_date = Post.where(created_at: last_year).group('date(created_at)').count
  end

end
