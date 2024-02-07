
require 'uri'
require 'net/http'
require 'net/https'
require 'json'
require 'tty-markdown'
def getprompt
  puts 'Enter prompt'
  gets.chomp
end

def getresponse(prompt)
  puts 'Sending request'
  uri = 	URI("https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent?key=#{ENV['API_KEY']}")
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
  http.request(request)
end

def print(response)
  raw = response.body
  out = JSON.parse(raw)
  out = out['candidates'][0]['content']['parts'][0]['text']
  formatted_output = TTY::Markdown.parse(out)
  puts formatted_output
end

def rerun
  loop do
    puts 'Enter another Prompt(Y) or Exit(N)?'
    choice = gets.chomp.upcase
    case choice
    when 'Y'
      prompt = getprompt
      response = getresponse(prompt)
      print(response)
    when 'N'
      exit
    else
      puts 'Invalid'
    end
  end
end
prompt = getprompt
response = getresponse(prompt)
print(response)
rerun
