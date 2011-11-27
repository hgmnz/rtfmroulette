FactoryGirl.define do
  factory :root do
    url 'http://google.com'
    crawl_scope '/'
  end

  factory :source do
    url 'http://google.com'
    content '<body><h1>Hello</h1></body>'
    title 'Hello World'
    root
  end
end
