module PagesHelper
  def active_for_path(path)
    "active" if params[:action] == path
  end
end
