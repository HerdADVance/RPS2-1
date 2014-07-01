module RPS
  class Matches

    attr_accessor :id, :p1id, :p2id, :winner

    #initialized when first person wants to play
    def initialize (p1id, id=nil, p2id=nil, winner=nil)
      @id = id
      @p1id = p1id
      @p2id = p2id
      @winner = winner
    end

    def save!
      id_from = RPS.orm.creatematch(@p1id).first["id"]
      @id = id_from
      self #?
    end



##########tscript
     def fillmatch (p2id, matchid)
        @p2id = p2id
        RPS.orm.insertp2(@p2id, matchid)
        a = RPS::Games.new(matchid) 
        a.save!
     end



  end
end
