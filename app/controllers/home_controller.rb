get '/' do
  File.read(File.join('public', 'index.html'))
end

get '/public/:name' do
  sanitized_name = sanitize(params['name'])
  content_type resolve_content_type(sanitized_name)
  File.read(File.join('public', sanitize(params['name'])))
end

private

def sanitize(str)
  str.gsub('/', '')
end

def resolve_content_type(name)
  return 'text/javascript' if name.end_with?('.js')
  return 'text/css' if name.end_with?('.css')

  'test/html'
end
