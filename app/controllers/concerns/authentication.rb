module Authentication
  extend ActiveSupport::Concern

  included do
    before_action :authenticate_patient!
  end

  attr_reader :current_patient

  private

  def authenticate_patient!
    @current_patient = Patient.find_by(id: params[:patient_id])

    provided_key = extract_bearer_token

    unless ActiveSupport::SecurityUtils.secure_compare(@current_patient.api_key, provided_key.to_s)
      render json: { error: "Invalid API key" }, status: :unauthorized
    end
  end

  def extract_bearer_token
    auth_header = request.headers["Authorization"]
    return unless auth_header&.start_with?("Bearer ")

    auth_header.split(" ").last
  end
end
