require 'webrick'

require_relative 'lib/utils/token'

require_relative 'lib/html/template'

require_relative 'lib/servlets/home_servlet'
require_relative 'lib/servlets/login_servlet'
require_relative 'lib/servlets/login_required_servlet'

require_relative 'lib/servlets/login_required/success_servlet'
require_relative 'lib/servlets/login_required/admin_servlet'

require_relative 'lib/server'


LabServer::Server.run
