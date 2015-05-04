class PlayersController < ApplicationController

  def show
    @players = Player.find_by(game_id: params[:game_id])
  end

  # POST /players
  # POST /players.json
  def create
    @game = Game.find(params[:game_id])
    member = Member.find(params[:player][:member_id])
    redirect_to organization_game_players_path, alert: 'Member is not belongs to Organization' unless @game.organization.members.include?(member)

    @player = @game.players.build(member_params)

    respond_to do |format|
      if @player.save
        format.html { redirect_to organization_game_path @game.organization, @game, notice: 'Player was successfully created.' }
        format.json { render action: 'show', status: :created, location: @player }
      else
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
end
