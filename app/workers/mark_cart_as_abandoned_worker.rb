class MarkCartAsAbandonedWorker
  include Sidekiq::Worker

  sidekiq_options queue: :default

  def perform(cart_id)
    success = MarkCartAsAbandoned.new(cart_id).perform
    raise StandardError, "[CartId: #{cart_id}] Failed" unless success
  end
end
