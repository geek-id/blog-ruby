module PagesHelper

  def full_title(page_title = '')
    base_title = "GeekID Blog"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end


  def tag_links(tags)
    tags.split(",").map{|tag| link_to tag.strip, tag_path(tag.strip) }.join(", ")
  end
end
