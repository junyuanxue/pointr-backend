class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
#   before_filter :cors_preflight_check
#   after_filter :cors_set_access_control_headers
#
# # For all responses in this controller, return the CORS access control headers.
#
#   def cors_set_access_control_headers
#     headers['Access-Control-Allow-Origin'] = '*'
#     headers['Access-Control-Allow-Methods'] = 'POST, PUT, PATCH, DELETE, GET, OPTIONS'
#     headers['Access-Control-Request-Method'] = '*'
#     headers['Access-Control-Allow-Headers'] = 'Origin, X-Requested-With, Content-Type, Accept, Authorization'
#   end
#
#   # If this is a preflight OPTIONS request, then short-circuit the
#   # request, return only the necessary headers and return an empty
#   # text/plain.
#
#   def cors_preflight_check
#     if request.method == :options
#       headers['Access-Control-Allow-Origin'] = '*'
#       headers['Access-Control-Allow-Methods'] = 'POST, GET, PATCH, DELETE, OPTIONS'
#       headers['Access-Control-Allow-Headers'] = '*'
#     end
#   end
end
