module Api
  module V1
    class AirlinesController < ApplicationController

      # ActionController::InvalidAuthenticityToken in Api::V1::AirlinesController#create
      protect_from_forgery with: :null_session

      # index method
      def index
        airlines = Airline.all
        render json: AirlinesSerializer.new(airlines, options).serialized_json
      end

      # show method
      def show
        airline = Airline.find_by(slug: params[:slug])
        render json: AirlinesSerializer.new(airline, options).serialized_json
      end

      # create method
      def create
        airline = Airline.new(airline_params)

        if airline.save
          render json: AirlinesSerializer.new(airline).serialized_json
        else
          render json: {error: airline.errors.messages}, status: 422
        end

      end

      # update method
      def update
        airline = Airline.find_by(slug: params[:slug])

        if airline.update(airline_params)
          render json: AirlinesSerializer.new(airline, options).serialized_json
        else
          render json: {error: airline.errors.messages}, status: 422
        end

      end

      # destroy method
      def destroy
        airline = Airline.find_by(slug: params[:slug])

        if airline.destroy
          head :no_content
        else
          render json: {error: airline.errors.messages}, status: 422
        end

      end


      private

      def airline_params
        params.require(:airline).permit(:name, :image_url)
      end

      def options
        @options ||= {include: %i[reviews]}
      end
    end
  end
end
