class Reservation < ApplicationRecord
  belongs_to :room
  belongs_to :user
  after_validation :generate_total, on: :create
  validates :start_date, :end_date, :guest_number, presence: true
  enum status: {pending: 0, confirmed: 1, canceled: 2}
  validate  :guests_validation, :start_future, :end_future
  validate  :room_occuped_validate, on: [:create, :reservation_create]


private

  def guests_validation
    if room.present? && self.guest_number.present? && self.guest_number > self.room.capacity
      self.errors.add(:base, 'Capacidade superior ao do quarto')
    end
  end
  def start_future
    if self.start_date.present? && self.start_date < Date.today
      self.errors.add(:start_date, 'precisa estar no futuro')
    end
  end
  def end_future
    if self.end_date.present? && self.end_date <= self.start_date
      self.errors.add(:end_date, 'precisa ser maior que data de entrada')
    end
  end

  def room_occuped_validate
    if room.present?
      room = self.room
      occuped = room.reservations.where('status != ? AND ? < end_date AND ? > start_date',
                                        Reservation.statuses[:canceled], start_date, end_date)
      if occuped.exists?
        self.errors.add(:base, 'Estas datas não estão disponíveis')
      end
    end
  end

  def generate_total
    if room.present? && self.start_date.present? && self.end_date.present?
      range = (self.start_date...self.end_date).to_a
      room = self.room
      prices_ar = []
      range.each do |date|
        presence = false
        room.prices.each do |price|
          if date.between?(price.date_start, price.date_end)
            presence = true
            prices_ar << price.value.to_i
            break
          end
          end
        if presence != true
            prices_ar << room.default_price.to_i
        end
          self.total_value = prices_ar.sum
      end
    end
  end

end
