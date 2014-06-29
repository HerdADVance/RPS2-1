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

    def makemove (matchid, playerid, choice)
      #very first move, the first person to make a move becomes player 1
      #look at games in matchid
      player1idfrommatchtable= from SQL Match table find match with match id (SELECT * FROM matches where matchid = @matchid) AND RETURN p1id
      #^will return 1 match
      if pla1idfrommatchtable == playerid 
        method to update player1move
      else
        method to update player2move
      end
      if !player1move.nil? && !player2move.nil?
        play(@player1move, @player2move, matchid)
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