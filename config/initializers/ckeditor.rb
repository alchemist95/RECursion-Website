# Use this hook to configure ckeditor
Ckeditor.setup do |config|
  require 'ckeditor/orm/active_record'
  # Customize ckeditor assets path
  # By default: nil
  # config.asset_path = 'http://www.example.com/assets/ckeditor/'

  # To reduce the asset precompilation time, you can limit plugins and/or languages to those you need:
  # By default: nil (no limit)
  # config.assets_languages = ['en', 'uk']
  # config.assets_plugins = ['image', 'smiley']

  # CKEditor CDN
  # More info here http://cdn.ckeditor.com/
  # By default: nil (CDN disabled)
  # config.cdn_url = '//cdn.ckeditor.com/4.6.1/standard/ckeditor.js'

  # JS config url
  # Used when CKEditor CDN enabled
  # By default: "ckeditor/config.js"
  # config.js_config_url = 'ckeditor/config.js'
end
