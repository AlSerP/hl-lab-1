module LabServer
    module HTML
        class Template
            PATH = 'X:\Prog\Ruby\SimpleHTTP\lib\assets\pages\\'

            class << self
                def get_html(template)
                    return File.open(PATH + template).read
                end
            end
        end
    end
end