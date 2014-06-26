module RPS
  class Games

   attr_reader :player1move, :player2move, :player1, :player2
    def initialize (matchid, id=nil, player1move=nil, player2move=nil, player1, player2)
      @id = id
      @player1move = player1move
      @player2move = player2move
      @player1 = player1
      @player2 = player2
      @whowon = nil
      save!
    end

    def save!
      id_from = RPS.orm.creategame############
      @id = id_from
      self #?
    end

    def update (playerid, choice)

      if player1move != nil && player2move != nil
      #########will this work
        play(@player1move, @player2move)
      end
    end


    def play (move1, move2)
      if move1 == 'rock' && move2 == 'paper'
        return :player2
        #log into games table, and determine winner and write that in winner column FOR ALL
      elsif move1 == 'rock' && move2 == 'scissors'
        return :player1
      elsif move1 == 'paper' && move2 == 'rock'
        return :player1
      elsif move1 == 'paper' && move2 == 'scissors'
        return :player2
      elsif move1 == 'scissors' && move2 == 'rock'
        return :player2
      elsif move1 == 'scissors' && move2 == 'paper'
        return :player1
      else
        return :tie
        #clear database for that game
      end
    end
  end
end