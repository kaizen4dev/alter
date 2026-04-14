class LinksController < ApplicationController
  def index
    @links = current_user.links.includes(:tags)

    unless params[:tags].nil?
      requiredTags = params[:tags].split

      @links = @links.select do |link|
        presentTags = link.tags.pluck(:name)
        requiredTags.all? {|t| presentTags.include?(t)}
      end
    end
  end
end
