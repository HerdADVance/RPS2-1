module RPS
  class SignIn

    def self.run(params)

      userhash = RPS.orm.getplayerbyusername(params[:username])
      username = userhash.first["username"]
      password = userhash.first["password"]
      if params[:username] == username && params[:password] == password 
        #???????????
        session = RPS.orm.createsesh(userid: user.id)
        return {:success? => true,
                :session_id => session}
      else
        return {:success? => false, 
                :error => :invalid_password}
      end
     

    end

  end
end
