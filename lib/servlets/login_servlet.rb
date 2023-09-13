module LabServer
    module Servlets
        class LoginServlet < WEBrick::HTTPServlet::AbstractServlet
            SUCCESS_PATH = '/success'
            ERROR_PATH = '/?status=auth_error'
            ERROR_TEMPLATE = 'auth_error.html' 

            def do_POST(request, response)
                puts 'GOT POST METHOD'
                data = {}
                request.body.split('&').each do |arg|
                    name, value = arg.split('=')
                    data[name] = value
                end
                puts data['login']
                puts data
                if data.keys.include?('password') && data.keys.include?('login')
                    if LabServer::Server::USERS[data['login']] == data['password']
                        user = data['login']
                        token = LabServer::Utils::Token.generate user
                        
                        LabServer::Server::set_token user, token

                        response.cookies.push WEBrick::Cookie.new("token", token)
                        response.set_redirect WEBrick::HTTPStatus[301], SUCCESS_PATH
                    else
                        response.set_redirect WEBrick::HTTPStatus[301], ERROR_PATH
                        # response.body = LabServer::HTML::Template.get_html ERROR_TEMPLATE
                        # raise WEBrick::HTTPStatus[401]
                    end
                else
                    raise WEBrick::HTTPStatus[401]
                end
            end

            def do_GET(request, response)
                raise WEBrick::HTTPStatus[405]
            end
        end
    end
end
