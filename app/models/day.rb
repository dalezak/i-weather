class Day
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :date, :string
  attribute :max_temp, :string
  attribute :min_temp, :string
  attribute :condition, :string
  attribute :icon, :string

  validates :date, presence: true
end
