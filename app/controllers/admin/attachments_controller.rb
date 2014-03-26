class Admin::AttachmentsController < ApplicationController

  def new
    @attachment = Attachment.new
  end

  def create
    @attachment = Attachment.new(attachment_params)
    respond_to do |format|
      if @attachment.save
        user = User.find_by_id(@attachment.user_id)
        format.html { redirect_to admin_user_view_reports_path(:user_id => user.id), notice: "Successfully uploaded #{user.first_name}#{' '}#{user.last_name} report." }
      else
        Rails.logger.debug @attachment.errors.inspect
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
