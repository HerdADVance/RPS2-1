require 'pry-byebug'

module RPS
  class SignIn

    def self.run(params)
      userhash = RPS.orm.getplayerbyusername(params[:username])
      # binding.pry
      username = userhash.first["username"]
      userid = userhash.first["id"]
      password = userhash.first["password"]
      parampassword = Digest::SHA1.hexdigest params[:password]
      if params[:username] == username && parampassword == password 
        sessionid = RPS.orm.createsesh(userid)
        return {:success? => true,
                :session_id => sessionid}

      else
        return {:success? => false, 
                :error => :invalid_password}
      end
     

    end

    def self.signinrun(params)
      userhash = RPS.orm.getplayerbyusername(params[:siusername])
      username = userhash.first["username"]
      userid = userhash.first["id"]
      password = userhash.first["password"]
      parampassword = Digest::SHA1.hexdigest params[:sipassword]
      if params[:siusername] == username && parampassword == password 
        sessionid = RPS.orm.createsesh(userid)
        return {:success? => true,
                :session_id => sessionid}

      else
        return {:success? => false, 
                :error => :invalid_password}
      end
     

    end

  end

end
