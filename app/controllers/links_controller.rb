class LinksController < ApplicationController
  def index
    @links = Link.includes(:tags)
  end
end
