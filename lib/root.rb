class Root < Sequel::Model
  def uri
    URI.parse(url)
  end
end
