module Api
  module V1
    class PatientsController < ApplicationController
      def create
        patient = Patient.new(patient_params)

        if patient.save
          render json: patient, status: :created
        else
          render json: { errors: patient.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def show
        patient = Patient.find_by(id: params[:id])

        if patient
          render json: patient, status: :ok
        else
          render json: { error: "Patient not found" }, status: :not_found
        end
      end

      private

      def patient_params
        params.require(:patient).permit(:name)
      end
    end
  end
end
