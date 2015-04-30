class MembersController < ApplicationController
  def index
    redirect_to root_path unless @organization = Organization.find(params[:organization_id])
    @members = @organization.members
  end

  def create
    return unless @organization = Organization.find(params[:organization_id])
    @member = @organization.members.build(member_param)

    if @member.save
      redirect_to @organization, notice: 'Member was successfully added.'
    else
      redirect_to @organization, alert: 'Faild'
    end
  end

  def destroy
    @organization.memner(member_param).destroy
    redirect_to organization_path @organization
  end

  private

  def member_param
    params.require(:member).permit(:user_id)
  end
end
