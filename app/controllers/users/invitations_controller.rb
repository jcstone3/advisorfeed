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
      resource = user = User.find_by_invitation_token(params[:user][:invitation_token], FALSE)

      # user = User.where(invitation_token: params[:user][:invitation_token]).take
      # user = User.where("invitation_token = ?", params[:user][:invitation_token])
      # resource = user = User.find_by_invitation_token params[:user][:invitation_token]
      # user = User.first
      Rails.logger.debug "user inspect pppppppppppppppppppppppppppppppppppppppppppp"
      Rails.logger.debug user.inspect
      Rails.logger.debug user.id.inspect
      Rails.logger.debug user.secret_text.inspect
      Rails.logger.debug params[:user][:secret_text].inspect

      if user.secret_text == params[:user][:secret_text]
        Rails.logger.debug "inside if iiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii"
        params[:user].delete("secret_text")
        Rails.logger.debug params.inspect
        if user.update_attributes(user_params.except(:invitation_token))
          Rails.logger.debug "inside if if iiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii"
          self.resource = user.accept_invitation! if user.invitation_token?
          # Sign in the user bypassing validation in case his password changed
          sign_in user
          redirect_to users_dashboard_path
        else
          Rails.logger.debug "inside if else iiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii"
          render :edit, locals:{ resource: resource }
        end
      else
        Rails.logger.debug "inside else iiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii"
        render :edit, locals:{ resource: resource }
      end
    rescue Exception => e
      logger.info e.message
    end
  end

  private

  def user_params
    params.require(:user).permit(:password, :password_confirmation, :secret_text, :invitation_token)
  end
end
