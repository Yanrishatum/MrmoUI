package com.yanrishatum.mrmoui.render;
import com.yanrishatum.mrmoui.components.Component;
import lime.ui.Mouse;
import lime.ui.MouseCursor;
import openfl.display.Sprite;
import openfl.events.MouseEvent;

/**
 * ...
 * @author Yanrishatum
 */
class TriggerButton extends Sprite
{

  public var cursor:MouseCursor;
  
  public function new(comp:Component, parent:Sprite) 
  {
    super();
    parent.addChild(this);
    cursor = MouseCursor.POINTER;
  }
  
  override function __getCursor():MouseCursor 
  {
    return buttonMode ? cursor : null;
  }
  
  public function setSize(w:Int, h:Int):Void
  {
    graphics.clear();
    graphics.beginFill(0, 0);
    graphics.drawRect(0, 0, w, h);
    graphics.endFill();
  }
  
}