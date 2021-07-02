class RentMailer < ApplicationMailer
  def rent_email
    @rent = params[:rent]
    mail(
      to: @rent.user.email,
      subject: "Tanks for rent #{@rent.user.first_name} #{@rent.user.last_name}"
    )
  end
end
