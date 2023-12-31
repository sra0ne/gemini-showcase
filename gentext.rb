
require 'uri'
require 'net/http'
require 'net/https'
require 'json'
require 'tty-markdown'
puts 'Enter prompt'
prompt = gets.chomp
puts 'Sending request'
uri = URI("https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent?key=#{ENV['API_KEY']}")
http = Net::HTTP.new(uri.host, uri.port)
http.use_ssl = true
request = Net::HTTP::Post.new(uri)
request['Content-Type'] = 'application/json'
request.body = {
  "contents": [{
    "parts": [{
      "text": prompt
    }]
  }]
}.to_json
response = http.request(request)
raw = response.body
out = JSON.parse(raw)
out = out['candidates'][0]['content']['parts'][0]['text']
formatted_output = TTY::Markdown.parse(out)
puts formatted_output
