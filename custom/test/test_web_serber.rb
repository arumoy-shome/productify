require 'rack'
require 'zip'

def make_zip
  input = File.expand_path('../../test/example_zip/file.csv', __FILE__)
  output = File.expand_path('../../test/example_zip/file.zip', __FILE__)

  Zip::File.open(output, Zip::File::CREATE) do |zipfile|
    zipfile.add('file.csv', input)
  end

  output
end

app = Proc.new do |env|
  ['200', {'Content-Type' => 'zip'}, [make_zip]]
end

Rack::Handler::WEBrick.run app
