class Api::V1::LinksController < Api::V1::BaseController
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def index
    @links = current_user.links.includes(:tags)
    render json: @links.map { |link| convert(link) }
  end

  def show
    @link = current_user.links.find params[:id]
    render json: convert(@link)
  end

  def create
    @link = current_user.links.new url: (link_params[:url])
    append_tags!(link_params[:tags], @link)

    if @link.save
      render json: convert(@link), status: :created, location: @link
    else
      render json: @link.errors, status: :unprocessable_entity
    end
  end

  def update
    @link = current_user.links.find params[:id]
    @link.url = link_params[:url] unless params[:url].blank?

    if @link.update tags: append_tags!(link_params[:tags])
      render json: convert(@link)
    else
      render json: @link.errors, status: :unprocessable_entity
    end
  end

  def destroy
    current_user.links.find(params[:id]).destroy
    head :no_content
  end

  private

  def link_params
    p = params.permit :url, :tags
    p[:url] = "https://" + p[:url] unless p[:url].blank? || p[:url].start_with?("https://", "http://")
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

  def convert(link)
    { id: link.id, url: link.url, tags: link.tags.map(&:name) }
  end
end
