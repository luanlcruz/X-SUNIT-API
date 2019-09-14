class SurvivorsController < ApplicationController
  
  before_action :set_survivor, only: [:show, :update]
  before_action :set_calculations, only: [:abducted_percentage]


  # GET /survivors
  def index
    @survivors = Survivor.all.order(:description)

    render json: @survivors, include: [:denunciations]
    if @survivor = nil
      render json: "\nNo Survivors here Add Some!"
    end
  end

  # GET /survivors/1
  def show
    render json: @survivor, include: [:denunciations]
  end

  # POST /survivors
  def create
    @survivor = Survivor.new(survivor_params)

    if ! @survivor.description.valid_encoding?
  @survivor.description = @survivor.description.force_encoding("UTF-8")
end
    Survivor.all.each do |i|
      if @survivor.description == i.description
        return render json:  "\nThis Name Already exists!!"
      end
    end
    if @survivor.latitude.blank?
      @survivor = Survivor.find_or_create_by(
        description: @survivor.description,
        age: @survivor.age,
        sex: @survivor.sex,
        latitude: Faker::Address.latitude,
        longitude: Faker::Address.latitude

        )
    end

    

    if @survivor.save
      render json: @survivor, status: :created, location: @survivor, include: [:denunciations]
    else
      render json: @survivor.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /survivors/1
  def update
    if !@survivor.abducted
      
      if @survivor.update(survivor_params)
        render json: @survivor, include: [:denunciations]
      else
        render json: @survivor.errors, status: :unprocessable_entity
      end
    end
  end

  # Statistics Section.

  # GET /survivors/abducted_percentage
  def abducted_percentage
    render json: {
      survivors_count: @survivors_total_count.to_i,
      non_abducted: { 
        amount: @non_abducted_count.to_i,
        percentage: "#{@non_abducted_percentage}%"
      },
      abducted: {
        amount: @abducted_count.to_i,
        percentage: "#{@abducted_percentage}%"
      }
    }
  end

  # GET /survivors/abducted_survivors
  def abducted_survivors
    render json: Survivor.all.where(abducted: true).order(:description), include:[:denunciations]
  end

  # GET /survivors/non_abducted_survivors
  def non_abducted_survivors
    render json: Survivor.all.where(abducted: false).order(:description)
  end
  

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_survivor
      survivor_id = params[:id]

      if params[:location_id]
        survivor_id = Location.find(params[:location_id]).survivor_id
      elsif params[:denunciation_id]
        survivor_id = Denunciation.find(params[:denunciation_id]).survivor_id
      end
      
      @survivor = Survivor.find(survivor_id)
    end

    # Only allow a trusted parameter "white list" through.
    def survivor_params
      params.require(:survivor).permit(:description, :age, :sex, :latitude, :longitude)
    end

    #statistics calculations
    def set_calculations
      @non_abducted_count = Survivor.all.where(abducted: false).count.to_f
      @abducted_count = Survivor.all.where(abducted: true).count.to_f
      @survivors_total_count = @non_abducted_count + @abducted_count

      @non_abducted_percentage =  ((@non_abducted_count / @survivors_total_count) * 100).round(2)
      @abducted_percentage =  ((@abducted_count / @survivors_total_count) * 100).round(2)

    end

  end 
    
