module LabServer
    module Servlets
        class AdminServlet < LoginRequiredServlet
            TEMPLATE = 'admin.html'

            def do_GET(request, response)
                raise WEBrick::HTTPStatus[401] unless login? request.cookies  
                raise WEBrick::HTTPStatus[403] unless admin? request.cookies  

                response.body = LabServer::HTML::Template.get_html TEMPLATE 
                raise WEBrick::HTTPStatus[200]
            end
        end
    end
end
