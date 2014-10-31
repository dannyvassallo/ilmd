class StatusController < ApplicationController
  def index
    render html: '<p>OK</p>'.html_safe
  end
end
