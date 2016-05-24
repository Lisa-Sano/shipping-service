class ShippingRequestsController < ApplicationController
  def index
    requests = ShippingRequest.all

    render json: requests.as_json(except: [:id, :created_at, :updated_at]) #render as JSON EXCEPT for the created/updated_at. You can also use ONLY instead of except.
  end

  def show
    request = ShippingRequest.find_by(id: params[:id])

    if request.is_a?(ShippingRequest) #could also be if pet.present?
      render json: request.as_json(except: [:id, :created_at, :updated_at])
    else
      render json: [], status: :no_content
    end
  end
end
