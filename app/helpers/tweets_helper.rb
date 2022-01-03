module TweetsHelper
  def hashtag_render(content)
     content.gsub(/#\w+/){|word| link_to word, "/tweets?query=#{word.delete('#')}", class: "font-medium"}.html_safe
  end
  
end
