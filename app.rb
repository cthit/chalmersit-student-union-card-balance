require 'sinatra'
require 'sinatra/json'

require_relative 'student_union_card_balance'

set :bind, '0.0.0.0'

get '/' do
  if params['number']
    begin
      [200, json(StudentUnionCardBalance.new.student_union_card_balance(params['number']))]
    rescue => e
      [400, json({error: e})]
    end
  else
    [400, json({"error": "no number provided"})]
  end
end
