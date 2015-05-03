class MembersController < ApplicationController
  def index
    redirect_to root_path unless @organization = Organization.find(params[:organization_id])
    @members = @organization.members
  end

  def create
    return unless @organization = Organization.find(params[:organization_id])
    begin
      ActiveRecord::Base.transaction do
        @member = @organization.members.build(member_param)
        @member.save!
        @cashier = @member.build_cashier
        @cashier.save!
        redirect_to @organization, notice: 'Member was successfully added.'
      end
    rescue => e
      logger.error(e)
      redirect_to @organization, alert: 'Faild'
    end
  end

  def destroy
    @organization.memner(member_param).destroy
    redirect_to organization_path @organization
  end

  def cashier
    @cashier = Cashier.find_by(member_id: params[:id])
  end

  private

  def member_param
    params.require(:member).permit(:user_id)
  end
end
