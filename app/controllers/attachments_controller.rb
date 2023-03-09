class AttachmentsController < ApplicationController
  def destroy
    @attachment = ActiveStorage::Attachment.find(params[:id])
    @attachment.purge
    respond_to do |format|
      format.html { redirect_to request.refferer, success: "Attachment removed." }
      format.turbo_stream { flash.now[:success] = "Attachment removed." }
    end
  end
end
