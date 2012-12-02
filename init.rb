require 'project_favicon'

Redmine::Plugin.register :redmine_project_favicon do
  name 'Redmine Project Favicon plugin'
  author 'OZAWA Yasuhiro'
  description 'Setting project favicon'
  version '0.0.1'
  url 'https://github.com/ameya86/redmine_project_favicon'
  author_url 'https://github.com/ameya86'

  # プラグインの設定
  settings :default => {'custom_field_id' => ''},
           :partial => 'project_favicons/settings'
end
