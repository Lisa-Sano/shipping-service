

class ShippingRequestsController < ApplicationController
  skip_before_filter :verify_authenticity_token, only: [:create]

  def index
    requests = ShippingRequest.all

    #render as JSON EXCEPT for the created/updated_at. You can also use ONLY instead of except.
    render json: requests.as_json(except: [:request, :created_at, :updated_at])
  end

  def show
    request = ShippingRequest.find_by(id: params[:id])

    if request.is_a?(ShippingRequest) #could also be if request.present?
      render json: request.as_json(except: [:request, :created_at, :updated_at])
    else
      render json: [], status: :not_found
    end
  end

  def create
    # begin
       # status = Timeout::timeout(8000) {
        request = ShippingRequest.new
        request.destination_zip = params[:destination_zip]
        request.number_of_items = params[:number_of_items].to_i
        request.order_id = params[:order_id].to_i
        request.request = params
        request.estimates = request.assemble_estimates
        request.save

        if request.present?
          render json: request.as_json(except: [:request, :created_at, :updated_at])
        else
          render json: [], status: :not_found
        end 
      # }
    # rescue
    #   render json: [], status: :request_timeout
    # end
  end
end
