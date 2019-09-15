class DenunciationsController < ApplicationController
  after_action :verify_abducted,     only: [:create]
  before_action :set_sender,     only: [:create]
  skip_before_action :verify_authenticity_token

  # GET /denunciations
  def index
    render json: Denunciation.all
  end

  # GET /denunciations/1
  def show 
    if params[:survivor_id]
      return render json: Denunciation.where(survivor_id: params[:survivor_id])
    else
      return render json: Denunciation.where(survivor_id: params[:id])
    end

    
  end

  # POST /denunciations
  def create
      @denunciation = Denunciation.new(denunciation_params)
      if @survivor.abducted
        render json: "\nAlready Abducted!"
      else
        if !already_exists(denunciation_params)
          if @denunciation.save
            render json: @denunciation, status: :created
          else
            render json: @denunciation.errors, status: :unprocessable_entity
          end
        else
          render json: "\nAlready Denounced!"
        end
      end
  end

  private

    #To check if the denunciation already exists.
    def already_exists(params)
      @survivor.denunciations.find_by(sender_id: params[:sender_id]).present?
    end
    
    #To check errors like denounce a abducted or denounce yourself
    def action_errors
      if @sender.abducted 
        render json: "\nYou can't do this, you are already Abducted!!"
      elsif params[:sender_id] == params[:survivor_id]
        render json: "\nYou can't do this. Are you trying to report yourself?"
      end
    end
    #To check abduction
    def verify_abducted
      if @survivor.denunciations.count >= 3 
        @survivor.abducted = true
        @survivor.save!
      end
    end
    
    # The "whitelist", don't trust on the scary internet D:
    def denunciation_params
      params.require(:denunciation).permit(:survivor_id, :sender_id)
    end
    
    # Use callbacks to share common setup or constraints between actions.
    def set_sender
      @survivor = Survivor.find(params[:survivor_id])
      @sender = Survivor.find(params[:sender_id])

      action_errors
    end
  
end
