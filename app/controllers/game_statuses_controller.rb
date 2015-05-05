class GameStatusesController < ApplicationController
  before_action :set_game
  before_action :player_belongs_game?, only: [:create]

  def index
    @statuses = @game.statuses
  end

  def create
    if @game.statuses.build(status_params).save
      redirect_to @game, notice: 'Add status successfully'
    else
      redirect_to @game, error: 'Add status unsuccessfully'
    end
  end

  def destroy
    if @games.staatus.find(params[:status_id]).destroy
      redirect_to @game, notice: 'Delete status successfully'
    else
      redirect_to @game, error: 'Delete status unsuccessfully'
    end
  end

  private

  def set_game
    @game = Game.find(params[:game_id])
  end

  def status_params
    params.require(:game_status).permit(:player_id, :status)
  end

  def player_belongs_game?
    player = Player.find(params[:game_status][:player_id])
    redirect_to @game, error: 'Player is not belongs to Game' unless @game.players.include?(player)
  end
end
