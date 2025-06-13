class DeleteAbandonedCartWorker
  include Sidekiq::Worker

  sidekiq_options queue: :default

  def perform(cart_id)
    success = DeleteAbandonedCart.new(cart_id).perform
    raise StandardError, "[CartId: #{cart_id}] Failed" unless success
  end
end
