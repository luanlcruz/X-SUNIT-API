class Denunciation < ApplicationRecord
  belongs_to :survivor
  belongs_to :sender, class_name: 'Survivor', foreign_key: "sender_id"

  validates :sender_id, numericality: { only_integer: true }
  validates :survivor_id, numericality: { only_integer: true }
end
