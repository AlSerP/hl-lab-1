module LabServer
    module Servlets
        class LoginRequiredServlet < WEBrick::HTTPServlet::AbstractServlet
            def login?(cookies)
                LabServer::Server.check_token get_value_from_cookies cookies, 'token'
            end

            def get_value_from_cookies(cookies, cookie_name)
                cookies.each do |cookie|
                    if cookie.name == cookie_name
                        return cookie.value
                    end 
                end 
            end

            def admin?(cookies)
                user = LabServer::Server.user_by_token get_value_from_cookies cookies, 'token'

                return false unless user

                LabServer::Server.admin? user
            end
        end
    end
end
