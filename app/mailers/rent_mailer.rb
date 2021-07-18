class RentMailer < ApplicationMailer
  def rent_email
    @rent = params[:rent]
    @book = @rent.book
    puts "=====> #{@rent.id}"
    puts "======> #{@book.title}"
    mail(
      to: @rent.user.email,
      subject: "#{I18n.t(:subject)}, #{@rent.user.first_name} #{@rent.user.last_name}"
    )
  end

  def end_rent
    @book_title = params[:book_title]
    mail(to: params[:email], subject: I18n.t(:finished_subject).to_s)
  end
end
