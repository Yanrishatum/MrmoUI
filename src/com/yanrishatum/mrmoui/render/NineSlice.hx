package com.yanrishatum.mrmoui.render;
import flash.display.Sprite;
import openfl.display.Graphics;

/**
 * ...
 * @author Yanrishatum
 */
class NineSlice extends Sprite
{
  public var outlineType:NineSliceOutline;
  public var backgroundType:NineSliceBackground;
  
  public var w:Int;
  public var h:Int;
  public var color:Int;
  public var outlineColor:Int;
  
  public function new() 
  {
    super();
    w = 0;
    h = 0;
    color = 0xffffff;
    outlineColor = 0;
    backgroundType = BNormal;
    outlineType = ONone;
  }
  
  public inline function setColor(color:Int):Void
  {
    this.color = color;
    redraw();
  }
  
  public function setSize(w:Int, h:Int):Void
  {
    this.w = w;
    this.h = h;
    redraw();
  }
  
  public function redraw():Void
  {
    var g:Graphics = this.graphics;
    g.clear();
    switch (outlineType)
    {
      case ONormal:
        g.beginFill(outlineColor);
        g.drawRect(0, -1, w, 1);
        g.drawRect( -1, 0, w + 2, h);
        g.drawRect(0, h, w, 1);
      case OSquare:
        g.beginFill(outlineColor);
        g.drawRect( -1, -1, w + 2, h + 2);
      case ONone:
        g.beginFill(0, 0);
        // Nope
    }
    switch (backgroundType)
    {
      case BNormal, BNone:
        if (backgroundType != BNone) g.beginFill(color);
        g.drawRect(1, 0, w - 2, 1);
        g.drawRect(0, 1, w, h - 2);
        g.drawRect(1, h - 1, w - 2, 1);
      case BSquare, BSquareNone:
        if (backgroundType != BSquareNone) g.beginFill(color);
        g.drawRect(0, 0, w, h);
    }
    g.endFill();
    
  }
  
  private inline function drawOutline(g:Graphics):Void
  {
  }
  
  private inline function drawBg(g:Graphics):Void
  {
  }
  
}

enum NineSliceOutline
{
  ONormal;
  OSquare;
  ONone;
}

enum NineSliceBackground
{
  BNormal;
  BSquare;
  BNone;
  BSquareNone;
}