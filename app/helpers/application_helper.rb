module ApplicationHelper
  include SessionsHelper
  def nav_link(link_text, link_path)
    if current_page?(link_path)
      content_tag(:li, :class => "active") do
        link_to link_text, link_path
      end
    else
      content_tag(:li) do
        link_to link_text, link_path
      end
    end
  end

  def full_title(page_title = '')
    base_title = "Hack me"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end
end
