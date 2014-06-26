module RPS
  class Matches

    attr_accessor :id, :p1id, :p2id, :winner

    #initialized when first person wants to play
    def initialize (id=nil, p1id, p2id=nil, winner=nil)
      @id = id
      @p1id = p1id
      @p2id = p2id
      @winner = winner
      save!
    end

    def save!
      id_from = RPS.orm.creatematch############
      @id = id_from
      self #?
    end
    #starts when second person wants to play
    def startmatch (p2id)
      @p2id = p2id
      #affect front-end
      RPS.Games.new(@id) 
    end



  end
end
