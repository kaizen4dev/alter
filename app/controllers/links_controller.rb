class LinksController < ApplicationController
  def index
    @links = current_user.links.includes(:tags)

    unless params[:tags].nil?
      requiredTags = params[:tags].split

      @links = @links.select do |link|
        presentTags = link.tags.pluck(:name)
        requiredTags.all? { |t| presentTags.include?(t) }
      end
    end
  end

  def new
    @link = current_user.links.new
  end

  def create
    @link = current_user.links.new url: (link_params[:url])
    @tags = current_user.tags

    link_params[:tags].split.each do |name|
      tag = @tags.find_by name: name
      tag ||= @tags.create name: name
      @link.tags.append tag
    end

    if @link.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_content
    end
  end

  private

  def link_params
    p = params.expect link: [ :url, :tags ]
    p[:url] = "https://" + p[:url] unless p[:url].start_with?("https://", "http://")
    p
  end
end
