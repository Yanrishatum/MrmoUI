package com.yanrishatum.mrmoui.components;
import com.yanrishatum.mrmoui.render.TextRender;
import openfl.text.TextFieldAutoSize;
import openfl.text.TextFieldType;

/**
 * ...
 * @author Yanrishatum
 */
class TextInput extends TextArea
{
  public function new() 
  {
    super();
  }
  
  override function init():Void 
  {
    super.init();
    _h = 15;
    //_w = 200;
    label.multiline = false;
    placeholderLabel.multiline = false;
  }
  
}