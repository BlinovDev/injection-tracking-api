module FindSchedule
  extend ActiveSupport::Concern

  included do
    before_action :set_schedule!
  end

  private

  def extract_drug_name
    params[:drug_name] || params.dig(:injection, :drug_name)
  end

  def set_schedule!
    drug_name = extract_drug_name

    unless drug_name.present?
      render json: { error: "Missing drug_name parameter" }, status: :bad_request and return
    end

    @schedule = @current_patient.schedules.find_by(drug_name: drug_name)

    unless @schedule
      render json: { error: "No schedule found for drug_name: #{drug_name}" }, status: :not_found
    end
  end
end
