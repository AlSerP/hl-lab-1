module LabServer
    class Server
        # User constants 
        USERS = {
            'test_user' => 'qwerty',
            'super_user' => '123456'
        }.freeze
        
        SUPERUSERS = [
            'super_user'
        ].freeze

        RPOJECT_DIR = File.expand_path(".")

        @tokens = {}

        class << self
            def run(port=8080)
                start_webrick(port) do | server |
                    routes server
                end 
            end

            def set_token(user, token)
                @tokens[token] = user
            end
            
            def user_by_token(token)
                @tokens[token]
            end

            def check_token(token)
                puts "KEYS = #{@tokens.keys}" 
                @tokens.keys.include? token
            end

            def admin?(user)
                SUPERUSERS.include? user
            end

            private

            def routes(server)
                server.mount('/login', Servlets::LoginServlet)
                server.mount('/success', Servlets::SuccessServlet)
                server.mount('/admin', Servlets::AdminServlet)
                server.mount('/', Servlets::HomeServlet)
            end

            def start_webrick(port, config = {})
                config.update(:Port => port)     
                server = WEBrick::HTTPServer.new(config)
                yield server if block_given?
                ['INT', 'TERM'].each {|signal| 
                    trap(signal) {server.shutdown}
                }
                server.start
            end
        end
    end
end
