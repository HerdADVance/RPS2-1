require 'digest/sha1'


module RPS
  class User

    attr_reader :id, :username, :password_digest

    def initialize(id, playername, username, password_digest=nil)
      @id = id
      @playername = playername
      @username = username
      @password_digest = password_digest
    end

    def update_password(password)
      # TODO: Hash incoming password and save as password digest
      @password_digest = Digest::SHA1.hexdigest password
    end

    def correct_password?(password)
      # TODO: Hash incoming password and compare against own password_digest
      checkedpword = Digest::SHA1.hexdigest password 
      checkedpword == @password_digest
    end
  end
end
