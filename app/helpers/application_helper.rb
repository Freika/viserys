module ApplicationHelper

  def title(value)
    if value
      @title = value
    else
      @title = "Сворачивающеся дневники"
    end
  end

  def nice_russian_date(date)
    if date == Time.zone.today
      "Сегодня, #{Russian::strftime(date, '%e %B %A')}"
    elsif date == Time.zone.yesterday
      "Вчера, #{Russian::strftime(date, '%e %B %A')}"
    else
      Russian::strftime(date, '%e %B %Y, %A')
    end
  end

  def available_post_types
    options = { daily: 'Итоги дня' }
    if Time.zone.now.wday == 6 || Time.zone.now.wday == 0 || Time.zone.now.wday == 1
      options[:weekly] = 'Итоги недели'
    end

    if (25..31).include? Time.zone.now.day
      options[:monthly] = 'Итоги месяца'
    end

    if Time.zone.now.month == 12
      options[:yearly] = 'Итоги года'
    end

    # if (Time.zone.now.month == 2) && ((25..31).include? Time.zone.now.day)
    #   options[:winter] = 'Итоги зимы'
    # end

    # if (Time.zone.now.month == 5) && ((25..31).include? Time.zone.now.day)
    #   options[:spring] = 'Итоги весны'
    # end

    # if (Time.zone.now.month == 8) && ((25..31).include? Time.zone.now.day)
    #   options[:summer] = 'Итоги лета'
    # end

    # if (Time.zone.now.month == 11) && ((25..31).include? Time.zone.now.day)
    #   options[:autumn] = 'Итоги осени'
    # end
    options
  end

  def alert_class_for(flash_type)
    {
      :success => 'alert-success',
      :error => 'alert-danger',
      :alert => 'alert-warning',
      :notice => 'alert-info'
    }[flash_type.to_sym] || flash_type.to_s
  end

  def just_paginate(collection)
    will_paginate collection, renderer: BootstrapPagination::Rails, previous_label: 'Назад', next_label: 'Вперед'
  end

  def markdown(text)
    renderer = Redcarpet::Render::HTML.new(hard_wrap: true, filter_html: true)
    options = {
        autolink: true,
        no_intra_emphasis: true,
        fenced_code_blocks: true,
        lax_html_blocks: true,
        strikethrough: true,
        superscript: true,
        space_after_headers: true
    }
    Redcarpet::Markdown.new(renderer, options).render(text).html_safe
  end

end
