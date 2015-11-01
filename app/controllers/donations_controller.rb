class DonationsController < ApplicationController
  def donate
    @donation = current_user.donations.build(amount: params[:amount])
    if @donation.save
      redirect_to @donation.paypal_url(donation_path(@donation))
    end
  end

  def show
    @donation = Donation.find params[:id]
  end
end
