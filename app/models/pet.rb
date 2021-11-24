class Pet < ApplicationRecord
  belongs_to :user
  belongs_to :species

  validates :name, :gender, :birthday, presence: true
  validates :gender, format: {with: /\A(M|F)\z/}
  validate :birthday_not_future

  def age
    Time.now.year - birthday.year
  end

  def birthday_not_future
    if birthday.present? && birthday.future?
      errors.add(:birthday, 'not in the future')
    end
  end

end
