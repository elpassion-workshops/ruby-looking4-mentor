module ApplicationHelper

  def query_title(query)
    [query.keyword, query.address].reject(&:blank?).join(' near ')
  end

end
