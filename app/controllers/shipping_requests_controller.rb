class ShippingRequestsController < ApplicationController
  def index
    requests = ShippingRequest.all

<<<<<<< HEAD
    render json: requests.as_json(except: [:id, :created_at, :updated_at]) #render as JSON EXCEPT for the created/updated_at. You can also use ONLY instead of except.
=======
    #render as JSON EXCEPT for the created/updated_at. You can also use ONLY instead of except.
    render json: requests.as_json(except: [:created_at, :updated_at])
>>>>>>> 9301eb4358c0b81eb455697e636dd8fe81129d35
  end

  def show
    request = ShippingRequest.find_by(id: params[:id])
<<<<<<< HEAD
    log_record = ShippingLog.new
    log_record.response = request.as_json
    log_record.save

    if request.is_a?(ShippingRequest) #could also be if pet.present?
      render json: request.as_json(except: [:id, :created_at, :updated_at])
=======

    if request.is_a?(ShippingRequest) #could also be if request.present?
      render json: request.as_json(except: [:created_at, :updated_at])
>>>>>>> 9301eb4358c0b81eb455697e636dd8fe81129d35
    else
      render json: [], status: :not_found
    end
  end
end
