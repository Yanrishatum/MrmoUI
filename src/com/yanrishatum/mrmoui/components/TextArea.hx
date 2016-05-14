package com.yanrishatum.mrmoui.components;
import com.yanrishatum.mrmoui.render.NineSlice;
import com.yanrishatum.mrmoui.render.TextRender;
import openfl.display.Sprite;
import openfl.events.Event;
import openfl.text.TextFieldAutoSize;
import openfl.text.TextFieldType;

/**
 * ...
 * @author Yanrishatum
 */
class TextArea extends Component
{

  private var bg:NineSlice;
  private var label:TextRender;
  private var placeholderLabel:TextRender;
  private var customPlaceholderColor:Bool;
  
  public var text(get, set):String;
  private inline function get_text():String { return label.text; }
  private inline function set_text(v:String):String
  {
    placeholderLabel.visible = (v == "");
    return label.text = v;
  }
  
  public var color(get, set):Int;
  private inline function get_color():Int { return label.color; }
  private inline function set_color(v:Int):Int
  {
    if (!customPlaceholderColor) placeholderLabel.color = v;
    return label.color = v;
  }
  
  public var placeholderColor(get, set):Int;
  private inline function get_placeholderColor():Int { return placeholderLabel.color; }
  private inline function set_placeholderColor(v:Int):Int
  {
    customPlaceholderColor = v != label.color;
    return placeholderLabel.color = v;
  }
  
  public var placeholder(get, set):String;
  private inline function get_placeholder():String { return placeholderLabel.text; }
  private inline function set_placeholder(v:String):String
  {
    return placeholderLabel.text = v;
  }
  
  public var background(get, set):Bool;
  private inline function get_background():Bool { return bg.backgroundType == BSquare; }
  private inline function set_background(v:Bool):Bool
  {
    bg.backgroundType = v ? BSquare : BSquareNone;
    bg.redraw();
    return v;
  }
  
  public var outline(get, set):Bool;
  private inline function get_outline():Bool { return bg.outlineType == ONormal; }
  private inline function set_outline(v:Bool):Bool
  {
    bg.outlineType = v ? ONormal : ONone;
    bg.redraw();
    return v;
  }
  
  public var backgroundColor(get, set):Int;
  private inline function get_backgroundColor():Int { return bg.color; }
  private inline function set_backgroundColor(v:Int):Int
  {
    bg.setColor(v);
    return v;
  }
  
  public var outlineColor(get, set):Int;
  private inline function get_outlineColor():Int { return bg.outlineColor; }
  private inline function set_outlineColor(v:Int):Int
  {
    bg.outlineColor = v;
    bg.redraw();
    return v;
  }
  
  public function new() 
  {
    super();
  }
  
  override function init():Void 
  {
    super.init();
    bg = new NineSlice();
    bg.color = 0xffffff;
    bg.outlineColor = 0;
    bg.backgroundType = BSquare;
    bg.outlineType = ONormal;
    
    label = new TextRender(0);
    label.selectable = true;
    label.autoSize = TextFieldAutoSize.NONE;
    label.type = TextFieldType.INPUT;
    label.addEventListener(Event.CHANGE, onChangeEvent);
    
    placeholderLabel = new TextRender(0);
    placeholderLabel.mouseEnabled = false;
    placeholderLabel.selectable = true;
    placeholderLabel.autoSize = TextFieldAutoSize.NONE;
    placeholderLabel.type = TextFieldType.INPUT;
    
    _w = 200;
    _h = 200;
  }
  
  override public function invalidate():Void 
  {
    super.invalidate();
    label.x = _x;
    label.y = _y - 2;
    placeholderLabel.x = _x;
    placeholderLabel.y = _y - 2;
    bg.x = _x;
    bg.y = _y;
    if (_w != bg.w || _h != bg.h)
    {
      label.width = _w;
      label.height = _h;
      placeholderLabel.width = _w;
      placeholderLabel.height = _h;
      bg.setSize(_w, _h);
    }
  }
  
  override function added(visual:Sprite):Void 
  {
    super.added(visual);
    visual.addChild(bg);
    visual.addChild(placeholderLabel);
    visual.addChild(label);
  }
  
  override function removed(visual:Sprite):Void 
  {
    super.removed(visual);
    visual.removeChild(bg);
    visual.removeChild(placeholderLabel);
    visual.removeChild(label);
  }
  
  private function onChangeEvent(e:Event):Void
  {
    placeholderLabel.visible = (text == "");
  }
  
}