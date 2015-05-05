class PlayersController < ApplicationController
  before_action :set_game, only: [:show, :create]
  before_action :member_belongs_organizatino?, only: [:create]

  def show
    @players = Player.find_by(game_id: params[:game_id])
  end

  # POST /players
  # POST /players.json
  def create
    @player = @game.players.build(member_params)

    begin
      @player.save!
      @join_status = @player.statuses.build(status: 0, money_changes: -(@game.buy_in))
      @join_status.save!
      respond_to do |format|
        format.html { redirect_to organization_game_path @game.organization, @game, notice: 'Player was successfully created.' }
        format.json { render action: 'show', status: :created, location: @player }
      end
    rescue => e
      logger.error(e)
      respond_to do |format|
        format.html { render action: 'new' }
        format.json { render json: @player.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def player_params
      params.require(:player).permit(:user_id, :game_id)
    end

    def member_params
      params.require(:player).permit(:member_id)
    end

    def set_game
      @game = Game.find(params[:game_id])
    end

    def member_belongs_organizatino?
      member = Member.find(params[:player][:member_id])
      if ! @game.organization.members.include?(member)
        flash[:error] = 'Member is not belongs to Organization'
        redirect_to @game.organization
      end
    end
end
