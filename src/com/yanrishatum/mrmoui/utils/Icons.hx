package com.yanrishatum.mrmoui.utils;
import openfl.Vector;
import openfl.display.Graphics;
import openfl.display.Shape;

/**
 * ...
 * @author Yanrishatum
 */
class Icons
{

  public static function ok(foreground:Int, background:Int):Shape
  {
    var shape:Shape = bgIcon(background);
    var g:Graphics = shape.graphics;
    g.beginFill(foreground);
    g.drawRect(3, 7, 2, 2);
    g.drawRect(5, 9, 3, 2);
    g.drawRect(8, 7, 2, 2);
    g.drawRect(10, 5, 2, 2);
    g.drawRect(6, 11, 1, 1);
    g.beginFill(foreground);
    g.drawRect(4, 8, 2, 2);
    g.drawRect(7, 8, 2, 2);
    g.drawRect(9, 6, 2, 2);
    g.endFill();
    return shape;
  }
  
  public static function cross(foreground:Int, background:Int):Shape
  {
    var shape:Shape = bgIcon(background);
    var g:Graphics = shape.graphics;
    g.beginFill(foreground);
    g.drawRect(4, 4, 2, 2);
    g.drawRect(9, 4, 2, 2);
    g.drawRect(4, 9, 2, 2);
    g.drawRect(9, 9, 2, 2);
    g.drawRect(6, 6, 3, 3);
    g.beginFill(foreground);
    g.drawRect(5, 5, 2, 2);
    g.drawRect(8, 5, 2, 2);
    g.drawRect(5, 8, 2, 2);
    g.drawRect(8, 8, 2, 2);
    g.endFill();
    return shape;
  }
  
  private static inline function bgIcon(color:Int):Shape
  {
    var shape:Shape = new Shape();
    var g:Graphics = shape.graphics;
    g.beginFill(color);
    g.drawRect(1, 0, 13, 1);
    g.drawRect(0, 1, 15, 13);
    g.drawRect(1, 14, 13, 1);
    g.endFill();
    return shape;
  }
  
}