# require 'http.rb'
require 'httparty'
require 'json'
require 'pry'
class WebhookWorker
  include Sidekiq::Worker

  def perform(endpoint, order_detail)
    response = HTTParty.post(endpoint, :body =>  {"information"=> order_detail, "passcode" => 'Webhook@123'}.to_json , :headers => { 'Content-Type' => 'application/json' } )
    # based on response something
    raise OrderDetails::FailedRequestError unless response["status"] == 200
    raise OrderDetails::AuthorizationFailedError unless response["passcode"].match(/_sub/)
  end
end
