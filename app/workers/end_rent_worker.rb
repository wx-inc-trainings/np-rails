class EndRentWorker
  include Sidekiq::Worker

  def perform
    Rent.rent_end.each do |rent|
      SendFinishedWorker.perform_async(rent.user.email, rent.book.title)
    end
  end
end
