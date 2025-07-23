module Api
  module V1
    class InjectionsController < ApplicationController
      before_action :set_schedule!

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

      def set_schedule!
        drug_name = params[:injection]&.[](:drug_name) || params[:drug_name]

        @schedule = Patient.find(params[:patient_id]).schedules.find_by(drug_name: drug_name)
        unless @schedule
          render json: { error: "No schedule found for drug_name: #{drug_name}" }, status: :not_found
        end
      end
    end
  end
end
