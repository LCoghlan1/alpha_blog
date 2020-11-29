# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

#removes div that errors are displayed in - this was causing bootstrap formatting to push out
ActionView::Base.field_error_proc = Proc.new do |html_tag, instance|
    html_tag.html_safe
end