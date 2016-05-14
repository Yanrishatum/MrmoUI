package com.yanrishatum.mrmoui.components;
import flash.display.Sprite;

/**
 * ...
 * @author Yanrishatum
 */
class ComponentContainer extends Component
{
  
  private var children:Array<Component>;
  private var childrenVisual:Sprite;

  public function new() 
  {
    children = new Array();
    super();
  }
  
  public function add(c:Component):Void
  {
    if (c.parent != this)
    {
      if (c.parent != null) c.parent.remove(c);
      children.push(c);
      c.parent = this;
      c.onInvalidate.add(childrenInvalidated);
      c.added(childrenVisual);
      c.invalidate();
    }
  }
  
  public function remove(c:Component):Bool
  {
    if (c.parent == this)
    {
      c.onInvalidate.remove(childrenInvalidated);
      c.removed(childrenVisual);
      c.parent = null;
      children.remove(c);
      return true;
    }
    return false;
  }
  
  override public function invalidate():Void 
  {
    super.invalidate();
    if (!ignoreInvalidation)
    {
      ignoreInvalidation = true;
      for (c in children) c.invalidate();
      ignoreInvalidation = false;
    }
  }
  
  private var ignoreInvalidation:Bool = false;
  private function childrenInvalidated(child:Component):Void
  {
    if (ignoreInvalidation) return;
    ignoreInvalidation = true;
    for (c in children)
    {
      if (c != child) c.invalidate();
    }
    invalidate();
    ignoreInvalidation = false;
  }
  
  override function get_boundsHeight():Int 
  {
    return _h - 24;
  }
  
  override function get_boundsWidth():Int 
  {
    return _w - 4;
  }
  
}