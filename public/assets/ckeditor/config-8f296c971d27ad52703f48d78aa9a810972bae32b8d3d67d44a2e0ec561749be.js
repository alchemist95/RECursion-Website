CKEDITOR.editorConfig = function(config) {
  config.language = 'en';
  config.height = '300';
  config.filebrowserBrowseUrl = "/ckeditor/attachment_files";
  config.filebrowserImageBrowseLinkUrl = "/ckeditor/pictures";
  config.filebrowserImageBrowseUrl = "/ckeditor/pictures";
  config.filebrowserImageUploadUrl = "/ckeditor/pictures";
  config.filebrowserUploadUrl = "/ckeditor/attachment_files";
  config.uiColor = '#E7EEF8';
  config.tabSpaces = 4;

  config.codeSnippet_tabSpaces = 4;

  config.extraPlugins = 'widget,dialog,dialogui,lineutils,codesnippet,button,notification,clipboard,toolbar,widgetselection';

  config.toolbar_mini = [
    ["Bold",  "Italic", "Strike",  "Underline", "-",  "NumberedList",  "BulletedList", "Link", "Unlink", "CodeSnippet", "RemoveFormat"],
  ];
  config.toolbar = 'mini';
  return true;
};
