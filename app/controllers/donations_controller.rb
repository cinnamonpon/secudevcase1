class DonationsController < ApplicationController
  before_action :logged_in_user
  before_action :correct_user, only: [:show]

  def index
    @donations = current_user.donations.paginate(:page => params[:page])
  end

  def donate
    @donation = current_user.donations.build(amount: params[:amount])
    if @donation.save
      redirect_to @donation.paypal_url(donation_path(@donation))
    end
  end

  def show
    @donation = Donation.find params[:id]
  end

  private
    def correct_user
      @donation = current_user.donations.find_by(id: params[:id])
      if @donation.nil? || !current_user.admin?
        flash[:danger] = "Unauthorized access. Try again."
        redirect_to root_url
      end
    end
end
