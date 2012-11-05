# Copyright 2009-2013 Swansea University
#
#   Licensed under the Apache License, Version 2.0 (the "License");
#   you may not use this file except in compliance with the License.
#   You may obtain a copy of the License at
#
#       http://www.apache.org/licenses/LICENSE-2.0
#
#   Unless required by applicable law or agreed to in writing, software
#   distributed under the License is distributed on an "AS IS" BASIS,
#   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#   See the License for the specific language governing permissions and
#   limitations under the License.
#

module ApplicationHelper
  def sortable(column, title = nil)
    title ||= column.titleize
    css_class = (column == sort_column) ? "current #{sort_direction}" : nil
    direction = (column == sort_column && sort_direction == :asc) ? "desc" : "asc"
    link_to title, params.merge(sort: column, direction: direction, page: nil), { class: css_class }
  end

  def yesno(bool)
    if bool 
      return "Yes"
    else
      return "No"
    end
  end

  # The Proman logo
  def logo
    raw "Proman<em><sup>mmxiii</sup></em>"
  end


  def proman
    return "Proman"
  end

  # Generate a quotation suitable for a page slogan.
  def quotation_generator(quotation, citation = {})
    born = citation[:born] || '?'
    died = citation[:died] || '?'
    author = citation[:author] || 'Anonymous'
    dates = "#{born}&mdash;#{died}"
    cited_quotation = "&ldquo;#{h(quotation)}&rdquo; &ndash; #{h(author)}"
    if (dates == "?&mdash;?")
      return cited_quotation.html_safe
    else
      return (cited_quotation += " (#{dates})").html_safe
    end
  end

  # Returns the full title on a per-page basis.
  def full_title(page_title)
    base_title = "Proman 2013"
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end

   # Title helper as described in RailsCast 30 (http://asciicasts.com/episodes/30-pretty-page-title)
   # Use as <%= title("Page title") %> in your templates.
   def title(page_title)
     content_for(:title) { page_title }
   end

  # Slogan helper: similar to the title helper. Puts a witty slogan on the current page.
  # Use as <%= :slogan "Plagiarism is bad for your grade" %> in your templates.
  def slogan(page_slogan)
    content_for(:slogan) { page_slogan }
  end

  def user_name
    if user_signed_in?
      return current_user.known_as || current_user.user_name
    else
      return "Guest"
    end
  end
end
