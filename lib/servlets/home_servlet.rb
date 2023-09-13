module LabServer
    module Servlets
        class HomeServlet < WEBrick::HTTPServlet::AbstractServlet
            HOME_TEMPLATE = 'home.html'
            LOGIN_TEMPLATE = 'login.html'
            ERROR_TEMPLATE = 'auth_error.html'

            def do_GET(request, response)
                puts 'QUERY', request.query
                template = LOGIN_TEMPLATE
                template = ERROR_TEMPLATE if request.query['status'] and request.query['status'] == 'auth_error' 
                response.body = LabServer::HTML::Template.get_html template
                raise WEBrick::HTTPStatus::OK
            end
        end
    end
end
