class PropertiesController < ApplicationController
  # GET /properties
  # GET /properties.json
  def index
    @properties = Property.all

    if user_signed_in?
      @user = User.find(current_user)
    end

    if(params[:layout] == 'false')
      render :layout => false
    else
      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @properties }
      end
    end
  end

  def properties
    @properties = Property.all

    @highest_price = Property.highest_price
    @highest_price = 0 if @highest_price.nil?

    respond_to do |format|
      format.js { render :layout => false }
    end
  end

  # GET /properties/1
  # GET /properties/1.json
  def show
    @property = Property.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @property }
    end
  end

  # GET /properties/new
  # GET /properties/new.json
  def new
    $counter = 0
    @property = Property.new
    @property.photos.build

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @property }
    end
  end

  # GET /properties/1/edit
  def edit
    $counter = 0
    @property = Property.find(params[:id])
    @property.photos.build
  end

  # POST /properties
  # POST /properties.json
  def create
    @property = Property.new(params[:property])
    @property.featured = false
    @property.landlord_id = User.find(current_user).landlord.id

    amount = 5000 # amount in cents

    customer = Stripe::Customer.create(
      :email => current_user.email,
      :card  => params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      :customer => customer.id,
      :amount   => amount,
      :description => 'Geneseo Off Campus',
      :currency => 'usd'
    )
    
    respond_to do |format|
      if @property.save
        format.html { redirect_to '/dashboard', notice: 'Property was successfully created.' }
        format.json { render json: @property, status: :created, location: @property }
      else
        format.html { render action: "new" }
        format.json { render json: @property.errors, status: :unprocessable_entity }
      end
    end

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to properties_path
  end

  # PUT /properties/1
  # PUT /properties/1.json
  def update
    @property = Property.find(params[:id])

    respond_to do |format|
      if @property.update_attributes(params[:property])
        format.html { redirect_to '/dashboard', notice: 'Property was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @property.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /properties/1
  # DELETE /properties/1.json
  def destroy
    @property = Property.find(params[:id])
    @property.destroy

    respond_to do |format|
      format.html { redirect_to '/dashboard' }
      format.json { head :no_content }
    end
  end

  private
  def property_params
    params.require(:property).permit(:address, :description, :square_footage, :bedrooms, :rooms, :laundy, :price, :unit, :summer, :utilities, :parking)
  end
end
