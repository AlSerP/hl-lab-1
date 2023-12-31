module LabServer
    module Servlets
        class SuccessServlet < LoginRequiredServlet
            TEMPLATE = 'success.html'

            def do_GET(request, response)
                puts "COOKIE #{request.cookies}"
                raise WEBrick::HTTPStatus[401] unless login? request.cookies 

                response.body = LabServer::HTML::Template.get_html TEMPLATE 
                raise WEBrick::HTTPStatus[200]
            end
        end
    end
end
