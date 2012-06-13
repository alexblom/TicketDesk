module ApplicationHelper

  #Highlight the users current nav link
  def nav_link(link_text, link_path)
    class_name = current_page?(link_path) ? 'active' : ''
    content_tag(:li, :class => class_name) do
      link_to link_text, link_path
    end
  end
  
  def active_for(object)
    active_for = distance_of_time_in_words_to_now(object.created_at)
  end
  
  def active_since_updated(object) 
    active_for = distance_of_time_in_words_to_now(object.updated_at)
  end
end
