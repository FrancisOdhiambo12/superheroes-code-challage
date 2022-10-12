class PowersController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

    def index
        render json: Power.all, status: :ok
    end

    def show
        power = Power.find(params[:id])
        render json: power, status: :ok
    end

    def update
        power = Power.find(params[:id])
        power.update!(power_params)
        render json: power, status: :accepted
    end

    private

    def power_params
        params.permit(:description)
    end

    def render_not_found_response
        render json: {error: "Power not found"}, status: :not_found
    end

    def render_unprocessable_entity_response(exception)
        render json: { errors: exception.record.errors.full_messages }, status: :unprocessable_entity
    end
end
