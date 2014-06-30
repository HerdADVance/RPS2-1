require 'pg'
require 'digest/sha1'

module RPS
  class ORM
    attr_reader :db
    def initialize
      @db = PG.connect(host: 'localhost', dbname: 'rps')

      playerstable = %Q[
        CREATE TABLE IF NOT EXISTS players(
          id SERIAL,
          playername text,
          username text,
          password text,
          PRIMARY KEY ( id )
          );]
      @db.exec(playerstable)


      matchtable = %Q[
        CREATE TABLE IF NOT EXISTS matches(
          id SERIAL,
          p1id integer REFERENCES players(id),
          p2id integer REFERENCES players(id),
          winner integer REFERENCES players(id),
          PRIMARY KEY ( id )
          );]
      @db.exec(matchtable)


      gametable = %Q[
        CREATE TABLE IF NOT EXISTS games(
          id SERIAL,
          p1move text,
          p2move text,
          matchid integer REFERENCES matches(id),
          PRIMARY KEY ( id )
          );]
      @db.exec(gametable)

      sessiontable = %Q[
        CREATE TABLE IF NOT EXISTS sessions(
          id SERIAL,
          userid integer REFERENCES players(id),
          sessionid text,
          PRIMARY KEY ( id )
          );]
      @db.exec(sessiontable)
    end

    ####################################################################

    def createplayer(playername, username, password)
      create = <<-SQL
      INSERT INTO players (playername, username, password)
      VALUES ('#{playername}', '#{username}', '#{password}')
      RETURNING id;
      SQL
      @db.exec(create)
    end

    def getplayer(id)
      get = <<-SQL
      SELECT * FROM players WHERE id = id;
      SQL
      @db.exec(get)
    end

    def getplayerbyusername(username)
      get= <<-SQL
      SELECT * FROM players WHERE username = '#{username}';
      SQL
      @db.exec(get)
    end

    def updateplayerpswd(password, pid)
      update = <<-SQL
      UPDATE players SET
      password = '#{password}'
      WHERE id = #{pid};
      SQL
      @db.exec(update)
    end

    def creatematch(p1id)
      create = <<-SQL
      INSERT INTO matches(p1id)
      VALUES (#{p1id})
      RETURNING id;
      SQL
      @db.exec(create)
    end

    def getmatch(matchid, p2id)
      get = <<-SQL
      SELECT * FROM matches WHERE id = #{matchid};
      SQL
      matchrow = @db.exec(get) 
      theid = matchrow.first["p1id"]
      x = RPS::Matches.new(theid)
      x.fillmatch(p2id, matchid)
    end

    def creategame(matchid)
      create =<<-SQL
      INSERT INTO games (matchid)
      VALUES(#{matchid})
      RETURNING id;
      SQL
      @db.exec(create)
    end


    #wronggngggggggggg
    # def getgame(matchid)
    #   select = <<-SQL
    #   SELECT * FROM games;
    #   SQL
    # end

    def getmove(gameid)
      get = <<-SQL
      SELECT * from games WHERE id = '#{gameid}';
      SQL
      @db.exec(get)
    end

    def insertp2 (p2id, matchid)
      insert = <<-SQL
      UPDATE matches SET 
      p2id = #{p2id}
      WHERE id = #{matchid};
      SQL
      @db.exec(insert)
    end

    def createsesh (userid)
      sessionid = Digest::SHA1.hexdigest userid
      insert = <<-SQL
      INSERT INTO sessions (sessionid, userid)
      VALUES ('#{sessionid}', #{userid});
      SQL
      @db.exec(insert)
      sessionid
    end

    def displaymatches (userid)
      get= <<-SQL
      SELECT * FROM matches WHERE p1id = #{userid} OR p2id = #{userid};
      SQL
      @db.exec(get)
    end

    #######################################################


  end


  def self.orm
    @__db_instance || ORM.new
  end

end

