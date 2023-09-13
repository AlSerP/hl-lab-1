module LabServer
    module Utils
        require 'digest'

        class Token
            SALT = 'hello_world'
            class << self
                def generate(user)
                    time = Time.now.strftime("%d/%m/%Y %H:%M")
                    return Digest::SHA2.new(256).hexdigest "#{user}#{time}#{SALT}"
                end 
            end
        end
    end
end
