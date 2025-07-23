class ApplicationController < ActionController::API
  def ping
    render json: { status:'injection-tracking-api is alive!' }, status: :ok
  end
end
