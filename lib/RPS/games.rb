module RPS
  class Games

   attr_reader :player1move, :player2move, :player1, :player2
    def initialize (matchid, id=nil, player1move=nil, player2move=nil)
      @matchid = matchid
      @id = id
      @player1move = player1move
      @player2move = player2move
      @whowon = nil
    end

    def save!
      id_from = RPS.orm.creategame(@matchid)
      @id = id_from
      self #?
    end

    def updatemove (themove, )
      case 
        when getmove(@id).first["p1move"] == nil && getmove(@id).first["p2move"] == nil
          updatemovemethodinSQL(themove)


          @player1move == nil && @player2move == nil
        when @player1move == nil && @player2move != nil
          #put in the move in the database
          play()
        when @player1move != nil && @player2move == nil
          #insert move in db
      end

    end


    def play (move1, move2, matchid)
      if move1 == 'rock' && move2 == 'paper'
        #winner is player2
        #log into games table, and determine winner and write that in winner column FOR ALL
        method = check to see if in a specific matchid there are three wins
        arrayofwins = SELECT winner from games where match_id = matchid AND winner = player2
        if arrayofwins.count == 3
          return player2sid 
          #log winner in match (do this for all the other ones)
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
        #method to clear the last game
      end
    end
  end
end