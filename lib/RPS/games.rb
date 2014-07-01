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

    def updatemove (move, userid, matchid)
      thegameid = RPS.orm.getmostrecentgame(matchid).first["id"]
      p1column = RPS.orm.getmostrecentgame(matchid).first["p1move"]
      p2column = RPS.orm.getmostrecentgame(matchid).first["p2move"]

        if RPS.orm.getmatchbymatchid(matchid).first["p1id"] == userid && (p1column != 'rock' && p1column != 'paper' && p1column != 'scissors')
          RPS.orm.p1makemove(thegameid, move)
        elsif RPS.orm.getmatchbymatchid(matchid).first["p2id"] == userid && (p2column != 'rock' && p2column != 'paper' && p2column != 'scissors')
          RPS.orm.p2makemove(thegameid, move)
        else
        end
        updatedp1move = RPS.orm.getmostrecentgame(matchid).first["p1move"]
        updatedp2move = RPS.orm.getmostrecentgame(matchid).first["p2move"]

        if (updatedp1move == 'rock' || updatedp1move == 'scissors' || updatedp1move == 'paper') && (updatedp2move == 'rock' || updatedp2move == 'scissors' || updatedp2move == 'paper')
          play(updatedp1move, updatedp2move, matchid)
        else
        end
    end


    def play (move1, move2, matchid)
      thegameid = RPS.orm.getmostrecentgame(matchid).first["id"]
      result = nil
      player1id = RPS.orm.getmatchbymatchid(matchid).first["p1id"]
      player2id = RPS.orm.getmatchbymatchid(matchid).first["p2id"]
      if move1 == 'rock' && move2 == 'paper'
        result = player2id
      elsif move1 == 'rock' && move2 == 'scissors'
        result = player1id
      elsif move1 == 'paper' && move2 == 'rock'
        result = player1id
      elsif move1 == 'paper' && move2 == 'scissors'
        result = player2id
      elsif move1 == 'scissors' && move2 == 'rock'
        result = player2id
      elsif move1 == 'scissors' && move2 == 'paper'
        result = player1id
      else
        result = 0
      end
      RPS.orm.insertresult(thegameid, result)

      allrows = RPS.orm.getgamesbymatch(matchid)
      p1wins = 0
      p2wins = 0
      allrows.each do |x|
        if x["winner"] == player1id
          p1wins += 1
        elsif x["winner"] == player2id
          p2wins += 1
        end
      end

      if p1wins == 3 
        RPS.orm.setmatchwinner(matchid, player1id)
      elsif p2wins == 3
        RPS.orm.setmatchwinner(matchid, player2id)
      else
        RPS.orm.creategame(matchid)
      end


    end
  end
end