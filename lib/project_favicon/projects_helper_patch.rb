require_dependency 'projects_helper'

module ProjectFavicon
  module ProjectsHelperPatch
    def self.included(base) # :nodoc:
      base.send(:include, InstanceMethods) # obj.method
    end

    module InstanceMethods # obj.method
      # プロジェクトの添付ファイルの内、画像ファイルを取得
      def project_image_attachments
        return [] unless @project

        # 画像ファイルのみを対称にする
        images = @project.attachments.select do |attach|
          Redmine::MimeType.is_type?('image', attach.filename) || attach.filename =~ /\.ico$/
        end

        return images
      end

      # Favicon候補のリスト
      def project_favicon_options_for_select(selected = nil)
        options = project_image_attachments.collect do |image|
          title = (image.description.blank?)? image.filename : "#{image.filename} - #{image.description}"
          [title, image.id.to_s]
        end

        return raw('<option value=""></option>') + options_for_select(options, selected)
      end
    end
  end
end

ProjectsHelper.send(:include, ProjectFavicon::ProjectsHelperPatch)
