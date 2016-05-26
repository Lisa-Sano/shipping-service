class ShippingRequestsController < ApplicationController
  skip_before_filter :verify_authenticity_token, only: [:create]

  def index
    requests = ShippingRequest.all

    #render as JSON EXCEPT for the created/updated_at. You can also use ONLY instead of except.
    render json: requests.as_json(except: [:request, :created_at, :updated_at])
  end

  def show
    request = ShippingRequest.find_by(id: params[:id])
    log_record = ShippingLog.new
    log_record.response = request.as_json
    log_record.save

    if request.is_a?(ShippingRequest) #could also be if request.present?
      render json: request.as_json(except: [:request, :created_at, :updated_at])
    else
      render json: [], status: :not_found
    end
  end

  def create
    request = ShippingRequest.new
    request.destination_zip = params[:destination_zip]
    request.number_of_items = params[:number_of_items].to_i
    request.order_id = params[:order_id].to_i
    request.estimates = {'UPS' => '3900'}
    request.save

    if request.present?
      render json: request.as_json(except: [:request, :created_at, :updated_at])
    else
      render json: [], status: :not_found
    end
  end

  # private

  # def create_params
  #   params.permit(:destination_zip, :number_of_items, :order_id)
  # end

end
