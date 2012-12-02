require_dependency 'settings_helper'

module ProjectFavicon
  module SettingsHelperPatch
    def self.included(base) # :nodoc:
      base.send(:include, InstanceMethods) # obj.method
    end

    module InstanceMethods # obj.method
      # 設定用のカスタムフィールド一覧
      def project_favicon_custom_field__options_for_select(selected = nil)
        conditions = ['field_format = ?', 'int']
        customs = ProjectCustomField.find(:all, :conditions => conditions)

        options = customs.collect do |custom|
          [custom.name, custom.id.to_s]
        end

        return raw('<option value=""></option>') + options_for_select(options, selected)
      end
    end
  end
end

SettingsHelper.send(:include, ProjectFavicon::SettingsHelperPatch)
