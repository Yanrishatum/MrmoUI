package com.yanrishatum.mrmoui.components;
import com.yanrishatum.mrmoui.utils.AutoSizer;
import lime.app.Event;
import openfl.display.Sprite;
/**
 * ...
 * @author Yanrishatum
 */
class Component
{

  public var onInvalidate = new Event<Component->Void>();
  
  public var parent:ComponentContainer;
  
  public var sizer:AutoSizer;
  
  public function new()
  {
    _x = 0;
    _y = 0;
    _w = 0;
    _h = 0;
    sizer = new AutoSizer(this);
    init();
    invalidate();
  }
  
  private function added(visual:Sprite):Void
  {
    
  }
  
  private function removed(visual:Sprite):Void
  {
    
  }
  
  private function init():Void
  {
    
  }
  
  private var _invalidating:Bool;
  public function invalidate():Void
  {
    if (_invalidating) return;
    _invalidating = true;
    onInvalidate.dispatch(this);
    _invalidating = false;
  }
  
  private var _x:Float;
  public var x(get, set):Float;
  private inline function get_x():Float { return _x; }
  private inline function set_x(v:Float):Float
  {
    _x = v;
    invalidate();
    return _x;
  }
  
  private var _y:Float;
  public var y(get, set):Float;
  private inline function get_y():Float { return _y; }
  private inline function set_y(v:Float):Float
  {
    _y = v;
    invalidate();
    return _y;
  }
  
  private var _w:Int;
  public var width(get, set):Int;
  private inline function get_width():Int { return _w; }
  private inline function set_width(v:Int):Int
  {
    _w = v;
    invalidate();
    return _w;
  }
  
  private var _h:Int;
  public var height(get, set):Int;
  private inline function get_height():Int { return _h; }
  private inline function set_height(v:Int):Int
  {
    _h = v;
    invalidate();
    return _h;
  }
  
  public var boundsWidth(get, never):Int;
  private function get_boundsWidth():Int
  {
    return _w;
  }
  
  public var boundsHeight(get, never):Int;
  private function get_boundsHeight():Int
  {
    return _h;
  }
  
  public function setPosition(x:Float, y:Float):Void
  {
    _x = x;
    _y = y;
    invalidate();
  }
  
  public function setSize(w:Int, h:Int):Void
  {
    _w = w;
    _h = h;
    invalidate();
  }
  
  public function setBounds(x:Float, y:Float, w:Int, h:Int):Void
  {
    _x = x;
    _y = y;
    _w = w;
    _h = h;
    invalidate();
  }
}