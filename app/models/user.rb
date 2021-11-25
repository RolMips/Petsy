class User < ApplicationRecord

  has_many :pets

  validates :login, uniqueness: {case_sensitive: false}, presence: true, length: {minimum:3, maximum:20},
    format: {with: /\A[a-zA-Z0-9_]+\z/}

  validates :email, uniqueness: {case_sensitive: false},
    format: {with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i}

  has_secure_password
  has_secure_token :confirmation_token
  has_secure_token :recover_password
  has_image :avatar, resize: 100

  def to_session
    {id: id}
  end

# Code before has_image
=begin

  after_save :avatar_after_upload
  before_save :avatar_before_upload
  after_destroy_commit :avatar_destroy

  attr_accessor :avatar_file
  validates :avatar_file, file: {ext: [:jpg, :png]}

  def avatar_path
    File.join(Rails.public_path, 'images', self.class.name.downcase.pluralize, id.to_s, 'avatar.jpg')
  end

  def avatar_url
    '/' + ['images', self.class.name.downcase.pluralize, id.to_s, 'avatar.jpg'].join('/')
  end

  private

    def avatar_before_upload
      if avatar_file.respond_to? :path
        self.avatar = true
      end
    end

  def avatar_after_upload
    path = avatar_path
    if avatar_file.respond_to? :path
      dir = File.dirname(path)
      FileUtils.mkdir_p(dir) unless Dir.exist?(dir)
      image = MiniMagick::Image.new(avatar_file.path) do |i|
        i.resize '150x150^'
        i.gravity 'Center'
        i.crop '150x150+0+0'
      end
      image.format 'jpg'
      image.write path
    end
  end

  def avatar_destroy
    dir = File.dirname(avatar_path)
    FileUtils.rm_r(dir) if Dir.exist?(dir)
  end
=end

end
