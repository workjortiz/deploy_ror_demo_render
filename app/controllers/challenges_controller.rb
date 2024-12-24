class ChallengesController < ApplicationController
  before_action :set_challenge, only: %i[ destroy ]

  require "net/http"
  require "json"

  # GET /challenges or /challenges.json
  def index
    @challenges = Challenge.order(created_at: :desc).paginate(page: params[:page], per_page: 10)
  end

  # GET /challenges/1 or /challenges/1.json
  def show
    @challenge = Challenge.where(id: params[:id]).first
    if !@challenge.present?
      redirect_to challenge_delete_success_path
    end
  end

  # GET /challenges/new
  def new
    @challenge = Challenge.new
  end

  # GET /challenges/1/edit
  def edit
  end

  # POST /challenges or /challenges.json
  def create
    @challenge = Challenge.new(challenge_params)
    @result = @challenge.process_content

    if @result.class == Array
      puts "ERRORS METHOD"
      respond_to do |format|
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @result, status: :unprocessable_entity }
      end
    else
      respond_to do |format|
        @challenge.parsing_content = @result
        @challenge.token = SecureRandom.base64(10)

        if @challenge.save
          puts "MODEL SAVE"
          format.html { redirect_to @challenge, notice: "Challenge was successfully created." }
        else
          puts "ERRORS VALIDATE"
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @challenge.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /challenges/1 or /challenges/1.json
  def destroy
    @challenge.destroy!

    respond_to do |format|
      format.html { redirect_to challenges_path, status: :see_other, notice: "Challenge was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_challenge
      @challenge = Challenge.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def challenge_params
      params.require(:challenge).permit(:name, :country, :original_content, :parsing_content, :token)
    end
end
