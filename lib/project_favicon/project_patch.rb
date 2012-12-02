require_dependency 'project'

module ProjectFavicon
  module ProjectPatch
    def self.included(base) # :nodoc:
      base.send(:include, InstanceMethods) # obj.method
    end

    module InstanceMethods # obj.method
      # プロジェクトのFaviconを設定しているカスタムフィールドのID
      def project_favicon_custom_field_id
        return @project_favicon_custom_field_id if @project_favicon_custom_field_id
        @project_favicon_custom_field_id = Setting.plugin_redmine_project_favicon['custom_field_id'].to_i
        @project_favicon_custom_field_id = nil if 0 == @project_favicon_custom_field_id

        return @project_favicon_custom_field_id
      end

      # プロジェクトのFaviconを取得
      def project_favicon
        return @project_favicon if @project_favicon
        return nil unless project_favicon_custom_field_id

        # カスタムフィールドの設定値を取得
        conditions = ['customized_type = ? and customized_id = ? and custom_field_id = ?', 'Project', id, project_favicon_custom_field_id]
        custom_value = CustomValue.find(:first, :conditions => conditions)
        return nil unless custom_value

        # 設定値からFaviconを取得
        @project_favicon = self.attachments.find_by_id(custom_value.value)
        return  @project_favicon
      end
    end
  end
end

Project.send(:include, ProjectFavicon::ProjectPatch)
