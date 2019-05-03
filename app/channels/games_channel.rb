class GamesChannel < ApplicationCable::Channel
  def subscribed
    # stream_from games
    stream_from 'games'
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def receive(data)
    # find, update, and broadcast the game in the DB
    game = Game.find(data["id"])
    game.update!(array: data["array"])
    ActionCable.server.broadcast('games', data)
  end
  
end
