module LabServer
    module Servlets
        class LoginServlet < WEBrick::HTTPServlet::AbstractServlet
            SUCCESS_PATH = '/success/'
            ADMIN_SUCCESS_PATH = '/admin/'
            ERROR_PATH = '/?status=auth_error'
            ERROR_TEMPLATE = 'auth_error.html' 

            def do_POST(request, response)
                data = {}

                if request.body 
                    request.body.split('&').each do |arg|
                        name, value = arg.split('=')
                        data[name] = value
                    end
                end

                if data.keys.include?('password') && data.keys.include?('login')
                    if LabServer::Server::USERS[data['login']] == data['password']
                        user = data['login']
                        token = LabServer::Utils::Token.generate user
                        redirect_path = SUCCESS_PATH

                        LabServer::Server.set_token user, token
                        response.cookies.push WEBrick::Cookie.new("token", token)
                        
                        redirect_path = ADMIN_SUCCESS_PATH if LabServer::Server::admin? user   
                        
                        response.set_redirect WEBrick::HTTPStatus[301], redirect_path
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
