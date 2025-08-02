
require 'uri'
require 'net/http'
require 'net/https'
require 'json'
require 'tty-markdown'

def get_prompt
  puts 'Enter prompt:'
  gets.chomp
end

def get_response(prompt)
  puts 'Sending request..'
  uri = URI("https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent?key=#{ENV['API_KEY']}")
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
  case response
  when Net::HTTPSuccess
    response
  else
    puts "HTTP Error: #{response.code} - #{response.message}"
    rerun
  end
end

def print_output(response)
  raw = response.body
  parsed_response = JSON.parse(raw)
  if parsed_response['promptFeedback'] && parsed_response['promptFeedback']['blockReason']
    block_reason = parsed_response['promptFeedback']['blockReason']
    prompt_feedback = parsed_response['promptFeedback']
    prompt_feedback = JSON.pretty_generate(prompt_feedback)
    puts "Response blocked due to: #{block_reason}"
    puts "The whole prompt feedback is listed below:
    #{prompt_feedback} " # verbose
  else
    out = parsed_response['candidates'][0]['content']['parts'][0]['text']
    formatted_output = TTY::Markdown.parse(out)
    puts formatted_output
  end
end

def rerun
  loop do
    puts 'Enter another prompt (Y) or Exit (N)?'
    choice = gets.chomp.upcase
    case choice
    when 'Y'
      prompt = get_prompt
      response = get_response(prompt)
      print_output(response)
    when 'N'
      exit
    else
      puts 'Invalid input,try again.'
    end
  end
end

prompt = get_prompt
response = get_response(prompt)
print_output(response)
rerun
