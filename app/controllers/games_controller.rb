class GamesController < ApplicationController
  before_action :set_game, only: [:show, :edit, :update, :destroy]
  before_action :set_organization, only: [:index, :show, :new, :create, :update]
  before_action :set_member, only: [:new, :create]
  before_action :member_belongs_organizatinon?, only: [:new, :create]
  before_action :game_editable?, only: [:edit, :update]

  # GET /games
  # GET /games.json
  def index
    @games = @organization.games
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
    begin
      ActiveRecord::Base.transaction do
        closing_game_request? ? close_game : update_game
        respond_to do |format|
          format.html { redirect_to [@organization, @game], notice: 'Game was successfully updated.' }
          format.json { head :no_content }
        end
      end
    rescue => e
      logger.error(e)
      respond_to do |fomat|
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
      format.html { redirect_to organization_games_url }
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

    def game_close_params
      params.require(:game).permit(:is_closed)
    end

    def member_belongs_organizatinon?
      redirect_to(organization_games, alart: 'You have no permittion') unless organization_owner?
    end

    def organization_owner?
      Organization.find(params[:organization_id]).owner == current_user
    end

    def game_editable?
      redirect_to @game, alert: 'You are not game owner' unless game_owner?
      if closing_game_request?
        redirect_to @game, alert: 'Game is not closable yet' unless game_closable?
      end
    end

    def game_owner?
      @game.owner.user.id == current_user.id
    end

    def closing_game_request?
      @game.is_closed == false && params[:game][:is_closed] == 'true'
    end

    # this method should move to model
    def game_closable?
      @ranking = @game.statuses.where(status: [1, 2]).includes(:player).sort_by(&:created_at).reverse
      if @ranking.first.status != 1 || @ranking.select{ |r| r.status == 1 }.size > 1
        false
      else
        true
      end
    end

    def update_game
      @game.update!(game_params)
    end

    # this method should move to model
    def close_game
      total_buy_in = @game.statuses.where(status: [0, 3]).size * @game.buy_in
      rate = [0.5, 0.3, 0.2]
      @ranking[0..2].each_with_index do |r, i|
        cashier = r.player.cashier
        cashier.money += total_buy_in * rate[i]
        cashier.save!
      end
      @game.update!(game_close_params)
    end
end
