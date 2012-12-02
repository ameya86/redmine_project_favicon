module ProjectFavicon
  class Hook < Redmine::Hook::ViewListener
    render_on :view_projects_form, :partial => 'project_favicons/projects_form'
  end
end
