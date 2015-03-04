class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def query_options
    options = {}
    options[:limit] = [params.fetch(:limit, 10).to_i, 100].min
    options[:page] = params.fetch(:page, 1)
    options
  end

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
