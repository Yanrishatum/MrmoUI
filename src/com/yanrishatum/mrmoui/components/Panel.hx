package com.yanrishatum.mrmoui.components;
import com.yanrishatum.mrmoui.render.NineSlice;
import com.yanrishatum.mrmoui.render.TextRender;
import com.yanrishatum.mrmoui.render.TriggerButton;
import lime.ui.MouseCursor;
import openfl.Lib;
import openfl.display.Sprite;
import openfl.events.MouseEvent;
import openfl.geom.Rectangle;

/**
 * ...
 * @author Yanrishatum
 */
class Panel extends ComponentContainer
{

  private var _title:TextRender;
  
  public var outer:NineSlice;
  public var inner:NineSlice;
  
  public var dragable(get, set):Bool;
  private inline function get_dragable():Bool { return drag.buttonMode; }
  private inline function set_dragable(v:Bool):Bool { return drag.buttonMode = v; }
  
  public var resizable(get, set):Bool;
  private inline function get_resizable():Bool { return left.buttonMode; }
  private inline function set_resizable(v:Bool):Bool
  {
    return left.buttonMode = 
    right.buttonMode = 
    top.buttonMode = 
    bottom.buttonMode = 
    rightBottom.buttonMode =
    rightTop.buttonMode =
    leftTop.buttonMode = 
    leftBottom.buttonMode = v;
  }
  public var closable:Bool;
  
  public var title(get, set):String;
  private inline function get_title():String { return _title.text; }
  private inline function set_title(v:String):String { return _title.text = v; }
  
  private var dragX:Float;
  private var dragY:Float;
  private var drag:TriggerButton;
  
  private var leftTop:TriggerButton;
  private var rightTop:TriggerButton;
  private var leftBottom:TriggerButton;
  private var rightBottom:TriggerButton;
  private var left:TriggerButton;
  private var right:TriggerButton;
  private var top:TriggerButton;
  private var bottom:TriggerButton;
  
  public var minWidth:Int = 40;
  public var minHeight:Int = 40;
  
  public var outlined(get, set):Bool;
  private inline function get_outlined():Bool { return outer.outlineType == ONormal; }
  private inline function set_outlined(v:Bool):Bool
  {
    outer.outlineType = v ? ONormal : ONone;
    outer.redraw();
    return v;
  }
  
  public function new() 
  {
    super();
  }
  
  override function init():Void 
  {
    super.init();
    
    outer = new NineSlice();
    outer.outlineType = ONormal;
    outer.color = 0x3c8ee7;
    inner = new NineSlice();
    inner.x = 2;
    inner.y = 22;
    outer.addChild(inner);
    childrenVisual = inner;
    
    _title = new TextRender(0);// 0xffffff);
    _title.x = 8;
    _title.y = 2;
    outer.addChild(_title);
    
    drag = new TriggerButton(this, outer);
    outer.addChild(drag);
    drag.addEventListener(MouseEvent.MOUSE_DOWN, startDrag);
    drag.cursor = MouseCursor.MOVE;
    
    //{ Resize
    
    left = new TriggerButton(this, outer);
    right = new TriggerButton(this, outer);
    top = new TriggerButton(this, outer);
    bottom = new TriggerButton(this, outer);
    leftTop = new TriggerButton(this, outer);
    leftBottom = new TriggerButton(this, outer);
    rightTop = new TriggerButton(this, outer);
    rightBottom = new TriggerButton(this, outer);
    
    outer.addChild(left);
    outer.addChild(right);
    outer.addChild(top);
    outer.addChild(bottom);
    outer.addChild(leftTop);
    outer.addChild(leftBottom);
    outer.addChild(rightTop);
    outer.addChild(rightBottom);
    
    left.cursor = MouseCursor.RESIZE_WE;
    right.cursor = MouseCursor.RESIZE_WE;
    top.cursor = MouseCursor.RESIZE_NS;
    bottom.cursor = MouseCursor.RESIZE_NS;
    leftTop.cursor = MouseCursor.RESIZE_NWSE;
    rightBottom.cursor = MouseCursor.RESIZE_NWSE;
    leftBottom.cursor = MouseCursor.RESIZE_NESW;
    rightTop.cursor = MouseCursor.RESIZE_NESW;
    
    leftTop.setSize(5, 5);
    leftBottom.setSize(5, 5);
    rightTop.setSize(5, 5);
    rightBottom.setSize(5, 5);
    
    left.addEventListener(MouseEvent.MOUSE_DOWN, startResize);
    right.addEventListener(MouseEvent.MOUSE_DOWN, startResize);
    top.addEventListener(MouseEvent.MOUSE_DOWN, startResize);
    bottom.addEventListener(MouseEvent.MOUSE_DOWN, startResize);
    leftTop.addEventListener(MouseEvent.MOUSE_DOWN, startResize);
    leftBottom.addEventListener(MouseEvent.MOUSE_DOWN, startResize);
    rightTop.addEventListener(MouseEvent.MOUSE_DOWN, startResize);
    rightBottom.addEventListener(MouseEvent.MOUSE_DOWN, startResize);
    
    //}
    
    dragable = false;
    resizable = false;
  }
  
