class Price < ApplicationRecord
  belongs_to :room
  validates :value, :date_start, :date_end, presence: true
  validate :range_validate

  private

  def range_validate
    range = Range.new(self.date_start, self.date_end)
    room = self.room
    room.prices.each do |price|
      range2 = Range.new(price.date_start, price.date_end)
      if range.overlaps?range2
        self.errors.add(:date_start, 'Já exite um preço cadastrado para essas datas.')
      end
    end
  end
end
