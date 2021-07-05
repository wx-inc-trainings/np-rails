class RentMailer < ApplicationMailer
  def rent_email
    @rent = params[:rent]
    mail(
      to: @rent.user.email,
      subject: "#{I18n.t(:subject)}, #{@rent.user.first_name} #{@rent.user.last_name}"
    )
  end
end
