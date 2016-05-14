package com.yanrishatum.mrmoui.components;
import flash.display.Sprite;
import openfl.Lib;
import openfl.events.Event;

/**
 * ...
 * @author Yanrishatum
 */
class RootComponent extends ComponentContainer
{

  public var root:Sprite;
  
  public var useStageSize:Bool = false;
  
  public function new(parent:Sprite) 
  {
    this.root = parent;
    super();
  }
  
  override function init():Void 
  {
    super.init();
    childrenVisual = root;
    root.addEventListener(Event.RESIZE, onRootResize);
    Lib.current.stage.addEventListener(Event.RESIZE, onStageResize);
  }
  
  private function onStageResize(e:Event):Void 
  {
    if (useStageSize) invalidate();
  }
  
  private function onRootResize(e:Event):Void
  {
    if (!useStageSize) invalidate();
  }
  
  override public function invalidate():Void 
  {
    if (useStageSize)
    {
      _w = Std.int(Lib.current.stage.stageWidth);
      _h = Std.int(Lib.current.stage.stageHeight);
    }
    else
    {
      _w = Std.int(root.width);
      _h = Std.int(root.height);
    }
    super.invalidate();
  }
  
}