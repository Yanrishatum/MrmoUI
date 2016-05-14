package com.yanrishatum.mrmoui.components;
import com.yanrishatum.mrmoui.render.TextRender;
import flash.text.TextFormat;
import flash.text.TextFormatAlign;
import openfl.display.Sprite;
import openfl.text.TextFieldAutoSize;

/**
 * ...
 * @author Yanrishatum
 */
class Label extends Component
{
  
  public var txt:TextRender;
  
  public var text(get, set):String;
  private inline function get_text():String
  {
    return txt.text;
  }
  private inline function set_text(v:String):String
  {
    txt.text = v;
    return v;
  }
  
  public var align(get, set):TextFormatAlign;
  private inline function get_align():TextFormatAlign
  {
    return txt.align;
  }
  private inline function set_align(v:TextFormatAlign):TextFormatAlign
  {
    return txt.align = v;
  }
  
  public var color(get, set):Int;
  private inline function get_color():Int
  {
    return txt.color;
  }
  private inline function set_color(v:Int):Int
  {
    return txt.color = v;
  }
  
  
  public function new() 
  {
    super();
  }
  
  override function init():Void 
  {
    super.init();
    txt = new TextRender(0);
    txt.multiline = true;
    txt.wordWrap = true;
    txt.autoSize = TextFieldAutoSize.NONE;
  }
  
  override function added(visual:Sprite):Void 
  {
    super.added(visual);
    visual.addChild(txt);
  }
  
  override function removed(visual:Sprite):Void 
  {
    super.removed(visual);
    visual.removeChild(txt);
  }
  
  override public function invalidate():Void 
  {
    super.invalidate();
    txt.x = _x;
    txt.y = _y;
    txt.width = _w;
    txt.height = _h;
  }
  
}