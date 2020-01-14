class RegistrationsController < Devise::RegistrationsController

  protected

  def update_resource(resource, params)
    # byebug
    resource.update_without_current_password(params)
  end
end