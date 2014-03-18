class Admin::AttachmentsController < ApplicationController

  def new
    @attachment = Attachment.new
  end

  def create
    @attachment = Attachment.new(attachment_params)
    respond_to do |format|
      if @attachment.save
        format.html { redirect_to admin_users_path, notice: 'Report was successfully uploaded.' }
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
