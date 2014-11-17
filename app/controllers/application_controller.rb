class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def not_found
    respond_to do |format|
      format.html do
        render 'errors/not_found', status: 404
      end
      format.json do
        render json: { error: 'Not Found' }, status: :not_found
      end
    end
  end
end
