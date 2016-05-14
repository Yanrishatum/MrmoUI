package com.yanrishatum.mrmoui.components;
import com.yanrishatum.mrmoui.render.NineSlice;
import com.yanrishatum.mrmoui.render.TextRender;
import flash.display.Sprite;
import lime.app.Event;
import openfl.display.DisplayObject;
import openfl.events.MouseEvent;
import openfl.text.TextFieldAutoSize;
import openfl.text.TextFormatAlign;

/**
 * ...
 * @author Yanrishatum
 */
class Button extends Component
{
  private var rect:NineSlice;
  private var label:TextRender;
  
  public var onClick = new Event<Void->Void>();

  public function new(text:String, textColor:Int, bg:Int, width:Int, ?icon:DisplayObject) 
  {
    label = new TextRender(textColor);
    label.text = text;
    label.autoSize = TextFieldAutoSize.NONE;
    label.align = TextFormatAlign.CENTER;
    label.y -= 1;
    
    rect = new NineSlice();
    rect.color = bg;
    rect.addChild(label);
    rect.buttonMode = true;
    rect.addEventListener(MouseEvent.CLICK, _onClick);
    super();
    
    var h:Int = 15;
    if (icon != null)
    {
      rect.addChild(icon);
      if (text != "")
      {
        icon.x = 1;
        icon.y = 1;
        h += 2;
        label.x = icon.width + 2;
      }
      else
      {
        width = Std.int(icon.width);
        h = Std.int(icon.height);
      }
    }
    setSize(width, h);
  }
  
  private function _onClick(e:MouseEvent):Void 
  {
    onClick.dispatch();
  }
  
  override public function invalidate():Void 
  {
    super.invalidate();
    label.width = _w - label.x;
    label.height = _h;
    rect.setSize(_w, _h);
    rect.x = Math.fround(_x);
    rect.y = Math.fround(_y);
  }
  
  override function added(visual:Sprite):Void 
  {
    super.added(visual);
    visual.addChild(rect);
  }
  
  override function removed(visual:Sprite):Void 
  {
    super.removed(visual);
    visual.removeChild(rect);
  }
  
}