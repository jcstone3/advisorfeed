class Users::InvitationsController < Devise::InvitationsController
  prepend_before_filter :require_no_authentication, :only => [:edit, :update]
  #prepend_before_filter :resource_from_invitation_token, :only => [:edit]

  def edit
    render :edit
  end

  def update
    begin
      Rails.logger.debug "uuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuu"
      Rails.logger.debug params.inspect
      #resource = User.find_by_invitation_token(params[:user][:invitation_token])
      resource = user = User.find_by_invitation_token(params[:user][:invitation_token])
      # user = User.first
      Rails.logger.debug "user inspect pppppppppppppppppppppppppppppppppppppppppppp"
      Rails.logger.debug resource.inspect
      # if user.secret_text == params[:user][:secret_text]
      #   Rails.logger.debug "inside if iiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii"
      #   params[:user].delete("secret_text")
      #   if user.update_attributes(params[:user])
      #     self.resource = user.accept_invitation! if user.invitation_token?
      #     # Sign in the user bypassing validation in case his password changed
      #     sign_in user
      #     redirect_to users_dashboard_path
      #   else
      #     render :edit, locals:{ resource: resource }
      #   end
      # else
      #   render :edit, locals:{ resource: resource }
      # end
      redirect_to root_path
    rescue Exception => e
      logger.info e.message
    end
  end
end
