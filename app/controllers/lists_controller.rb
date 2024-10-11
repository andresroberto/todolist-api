class ListsController < ApplicationController
  before_action :set_list, only: %i[ show update destroy ]

  # GET /lists
  def index
    @lists = List.all

    render json: @lists
  end

  # GET /lists/1
  def show
    render json: @list.as_json(include: :tasks)
  end

  # POST /lists
  def create
    @list = List.new(list_params)

    if @list.save
      render json: @list, status: :created, location: @list
    else
      render json: @list.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /lists/1
  def update
    if @list.update(list_params)
      render json: @list
    else
      render json: @list.errors, status: :unprocessable_entity
    end
  end

  # DELETE /lists/1
  def destroy
    @list.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_list
      @list = List.includes(:tasks).find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def list_params
      params.require(:list).permit(:name)
    end
end
