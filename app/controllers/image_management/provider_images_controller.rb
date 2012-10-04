module ImageManagement
  class ProviderImagesController < ApplicationController
    respond_to :json, :only => :update

    before_filter :factory_keys, :only => :update

    def index
      @provider_images = ImageManagement::ProviderImage.all unless defined? @provider_images
      respond_with @provider_images
    end

    def show
      @provider_image = ImageManagement::ProviderImage.find(params[:id]) unless defined? @provider_image
      respond_with @provider_image
    end

    def new
      @provider_image = ImageManagement::ProviderImage.new
      respond_with @provider_image
    end

    def edit
      @provider_image = ImageManagement::ProviderImage.find(params[:id]) unless defined? @provider_image
      respond_with @provider_image
    end

    def create
      @provider_image = ProviderImage.new(params[:provider_image]) unless defined? @provider_image
      if @provider_image.save
        flash[:notice] = 'Image version was successfully created.'
      end
      respond_with @provider_image
    end

    def update
      @provider_image = ImageManagement::ProviderImage.find(params[:id]) unless defined? @provider_image
      if @provider_image.update_attributes(params[:provider_image])
        flash[:notice] = 'Provider image was successfully updated.'
      end
      respond_with @provider_image
    end

    def destroy
      @provider_image = ImageManagement::ProviderImage.find(params[:id]) unless defined? @provider_image
      @provider_image.destroy
      respond_with @provider_image
    end

    private
    # TODO Add factory permission check
    def factory_keys
      if params[:provider_image][:percent_complete] && params[:provider_image][:status_detail][:activity]
        params[:provider_image][:progress] = params[:provider_image].delete(:percent_complete)
        params[:provider_image][:status_detail] = params[:provider_image].delete(:status_detail)[:activity]
        params[:provider_image][:status] = params[:provider_image].delete(:status)
      end
    end
  end
end