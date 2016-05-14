package com.yanrishatum.mrmoui.utils;
import com.yanrishatum.mrmoui.components.Component;

/**
 * ...
 * @author Yanrishatum
 */
class AutoSizer
{
  
  private var comp:Component;
  
  public var left:AutoSizeParameter;
  public var right:AutoSizeParameter;
  public var top:AutoSizeParameter;
  public var bottom:AutoSizeParameter;
  
  public var width:AutoSizeParameter;
  public var height:AutoSizeParameter;
  
  public function new(parent:Component) 
  {
    comp = parent;
    comp.onInvalidate.add(resize, false, 10);
    left = AutoSizerValue.None;
    right = AutoSizerValue.None;
    top = AutoSizerValue.None;
    bottom = AutoSizerValue.None;
    width = AutoSizerValue.None;
    height = AutoSizerValue.None;
  }
  
  public function setSize(width:AutoSizeParameter, height:AutoSizeParameter):Void
  {
    this.width = width;
    this.height = height;
  }
  
  public function applyOnce(left:AutoSizeParameter, top:AutoSizeParameter, ?right:AutoSizeParameter, ?bottom:AutoSizeParameter, ?width:AutoSizeParameter, ?height:AutoSizeParameter):Void
  {
    if (comp.parent == null) return;
    if (left   == null) left = AutoSizerValue.None;
    if (top    == null) top = AutoSizerValue.None;
    if (right  == null) right = AutoSizerValue.None;
    if (bottom == null) bottom = AutoSizerValue.None;
    if (width  == null) width = AutoSizerValue.None;
    if (height == null) height = AutoSizerValue.None;
    
    apply(left, top, right, bottom, width, height);
  }
  
  public function setAll(left:AutoSizeParameter, top:AutoSizeParameter, right:AutoSizeParameter, bottom:AutoSizeParameter, width:AutoSizeParameter, height:AutoSizeParameter):Void
  {
    this.left = left;
    this.top = top;
    this.right = right;
    this.bottom = bottom;
    this.width = width;
    this.height = height;
    apply(left, top, right, bottom, width, height);
  }
  
  private function resize(comp:Component):Void
  {
    if (comp.parent == null) return;
    apply(left, top, right, bottom, width, height);
  }
  
  private inline function apply(left:AutoSizeParameter, top:AutoSizeParameter, right:AutoSizeParameter, bottom:AutoSizeParameter, width:AutoSizeParameter, height:AutoSizeParameter):Void
  {
    if (comp.parent == null) return;
    var x:Float;
    var w:Int = Std.int(getValue(width, comp.parent.boundsWidth, comp.width));
    if (left == AutoSizerValue.None)
    {
      if (right == AutoSizerValue.None) x = comp.x;
      else
      {
        x = comp.parent.boundsWidth - getValue(right, comp.parent.boundsWidth, comp.x + w) - w;
      }
    }
    else
    {
      x = getValue(left, comp.parent.boundsWidth, comp.x);
      if (right != AutoSizerValue.None)
      {
        if (width == AutoSizerValue.None)
        {
          w = Std.int(comp.parent.boundsWidth - getValue(right, comp.parent.boundsWidth, comp.x + w) - x);
        }
        else
        {
          x += Std.int((comp.parent.boundsWidth - getValue(right, comp.parent.boundsWidth, comp.x + w) - x - w) / 2);
        }
      }
    }
    var y:Float;
    var h:Int = Std.int(getValue(height, comp.parent.boundsHeight, comp.height));
    if (top == AutoSizerValue.None)
    {
      if (bottom == AutoSizerValue.None) y = comp.y;
      else
      {
        y = comp.parent.boundsHeight - getValue(bottom, comp.parent.boundsHeight, comp.y + h) - h;
      }
    }
    else
    {
      y = getValue(top, comp.parent.boundsHeight, comp.y);
      if (bottom != AutoSizerValue.None)
      {
        if (height == AutoSizerValue.None)
        {
          h = Std.int(comp.parent.boundsHeight - getValue(bottom, comp.parent.boundsHeight, comp.y + h) - y);
        }
        else
        {
          y += Std.int((comp.parent.boundsHeight - getValue(bottom, comp.parent.boundsHeight, comp.y + h) - y - h) / 2);
        }
      }
    }
    
    comp.setBounds(x, y, w, h);
  }
  
  private function getValue(val:AutoSizerValue, parentValue:Float, defValue:Float):Float
  {
    switch (val)
    {
      case AutoSizerValue.Percent(v):
        return parentValue * v;
      case AutoSizerValue.Exact(v):
        return v;
      case AutoSizerValue.None:
        return defValue;
    }
  }
  
}

enum AutoSizerValue
{
  Percent(value:Float);
  Exact(value:Float);
  None;
}

abstract AutoSizeParameter(AutoSizerValue) from AutoSizerValue to AutoSizerValue
{
  public inline function new(s:AutoSizerValue)
  {
    this = s;
  }
  
  @:from
  public static inline function fromString(str:String):AutoSizeParameter
  {
    if (StringTools.endsWith(str, "%"))
    {
      return AutoSizerValue.Percent(Std.parseFloat(str.substr(0, str.length - 1)) / 100);
    }
    else if (str == "none" || str == "") return AutoSizerValue.None;
    else
    {
      return AutoSizerValue.Exact(Std.parseFloat(str));
    }
  }
  
  @:from
  public static inline function fromInt(v:Int):AutoSizeParameter
  {
    return AutoSizerValue.Exact(v);
  }
  
  @:from
  public static inline function fromFloat(v:Float):AutoSizeParameter
  {
    return AutoSizerValue.Exact(v);
  }
}