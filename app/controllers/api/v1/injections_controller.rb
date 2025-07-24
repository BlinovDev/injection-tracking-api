module Api
  module V1
    class InjectionsController < ApplicationController
      include FindSchedule

      def create
        injection = @schedule.injections.build(
          dose: params[:injection][:dose],
          lot_number: params[:injection][:lot_number],
          injected_at: Time.current
        )

        if injection.save
          render json: injection, status: :created
        else
          render json: { errors: injection.errors.full_messages }, status: :unprocessable_entity
        end
      end

      private

      def injection_params
        params.require(:injection).permit(:dose, :lot_number)
      end
    end
  end
end
