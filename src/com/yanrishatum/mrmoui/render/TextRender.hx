package com.yanrishatum.mrmoui.render;
import flash.text.TextField;
import openfl.Assets;
import openfl.text.AntiAliasType;
import openfl.text.GridFitType;
import openfl.text.TextFieldAutoSize;
import openfl.text.TextFormat;
import openfl.text.TextFormatAlign;

/**
 * ...
 * @author Yanrishatum
 */
class TextRender extends TextField
{

  public var align(get, set):TextFormatAlign;
  private inline function get_align():TextFormatAlign
  {
    return defaultTextFormat.align;
  }
  private inline function set_align(v:TextFormatAlign):TextFormatAlign
  {
    var f:TextFormat = defaultTextFormat;
    f.align = v;
    defaultTextFormat = f;
    return v;
  }
  
  public var color(get, set):Int;
  private inline function get_color():Int
  {
    return defaultTextFormat.color;
  }
  private inline function set_color(v:Int):Int
  {
    var f:TextFormat = defaultTextFormat;
    f.color = v;
    defaultTextFormat = f;
    return v;
  }
  
  public function new(color:Int) 
  {
    super();
    autoSize = TextFieldAutoSize.LEFT;
    #if html5
    defaultTextFormat = new TextFormat("PF Ronda Seven", 8, color);
    #else
    var ronda = Assets.getFont("mrmoui/pf_ronda_seven.ttf");
    defaultTextFormat = new TextFormat(ronda.fontName, 8, color);
    embedFonts = true;
    #end
    gridFitType = GridFitType.NONE;
    //antiAliasType = AntiAliasType.ADVANCED;
    selectable = false;
    this.sharpness = 10;
  }
  
}