class Admin::SessionsController < Devise::SessionsController
  #users/sessions/new.html.erb
  layout "admin"
  # def new
  #   self.resource = resource_class.new(sign_in_params)
  #   clean_up_passwords(resource)
  #   respond_with(resource, serialize_options(resource))
  # end

  # def create
  #   #super
  #   resource = warden.authenticate!(auth_options)
  #   set_flash_message(:success, :signed_in) if is_navigational_format?
  #   sign_in(resource_name, resource)
  #   respond_with resource, :location => after_sign_in_path_for(resource)
  # end

  # def destroy
  #   redirect_path = after_sign_out_path_for(resource_name)
  #   signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
  #   set_flash_message :notice, :signed_out if signed_out && is_flashing_format?
  #   yield resource if block_given?

  #   # We actually need to hardcode this as Rails default responder doesn't
  #   # support returning empty response on GET request
  #   respond_to do |format|
  #     format.all { head :no_content }
  #     format.any(*navigational_formats) { redirect_to redirect_path }
  #   end
  # end
end
