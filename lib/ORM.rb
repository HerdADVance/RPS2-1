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
          winner integer REFERENCES players(id)
          PRIMARY KEY ( id )
          );]
      @db.exec(playerstable)


      gametable = %Q[
        CREATE TABLE IF NOT EXISTS games(
          id SERIAL,
          p1move text,
          p2move text,
          matchid REFERENCES matches(id)
          PRIMARY KEY ( id )
          );]
      @db.exec(playerstable)
    end

  end