require 'redmine'

Redmine::Plugin.register :redmine_user_story do
  name 'Redmine User Story plugin'
  author 'snukon'
  description 'This is a plugin for Redmine'
  version '0.0.1'
  url 'http://example.com/path/to/plugin'
  author_url 'http://d.hatena.ne.jp/snufkon/'

  menu :project_menu, :user_story,
  {:controller => 'user_stories', :action => 'index' },
  :caption => 'ストーリー', :last => true, :param => :project_id

  permission :user_story, {:user_stories => [:index]}, :public => true
  
end
