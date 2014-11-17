class EntriesController < ApplicationController
  DEFAULT_LEADERBOARD = "ccleaders"

  def show
    @lb = retrieve_service.execute(name: params[:id])
    respond_to do |format|
      format.html do
        render 'errors/not_found', status: 404 unless @lb
      end
      format.json do
        unless @lb
          render json: { error: "Not Found"}, status: :not_found and return
        end
        render json: @lb, status: :ok
      end
    end
  end

  def create
    result = create_service.execute(entry_params)
    respond_to do |format|
      format.html do
        redirect_to root_path(page: result[:page])
      end
      format.json do
        render json: {status: :ok}
      end
    end
  end

  def index
    @entries = retrieve_service.execute(query_options)
    respond_to do |format|
      format.html do
        render 'errors/not_found', status: 404 if @entries.blank?
      end
      format.json do
        if @entries.blank?
          render json: {error: "Not found"}, status: :not_found
        end
      end
    end
  end

  def destroy
    result = delete_service.execute(name: params[:id])

    respond_to do |format|
      format.html do 
        unless result
          redirect_to root_path, status: 404 and return
        end
        redirect_to root_path
      end
      format.json do
        unless result
          render json: {error: "Not Found"}, status: 404 and return
        end
        render json: {status: "ok"}, status: 200
      end
    end
  end

  private

  def create_service
    Boards::UpdateService.new
  end

  def retrieve_service
    Boards::GetService.new
  end

  def delete_service
    Boards::DeleteService.new
  end

  def entry_params
    (params[:entry] || {}).slice(:name, :score)
  end

  def query_options
    options = {}
    options[:limit] = [params.fetch(:limit, 10).to_i, 100].min
    options[:page] = params.fetch(:page, 1)
    options
  end
end
