class Film
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::GridFsHelper

  field :title, type: String
  mount_uploader :poster, PosterUploader
  field :year, type: Date
  field :trailer, type: String
  field :director, type: String
  field :description, type: String
  field :genres, type: Array
  field :online_cinemas, type: Array

  # before_destroy :delete_image_directory
  before_save :process_genres
  before_save :process_online_cinemas

  private

  def delete_image_directory
    # Получаем путь к директории с изображением
    image_path = poster.current_path

    # Проверяем, существует ли директория, и удаляем ее
    if File.directory?(File.dirname(image_path))
      FileUtils.rm_rf(File.dirname(image_path))
    end
  end

  def process_genres
    self.genres = genres.split(',').map(&:strip) if genres.is_a?(String)
  end

  def process_online_cinemas
    self.online_cinemas = online_cinemas.split(',').map(&:strip) if online_cinemas.is_a?(String)
  end
end