  //{ Resize
  
  private var resizeX:Int;
  private var resizeY:Int;
  private var initialX:Float;
  private var initialY:Float;
  private var initialW:Int;
  private var initialH:Int;
  
  public function setMinSize(w:Int, h:Int):Void
  {
    minWidth = w;
    minHeight = h;
  }
  
  private function startResize(e:MouseEvent):Void
  {
    if (resizable)
    {
      Lib.current.stage.addEventListener(MouseEvent.MOUSE_UP, stopResize);
      Lib.current.stage.addEventListener(MouseEvent.MOUSE_MOVE, applyResize);
      resizeX = e.currentTarget == left || e.currentTarget == leftTop || e.currentTarget == leftBottom ? -1 :
        (e.currentTarget == right || e.currentTarget == rightTop || e.currentTarget == rightBottom ? 1 : 0); 
      resizeY = e.currentTarget == top || e.currentTarget == leftTop || e.currentTarget == rightTop ? -1 :
        (e.currentTarget == bottom || e.currentTarget == leftBottom || e.currentTarget == rightBottom ? 1 : 0);
      dragX = e.stageX;
      dragY = e.stageY;
      initialX = _x;
      initialY = _y;
      initialW = _w;
      initialH = _h;
      applyResize(e);
    }
  }
  
  private function applyResize(e:MouseEvent):Void
  {
    var diff:Float = e.stageX - dragX;
    
    var nx:Float = initialX;
    var ny:Float = initialY;
    var nw:Int = initialW;
    var nh:Int = initialH;
    
    if (resizeX == -1)
    {
      if (nw - diff < minWidth) diff = nw - minWidth;
      nx += diff;
      nw -= Std.int(diff);
    }
    else if (resizeX == 1)
    {
      nw += Std.int(diff);
    }
    
    diff = e.stageY - dragY;
    
    if (resizeY == -1)
    {
      if (nh - diff < minHeight) diff = nh - minHeight;
      ny += diff;
      nh -= Std.int(diff);
    }
    else if (resizeY == 1)
    {
      nh += Std.int(diff);
    }
    
    if (nw < minWidth) nw = minWidth;
    if (nh < minHeight) nh = minHeight;
    
    if (nx != _x || ny != _y || nw != _w || nh != _h) setBounds(nx, ny, nw, nh);
  }
  
  private function stopResize(e:MouseEvent):Void
  {
    Lib.current.stage.removeEventListener(MouseEvent.MOUSE_UP, stopResize);
    Lib.current.stage.removeEventListener(MouseEvent.MOUSE_MOVE, applyResize);
    applyResize(e);
  }
  
  //}
  
  //{ Drag
  
  private function startDrag(e:MouseEvent):Void
  {
    if (dragable)
    {
      Lib.current.stage.addEventListener(MouseEvent.MOUSE_UP, stopDrag);
      Lib.current.stage.addEventListener(MouseEvent.MOUSE_MOVE, applyDrag);
      dragX = e.localX;
      dragY = e.localY;
    }
  }
  
  private function applyDrag(e:MouseEvent):Void
  {
    this.setPosition(e.stageX - dragX, e.stageY - dragY);
  }
  
  private function stopDrag(e:MouseEvent):Void
  {
    Lib.current.stage.removeEventListener(MouseEvent.MOUSE_UP, stopDrag);
    Lib.current.stage.removeEventListener(MouseEvent.MOUSE_MOVE, applyDrag);
    applyDrag(e);
  }
  
  //}
  
  override function added(visual:Sprite):Void 
  {
    super.added(visual);
    visual.addChild(outer);
  }
  
  override function removed(visual:Sprite):Void 
  {
    super.removed(visual);
    visual.removeChild(outer);
  }
  
  public function setInnerSize(w:Int, h:Int):Void
  {
    setSize(w + 4, h + 24);
  }
  
  override public function invalidate():Void 
  {
    super.invalidate();
    outer.x = Math.fround(_x);
    outer.y = Math.fround(_y);
    right.x = _w - 4;
    bottom.y = _h - 4;
    rightTop.x = _w - 5;
    rightBottom.x = _w - 5;
    rightBottom.y = _h - 5;
    leftBottom.y = _h - 5;
    if (_w != outer.w || _h != outer.h)
    {
      outer.setSize(_w, _h);
      inner.setSize(_w - 4, _h - 24);
      
      drag.setSize(_w, 22);
      left.setSize(4, _h);
      right.setSize(4, _h);
      top.setSize(_w, 4);
      bottom.setSize(_w, 4);
    }
  }
  
}