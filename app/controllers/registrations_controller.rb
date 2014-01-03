# app/controllers/registrations_controller.rb
class RegistrationsController < Devise::RegistrationsController
  def new
    resource = build_resource({})
    resource.build_landlord
    respond_with resource
  end

  def create
    super

    @landlord = Landlord.new()
    @landlord.user_id = resource.id
    @landlord.email = resource.email
    @landlord.name = params['landlord']['name']
    @landlord.phone = params['landlord']['phone']
    @landlord.hide_email = false
    @landlord.save
  end

  def update
    super
  end

  def cancel
    super
  end

  def destroy
    super
  end
end 
