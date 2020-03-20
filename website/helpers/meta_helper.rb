require "redcarpet"
require "redcarpet/compat"

def page_title
  title = current_page.data.title || site_title
  if current_article && current_article.title
    title = site_title + " | " +  current_article.title
  end

  title
end

def page_description
  description = site_description

  if current_article && current_page.data.description
    description = current_page.data.description
  end

  description
end

def include_sidebar?
  true
end

def page_keywords
  keywords = [] # Set site keywords here

  if current_article && current_article.tags
    keywords.concat(current_article.data.tags)
  end

  keywords.uniq.join(", ")
end

def embed_media(text, image_name)
  pre = '<div class="media"><div class="media-left"><a href="#"><img class="thumbnail media-object" style="height: 120px;" src="gerardcondon.com/blog/images/'
  middle = '"></a></div><div class="media-body">'  
  post = '</div></div>'
  return pre + image_name + middle + "\n\n" + text  + "\n\n" + post
end


def gc_markdown(text)
  markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML)
  return markdown.render(text).html_safe
end

module Middleman
  module Blog
    module BlogArticle
      def is_micropost?
        data["micropost"]
      end
      
      def display_title
        is_micropost? ? "" : data["title"]
      end
      
      def published_time
        date.to_time.iso8601
      end
      
      def updated_time
        is_micropost? ? published_time : File.mtime(source_file).iso8601
      end
    end
  end
end

  
  
  