CKEDITOR.editorConfig = function(config) {
  config.language = 'en';
  config.height = '300'; 
  config.filebrowserBrowseUrl = "/ckeditor/attachment_files";
  config.filebrowserImageBrowseLinkUrl = "/ckeditor/pictures";
  config.filebrowserImageBrowseUrl = "/ckeditor/pictures";
  config.filebrowserImageUploadUrl = "/ckeditor/pictures";
  config.filebrowserUploadUrl = "/ckeditor/attachment_files";
  config.uiColor = '#E7EEF8';

  config.extraPlugins = 'widget,dialog,dialogui,lineutils,codesnippet,button,notification,clipboard,toolbar,widgetselection';

  config.toolbar_mini = [
    ["Bold",  "Italic", "Strike",  "Underline", "-",  "NumberedList",  "BulletedList", "Link", "Unlink", "CodeSnippet", "RemoveFormat"],
  ];
  
  config.removeButtons = 'CopyFormatting,RemoveFormat,Strike,Form,Scayt,SelectAll,Find,Replace,Redo,Undo,Cut,Templates,Copy,Paste,PasteText,PasteFromWord,Button,Select,Textarea,TextField,Radio,Checkbox,HiddenField,ImageButton,BidiLtr,BidiRtl,Language,Anchor,Flash,PageBreak,About,Source,Save,NewPage,Preview,Print';

  config.toolbar = 'mini';
  return true;
};
