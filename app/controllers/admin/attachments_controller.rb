class Admin::AttachmentsController < ApplicationController

  def new
    @attachment = Attachment.new
    @user = User.find_by_id(params[:user_id])
    @reports = @user.attachments.order('created_at desc')
  end

  def create
    @attachment = Attachment.new(attachment_params)
    @user = User.find_by_id(@attachment.user_id)
    respond_to do |format|
      if @attachment.save
        @reports = @user.attachments
        format.html { redirect_to admin_user_view_reports_path(:user_id => @user.id), notice: "Successfully uploaded #{@user.first_name}#{' '}#{@user.last_name} report." }
      else
        @reports = @user.attachments
        format.html { render action: 'new' }
      end
    end
  end

  def destroy

  end

  private

  def attachment_params
    params.require(:attachment).permit(:file_name, :file_note, :avatar).merge(user_id: params[:user_id])
  end
end
