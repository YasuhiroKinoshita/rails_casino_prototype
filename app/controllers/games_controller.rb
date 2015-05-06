class GamesController < ApplicationController
  before_action :set_game, only: [:show, :edit, :update, :destroy]
  before_action :set_organization, only: [:new, :create]
  before_action :set_member, only: [:new, :create]
  before_action :member_belongs_organizatinon?, only: [:new, :create]
  before_action :game_owner?, only: [:edit, :update]

  # GET /games
  # GET /games.json
  def index
    @games = Game.all
  end

  # GET /games/1
  # GET /games/1.json
  def show
  end

  # GET /games/new
  def new
    @game = @member.created_games.build
  end

  # GET /games/1/edit
  def edit
  end

  # POST /games
  # POST /games.json
  def create
    @game = @member.created_games.build(game_params)
    @game.organization_id = params[:organization_id]

    respond_to do |format|
      if @game.save
        format.html { redirect_to [@organization, @game], notice: 'Game was successfully created.' }
        format.json { render action: 'show', status: :created, location: @game }
      else
        format.html { render action: 'new' }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /games/1
  # PATCH/PUT /games/1.json
  def update
    respond_to do |format|
      if @game.update(game_params)
        format.html { redirect_to @game, notice: 'Game was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /games/1
  # DELETE /games/1.json
  def destroy
    @game.destroy
    respond_to do |format|
      format.html { redirect_to games_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_game
      @game = Game.find(params[:id])
    end

    def set_organization
      @organization = Organization.find(params[:organization_id])
    end

    def set_member
      @member = Member.find_by(user_id: current_user.id, organization_id: params[:organization_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def game_params
      params.require(:game).permit(:title, :buy_in)
    end

    def member_belongs_organizatinon?
      redirect_to(organization_games, alart: 'You have no permittion') unless organization_owner?
    end

    def organization_owner?
      Organization.find(params[:organization_id]).owner == current_user
    end

    def game_owner?
      redirect_to @game, alert: 'You are not game owner' unless @game.owner.user.id == current_user.id
    end
end
