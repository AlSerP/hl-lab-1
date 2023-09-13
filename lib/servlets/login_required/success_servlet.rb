module LabServer
    module Servlets
        class SuccessServlet < LoginRequiredServlet
            TEMPLATE = 'success.html'

            def do_GET(request, response)
                raise WEBrick::HTTPStatus[401] unless login? request.cookies 

                puts 'AAAAAAA'
                response.body = LabServer::HTML::Template.get_html TEMPLATE 
                raise WEBrick::HTTPStatus[200]
            end
        end
    end
end
