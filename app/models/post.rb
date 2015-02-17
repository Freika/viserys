class Post < ActiveRecord::Base
  belongs_to :user

  def self.week(week, year)
    this_week = Date.commercial(year.to_i, week.to_i).to_time
    where(created_at: this_week.beginning_of_week(:monday)..this_week.end_of_week(:monday)).order(created_at: :desc)
  end

  def self.month(month, year)
    this_month = Time.new(year, month)
    where(created_at: this_month.beginning_of_month..this_month.end_of_month).order(created_at: :desc)
  end

end
