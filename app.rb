require "sinatra"
require "sinatra/reloader"
require "better_errors"
require "binding_of_caller"

use(BetterErrors::Middleware)
BetterErrors.application_root = __dir__
BetterErrors::Middleware.allow_ip!("0.0.0.0/0.0.0.0")

CHOICES = ['rock', 'paper', 'scissors']

def game_results(user, computer)
  if user == computer
    "We tied!"
  elsif
    (user == 'rock' && computer == 'scissors') ||
    (user == 'paper' && computer == 'rock') ||
    (user == 'scissors' && computer == 'paper')
    "We won!"
  else
    "We lost!"
  end
end

def play_game
  user_choice = params.fetch("choice")
  computer_choice = CHOICES.sample
  result = game_results(user_choice, computer_choice)
  [user_choice, computer_choice, result]
end

get("/") do
  erb :rules, layout: :layout
end

get("/:choice") do
  @user_choice, @computer_choice, @result = play_game
  erb :results
end
