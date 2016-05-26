class ShippingRequestsController < ApplicationController
  def index
    requests = ShippingRequest.all


    #render as JSON EXCEPT for the created/updated_at. You can also use ONLY instead of except.
    render json: requests.as_json(except: [:request, :created_at, :updated_at])
  end

  def show
    request = ShippingRequest.find_by(id: params[:id])
    post_body = @_request.raw_post

    if request.is_a?(ShippingRequest) #could also be if request.present?
      render json: request.as_json(except: [:request, :created_at, :updated_at])
    else
      render json: [], status: :not_found
    end
  end
end
