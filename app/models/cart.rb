class Cart < ApplicationRecord
  has_many :cart_items
  has_many :products, through: :cart_items

  validates_numericality_of :total_price, greater_than_or_equal_to: 0
  validates_presence_of :last_interaction_at

  def mark_as_abandoned
    if last_interaction_at < 3.hours.ago
      update(abandoned: true)
      DeleteAbandonedCartWorker.perform_in(7.days, id)
    else
      update(abandoned: false)
    end
  end

  def remove_if_abandoned
    return unless abandoned && last_interaction_at < 7.days.ago

    cart_items.destroy_all
    destroy!
  end
end
