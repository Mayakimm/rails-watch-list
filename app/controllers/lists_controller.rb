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
    if params[:list][:photo].present?
      # Upload image to Cloudinary
      result = Cloudinary::Uploader.upload(params[:list][:photo].tempfile.path, options)

      # Store the Cloudinary public ID in your model attribute
      @list.photo = result['public_id']
    end
    if @list.save
      redirect_to list_path(@list), notice: "List was successfully created."
    else
      render :new
    end
  end

  private

  def list_params
    params.require(:list).permit(:name, :photo)
  end

  def options
    # Add any Cloudinary upload options you need here
    { crop: :fill }
  end
end
