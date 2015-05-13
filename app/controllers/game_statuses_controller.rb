class GameStatusesController < ApplicationController
  before_action :set_game
  before_action :player_belongs_game?, only: [:create]
  before_action :game_closed?, only: [:create]

  def index
    @statuses = @game.statuses
  end

  def create
    begin
      ActiveRecord::Base.transaction do
        @status = @game.statuses.build(status_params)
        cashier_check
        @status.save!
        redirect_to [@game.organization, @game], notice: 'Add status successfully'
      end
    rescue => e
      logger.error(e)
      redirect_to [@game.organization, @game], error: 'Add status unsuccessfully'
    end
  end

  def destroy
    if @games.staatus.find(params[:status_id]).destroy
      redirect_to [@game.organization, @game], notice: 'Delete status successfully'
    else
      redirect_to [@game.organization, @game], error: 'Delete status unsuccessfully'
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

  def cashier_check
    if [0, 3].include?(@status.status)
      player = Player.find(params[:game_status][:player_id])
      cashier = player.cashier
      cashier.money -= @game.buy_in
      cashier.save!
    end
  end

  def game_closed?
    redirect_to [@game.organization, @game], alert: 'This game has closed' if @game.is_closed
  end
end
