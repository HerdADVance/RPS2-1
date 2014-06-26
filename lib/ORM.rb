require 'pg'

module RPS
  class ORM
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
    end

    ####################################################################

    def createplayer(playername, username, password)
      create = <<-SQL
      INSERT INTO players (playername, username, password)
      VALUES ('#{playername}', '#{username}', '#{password}')
      RETURNING id;
      SQL
      id = @db.exec(create).first["id"]
    end

    def getplayer(id)
      get = <<-SQL
      SELECT * FROM players WHERE id = id;
      SQL
      @db.exec(get)
    end

    #######################################################


  end


  def self.orm
    @__db_instance || ORM.new
  end

end

rps = RPS.orm


















