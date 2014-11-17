class ErrorsController < ActionController::Base

  def not_found
    respond_to do |format|
      format.html do
        render status: 404
      end
      format.json do
        unless @lb
          render json: { error: "Not Found"}, status: :not_found and return
        end
      end
    end
  end
end
