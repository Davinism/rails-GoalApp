class Goal < ActiveRecord::Base
  validates :description, :user_id, :privacy, :progress, presence: true
  validates :progress, inclusion: { in: (0..100) }
  validates :privacy, inclusion: { in: ["private", "public"] }

  has_many :comments
  belongs_to :user
end
