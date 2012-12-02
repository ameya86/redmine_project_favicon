# Favicon設定用のプロジェクトカスタムフィールドを作成

class CreateProjectFaviconCustomField < ActiveRecord::Migration
  include Redmine::I18n

  def change
    settings = Setting.plugin_redmine_project_favicon || {}

    condisions = ['name = ?', l(:name_project_favicon_custom_field)]
    custom_field = ProjectCustomField.find(:first, :conditions => condisions)
    unless custom_field
      # 無い場合は作る
      custom_field = ProjectCustomField.new
      custom_field.name =  l(:name_project_favicon_custom_field)
      custom_field.field_format = 'int'
      custom_field.visible = false
      custom_field.save
    end

    # 割り当て
    settings['custom_field_id'] = custom_field.id.to_s

    Setting.plugin_redmine_project_favicon = settings
  end
end
