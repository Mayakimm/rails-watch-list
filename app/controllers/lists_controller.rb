class ListsController < ApplicationController
  def index
    @lists = List.all
  end

  def show
    @list = List.find(params[:id])
  end

  def new
    @list = List.new
    # @movie = Movie.find(params[:id])
  end

  def create
    @list = List.new(list_params)

    if @list.save
      redirect_to list_path(@list), notice: "List was successfully created."
    else
      render :new
    end
  end

  def destroy
    @list = List.find(params[:id])
    @list.destroy
    redirect_to root_path, status: :see_other
  end

  private

  def list_params
    params.require(:list).permit(:name, :photo)
  end
end
