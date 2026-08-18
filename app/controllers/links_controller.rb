class LinksController < ApplicationController
  def index
    @links = current_user.links.includes(:tags)

    unless params[:tags].nil?
      param_tags = params[:tags].split.map(&:downcase)

      # split tags into excluded and required based on "!" and then remove it from excluded tags
      excluded_tags, required_tags = param_tags.partition { |t| t.include?("!") }.tap { |a| a[0].map! { |t| t[1..] } }

      @links = @links.select do |link|
        present_tags = link.tags.pluck(:name).map(&:downcase)
        required_tags.all? { |t| present_tags.include?(t) } && !excluded_tags.any? { |t| present_tags.include?(t) }
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
    @link = current_user.links.find params[:id]
  end

  def update
    @link = current_user.links.find params[:id]
    @link.tags = append_tags!(link_params[:tags])

    if @link.update url: link_params[:url]
      redirect_to links_path
    else
      render :edit, status: :unprocessable_content
    end
  end

  def destroy
    current_user.links.find(params[:id]).destroy
    redirect_to links_path
  end

  private

  def link_params
    p = params.expect link: [ :url, :tags ]
    p[:url] = "https://" + p[:url] unless p[:url].start_with?("https://", "http://") || p[:url].blank?
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
