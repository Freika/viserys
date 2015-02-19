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

end
