class Pet < ApplicationRecord
  belongs_to :user
  belongs_to :species, counter_cache: true

  validates :name, :gender, :birthday, presence: true
  validates :gender, format: {with: /\A(M|F)\z/}
  validates :avatar_file, presence: true, on: :create

  validate :birthday_not_future

  has_image :avatar

  def age
    if Time.now.year == birthday.year and  Time.now.month == birthday.month
      [Time.now.day - birthday.day,'jour'.pluralize(Time.now.day - birthday.day)].join(' ')
    elsif Time.now.year == birthday.year and Time.now.month != birthday.month
      [Time.now.month - birthday.month,'mois'].join(' ')
    else
      [Time.now.year - birthday.year,'an'.pluralize(Time.now.year - birthday.year)].join(' ')
    end
  end

  def birthday_not_future
    if birthday.present? && birthday.future?
      errors.add(:birthday, 'not in the future')
    end
  end

end
