module ApplicationHelper

  def nice_russian_date(date)
    if date == Time.zone.today
      "сегодня, #{Russian::strftime(date, '%e %B')}"
    elsif date == Time.zone.yesterday
      "вчера, #{Russian::strftime(date, '%e %B')}"
    else
      Russian::strftime(date, '%e %B %Y')
    end
  end

  def available_post_types
    options = {daily: 'Итоги дня'}
    if Time.zone.now.wday == 6 || Time.zone.now.wday == 0
      options[:weekly] = 'Итоги недели'
    end

    if (25..31).include? Time.zone.now.day
      options[:monthly] = 'Итоги месяца'
    end

    if Time.zone.now.month == 12
      options[:yearly] = 'Итоги года'
    end

    if (Time.zone.now.month == 2) && ((25..31).include? Time.zone.now.day)
      options[:winter] = 'Итоги зимы'
    end

    if (Time.zone.now.month == 5) && ((25..31).include? Time.zone.now.day)
      options[:spring] = 'Итоги весны'
    end

    if (Time.zone.now.month == 8) && ((25..31).include? Time.zone.now.day)
      options[:summer] = 'Итоги лета'
    end

    if (Time.zone.now.month == 11) && ((25..31).include? Time.zone.now.day)
      options[:autumn] = 'Итоги осени'
    end
    options
  end

end
