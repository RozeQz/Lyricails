# frozen_string_literal: true

module ApplicationHelper
  def nav_tab(title, url, options = {})
    current_page = options.delete :current_page
    css_class = current_page == title ? 'link-secondary' : 'link-dark'

    options[:class] = if options[:class]
                        "#{options[:class]} #{css_class}"
                      else
                        css_class
                      end

    link_to title, url, options
  end

  def currently_at(current_page = '')
    render partial: 'shared/menu', locals: { current_page: current_page }
  end

  def full_title(page_title = '')
    base_title = 'Palindromes'
    if page_title.present?
      "#{page_title} | #{base_title}"
    else
      base_title
    end
  end
end
