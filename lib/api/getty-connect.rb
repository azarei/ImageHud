require "json"
require "net/http"
require "net/https"

class GettyConnect
  attr_accessor :system_id, :system_pwd, :user_name, :user_pwd

  def initialize
    @system_id = "9999"
    @system_pwd = "8da++YMJzWX4RXCJYgf1DJN0PuLPcGnBuWFcjHiIBl0="
    @user_name = "qaterms"
    @user_pwd = "Pa55word"
  end

  def create_session
    request = {
        :RequestHeader =>
            {
                :Token => ""
            },
        :CreateSessionRequestBody =>
            {
                :SystemId => @system_id,
                :SystemPassword => @system_pwd,
                :UserName => @user_name,
                :UserPassword => @user_pwd
            }
    }

    response = post_json(request, "https://connect.gettyimages.com/v1/session/CreateSession")

    #status = response["ResponseHeader"]["Status"]
    #token = response["CreateSessionResult"]["Token"]
    #secure_token = response["CreateSessionResult"]["SecureToken"]
  end

  # token received from CreateSession/RenewSession API call
  # USAGE: asset_ids = ["1234567890","1234567890"]
  #        response = @get_image_details.go @token, asset_ids
  def get_image_details(token, assetIds)

    request = {
        :RequestHeader => {
            :Token => token,
            :CoordinationId => "MyUniqueId"
        },
        :GetImageDetailsRequestBody => {
            :CountryCode => "USA",
            :ImageIds => assetIds,
            :Language => "en-us"
        }
    }

    response = post_json(request, "https://connect.gettyimages.com/v1/search/GetImageDetails")

    # status = response["ResponseHeader"]["Status"]
    # images = response["GetImageDetailsResult"]["Images"]
  end

  def post_json(request, requestUrl)
    #You may wish to replace this code with your preferred library for posting and receiving JSON data.
    uri = URI.parse(requestUrl)
    http = Net::HTTP.new(uri.host, 443)
    http.use_ssl = true

    response = http.post(uri.path, request.to_json, {'Content-Type' =>'application/json'}).body
    JSON.parse(response)
  end
end

connection = GettyConnect.new
puts connection.create_session
