class EnquiriesController < ApplicationController
  def new
    @enquiry = Enquiry.new
  end

  def create
    @enquiry = Enquiry.new
    if @enquiry.save(enquiry_params)
      redirect_to new_enquiry_path, notice: 'Enquiry Successfully Submitted.'
    else
      flash[:error] = @enquiry.errors.full_messages.join('\n')
      render "new"
    end
  end

  private

    def enquiry_params
      params.require(:enquiry).permit(:first_name, :last_name, :email, :phone_number, :message)
    end
end