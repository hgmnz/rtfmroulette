FactoryGirl.define do
  factory :root do
    url 'http://postgresql.org'
    crawl_scope '/'
  end

  factory :source do
    url 'http://postgresql.org'
    content '<body><h1>Hello</h1></body>'
    title 'Hello World'
    root
  end
end
