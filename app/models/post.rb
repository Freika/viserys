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

end
