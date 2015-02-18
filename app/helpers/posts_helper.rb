module PostsHelper

  def to_prev_year_months
    if current_user.posts.year(@year - 1).count > 0
      link_to "← Записи #{(@year - 1)} года" , months_path(@year - 1)
    end
  end

  def to_next_year_months
    if current_user.posts.year(@year + 1).count > 0
      link_to "Записи #{(@year + 1)} года →" , months_path(@year + 1)
    end
  end

  def link_to_month(month_number)
    if current_user.posts.month(month_number, @year).present?
      link_to Russian::t(Date::MONTHNAMES[month_number]), month_path(@year, month_number)
    else
      Russian::t(Date::MONTHNAMES[month_number])
    end
  end

end
