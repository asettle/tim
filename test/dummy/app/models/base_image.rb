require File.expand_path('../../app/models/image_management/base_image', ImageManagement::Engine.called_from)

module ImageManagement
  class BaseImage
    belongs_to :user
  end
end