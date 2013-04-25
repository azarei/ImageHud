class ImagesController < ApplicationController
  def index
	@image_id = 103166876

	# Get connect api token
    require 'create_session_sample.rb'
    sessionDataHelper = CreateSessionSample.new
    sessionData = sessionDataHelper.create_session
    token = sessionData["CreateSessionResult"]["Token"]

	@searchResults = [
	{imageUrl:"http://cache1.asset-cache.net/xr/103166876.jpg?v=1&c=IWSAsset&k=3&d=6C4008C0FD9EB5A55CB548C4521091CA4B81E98A67C015EC96ABDA4469A89B69", ImageId:1},
	{imageUrl:"http://cache1.asset-cache.net/xr/103166876.jpg?v=1&c=IWSAsset&k=3&d=6C4008C0FD9EB5A55CB548C4521091CA4B81E98A67C015EC96ABDA4469A89B69", ImageId:2},
	{imageUrl:"http://cache1.asset-cache.net/xr/103166876.jpg?v=1&c=IWSAsset&k=3&d=6C4008C0FD9EB5A55CB548C4521091CA4B81E98A67C015EC96ABDA4469A89B69", ImageId:3},
	{imageUrl:"http://cache1.asset-cache.net/xr/103166876.jpg?v=1&c=IWSAsset&k=3&d=6C4008C0FD9EB5A55CB548C4521091CA4B81E98A67C015EC96ABDA4469A89B69", ImageId:4},
	{imageUrl:"http://cache1.asset-cache.net/xr/103166876.jpg?v=1&c=IWSAsset&k=3&d=6C4008C0FD9EB5A55CB548C4521091CA4B81E98A67C015EC96ABDA4469A89B69", ImageId:5}
	]

	if !params.nil? && !params[:search].nil?
	  @searchText = params['search']['text']
	  @rawSearchResults = sessionDataHelper.search_for_images(token, @searchText)
	  @searchResults = @rawSearchResults['SearchForImagesResult']['Images']
	  if !@searchResults.empty?
	    @image_id = @searchResults[1]['ImageId']
	  end
	end

	#['SearchForImagesResult']['Images']['UrlThumb']

    @imageData = sessionDataHelper.get_image_details(token, [@image_id])
  end

  def data
    require 'create_session_sample.rb'
    sessionDataHelper = CreateSessionSample.new
    sessionData = sessionDataHelper.create_session
    token = sessionData["CreateSessionResult"]["Token"]
    @imageData = sessionDataHelper.get_image_details(token, [params['id']])

    respond_to do |format|
      format.json { render :json => @imageData }
    end
  end
end
