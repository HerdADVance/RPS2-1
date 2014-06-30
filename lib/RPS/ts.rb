require 'pry-byebug'

module RPS 
  class TS

    def self.checkmatch(playerid)
      newdb = RPS.orm.db
      check = <<-SQL
        SELECT * FROM matches ORDER BY id DESC LIMIT 1;
      SQL
      p2id = newdb.exec(check).first["p2id"]
      matchid = newdb.exec(check).first["id"]
      if p2id == nil
        RPS.orm.getmatch(matchid, playerid)
      else
        a = RPS::Matches.new(playerid)
        a.save!
      end
    end

    def self.finduser(theid)
      newdb = RPS.orm.db
      get = <<-SQL
        SELECT * FROM sessions WHERE sessionid = '#{theid}';
      SQL
      result = newdb.exec(get)
      result.first["userid"]
    end
  





  end
end