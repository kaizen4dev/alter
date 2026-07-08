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
    append_tags!(link_params[:tags], @link)

    if @link.save
      redirect_to links_path
    else
      render :new, status: :unprocessable_content
    end
  end

  def edit
    @link = Link.find params[:id]
  end

  def update
    @link = Link.find params[:id]
    @link.url = link_params[:url]
    @link.tags = append_tags!(link_params[:tags])

    redirect_to links_path
  end

  def destroy
    Link.find(params[:id]).destroy
    redirect_to links_path
  end

  private

  def link_params
    p = params.expect link: [ :url, :tags ]
    p[:url] = "https://" + p[:url] unless p[:url].start_with?("https://", "http://")
    p[:tags] = p[:tags].split
    p
  end

  def append_tags!(names = Array.new, link = Link.new)
    tags = current_user.tags

    names.each do |name|
      tag = tags.find_by name: name
      tag ||= tags.create name: name
      link.tags.append tag
    end

    link.tags
  end
end
