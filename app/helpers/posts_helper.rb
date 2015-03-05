module PostsHelper

  def to_prev_year(period)
    if current_user.posts.year(@year - 1).count > 0
      link_to "← Записи #{(@year - 1)} года" , eval("#{period}_path(#{@year} - 1)")
    end
  end

  def to_next_year(period)
    if current_user.posts.year(@year + 1).count > 0
      link_to "Записи #{(@year + 1)} года →" , eval("#{period}_path(#{@year} + 1)")
    end
  end

  def link_to_month(month_number)
    if current_user.posts.month(@year, month_number).present?
      link_to Russian::t(Date::MONTHNAMES[month_number]), month_path(@year, month_number)
    else
      Russian::t(Date::MONTHNAMES[month_number])
    end
  end

  def link_to_week(week_number)
    this_week = Date.commercial(@year, week_number.to_i)
    text = "С #{Russian::strftime((this_week.beginning_of_week), '%e %B %Y')} \
           по #{Russian::strftime((this_week.end_of_week), '%e %B %Y')}"

    if current_user.posts.week(@year, week_number).present?
      link_to text, week_path(@year, week_number)
    else
      text
    end
  end

  def cell_tooltip(date)
    nice_russian_date(date.first)
  end

  def graph(user)
    progress_days = count_days_with_posts(user)

    calendar = {}
    last_year_beautiful = 1.year.ago.to_date..Date.today

    last_year_beautiful.each do |day|
      val = progress_days.keys.include?(day) ? progress_days[day] : 0
      calendar[day + 1.day] = val
    end
    return calendar.to_a.reverse.to_h
  end

  def count_days_with_posts(user)
    last_year = (1.year.ago).beginning_of_day..Date.today.end_of_day

    # hash of arrays looks like [date, how_many_posts_on_this_date]
    posts_on_date = user.posts.where(created_at: last_year).group('date(created_at)').count
  end

  def graph_square(day)
    link_to '', '', data: { toggle: 'tooltip', placement: 'top'}, title: cell_tooltip(day)
  end


end
