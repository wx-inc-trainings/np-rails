class SendFinishedWorker
  include Sidekiq::Worker

  def perform(email, book)
    RentMailer.with(email: email, book_title: book).end_rent.deliver_later
  end
end
