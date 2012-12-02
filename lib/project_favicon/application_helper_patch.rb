require_dependency 'application_helper'

module ProjectFavicon
  module ApplicationHelperPatch
    def self.included(base) # :nodoc:
      base.send(:include, InstanceMethods) # obj.method

      base.class_eval do
        alias_method_chain :favicon, :project_favicon
      end
    end

    module InstanceMethods # obj.method
      # プロジェクトごとのFaviconに差し替える
      def favicon_with_project_favicon
        return favicon_without_project_favicon if !@project || !@project.project_favicon

        return "<link rel='shortcut icon' href='#{image_path(project_favicon_path(@project))}' />".html_safe
      end

      def project_favicon_path(project = @project)
        return nil unless project.project_favicon

        return url_for(:controller => 'attachments', :action => 'download', :id => project.project_favicon.id)
      end
    end
  end
end

ApplicationHelper.send(:include, ProjectFavicon::ApplicationHelperPatch)
