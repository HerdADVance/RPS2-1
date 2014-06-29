require 'digest/sha1'


module RPS
  class User

    attr_reader :id, :username, :password_digest

    def initialize(playername, username, id=nil, password_digest=nil)
      @id = id
      @playername = playername
      @username = username
      @password_digest = password_digest
    end

    def update_password(password)
      @password_digest = Digest::SHA1.hexdigest password
      RPS.orm.updateplayerpswd(@password_digest, @id)
    end

    def correct_password?(password)
      checkedpword = Digest::SHA1.hexdigest password 
      checkedpword == @password_digest
    end

    def save!
      idfrom = RPS.orm.createplayer(@playername, @username, @password_digest).first["id"]
      @id = idfrom
      self #???
    end

  end
end
