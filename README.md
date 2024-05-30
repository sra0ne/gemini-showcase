# README

## Overview

This Ruby script interacts with the Google Gemini API to generate content based on user prompts. It takes input from the user, sends it to the API, and formats the response using the `tty-markdown` gem. If the response is blocked, the script provides feedback on the reason for the block. Users can continuously enter new prompts or exit the program.

## Prerequisites

- Ruby installed on your system
- An API key for the Gemini API,you can get one for free [here](https://aistudio.google.com/app/apikey)

## Installation

1. Clone the repository or download the script.
2. Install the tty-markdown gem(since by default gemini includes markdown formatting):
   ```sh
   gem install tty-markdown
   ```
3. Set your Gemini API key as an environment variable:
   ```sh
   export API_KEY=your_gemini_api_key
   ```

## Usage

1. Run the script:
   ```sh
   ruby gentext.rb
   ```
2. Enter a prompt when prompted by the script.
3. The script will send the prompt to the Gemini API and display the formatted response.
4. If the response is blocked, the script will inform you of the block reason and provide the entire prompt feedback.
5. You can enter new prompts or exit the program.

## License

This project is licensed under the MIT License. See the [LICENSE](https://github.com/sra0ne/gemini-showcase/blob/main/LICENSE) file for details.
