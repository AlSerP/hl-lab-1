module LabServer
    module HTML
        class Template
            TEMPLATE_PATH = '/lib/assets/pages/'
            class << self
                def get_html(template)
                    return File.open(LabServer::Server::ROOT_DIR + TEMPLATE_PATH + template).read
                end
            end
        end
    end
end