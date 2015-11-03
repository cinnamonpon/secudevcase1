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

  def panel_link(link_text, link_path)
    class_name = current_page?(link_path) ? "list-group-item active" : "list-group-item"
    link_to link_text, link_path, class: class_name
  end

  def btn_add(status)
    class_name = status == "In stock" ? "btn btn-xs btn-primary" : "btn btn-xs btn-primary disabled"

    button_tag(type: "submit", class: class_name) do
      concat content_tag(:i, "", class: "glyphicon glyphicon-shopping-cart")
      concat content_tag(:span, " Add")
    end
  end

  def item_status(status)
    color = status == "In stock" ? "green" : "red"
    class_name = status == "In stock" ? "glyphicon glyphicon-ok-sign" : "glyphicon glyphicon-remove-sign"

    content_tag(:strong) do
      concat (content_tag(:p, style: "color:#{color};" ) do
        concat content_tag(:i, "", class: class_name)
        concat content_tag(:span, " #{status}")
      end)
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
