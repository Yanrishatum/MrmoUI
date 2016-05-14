package com.yanrishatum.mrmoui.utils;
import com.yanrishatum.mrmoui.components.Button;
import com.yanrishatum.mrmoui.components.Component;
import com.yanrishatum.mrmoui.components.ComponentContainer;
import com.yanrishatum.mrmoui.components.Label;
import com.yanrishatum.mrmoui.components.Panel;
import com.yanrishatum.mrmoui.components.TextArea;
import com.yanrishatum.mrmoui.components.TextInput;
import com.yanrishatum.mrmoui.utils.AutoSizer.AutoSizeParameter;
import com.yanrishatum.mrmoui.utils.AutoSizer.AutoSizerValue;
import openfl.display.Shape;
import openfl.text.TextFormatAlign;

/**
 * ...
 * @author Yanrishatum
 */
class GuiBuilder
{

  public static function build<T:Component>(xml:Xml, parent:ComponentContainer, ?values:Map<String, Dynamic>):T
  {
    if (values == null) values = new Map();
    return execNode(xml.firstElement(), parent, parent, values);
  }
  
  private static function execNode<T:Dynamic>(xml:Xml, parent:ComponentContainer, owner:Component, values:Map<String, Dynamic>):T
  {
    var ret:T = null;
    switch (xml.nodeName)
    {
      case "Panel":
        var panel:Panel = new Panel();
        panel.inner.setColor(getInt(xml, "innerColor", panel.inner.color, values));
        panel.outer.setColor(getInt(xml, "outerColor", panel.outer.color, values));
        panel.outlined = getBool(xml, "outlined", panel.outlined, values);
        panel.title = getString(xml, "title", panel.title, values);
        panel.dragable = getBool(xml, "dragable", panel.dragable, values);
        panel.resizable = getBool(xml, "resizable", panel.resizable, values);
        panel.setMinSize(getInt(xml, "minWidth", panel.minWidth, values), getInt(xml, "minHeight", panel.minHeight, values));
        applyBounds(xml, panel, values);
        if (parent != null) parent.add(panel);
        parent = panel;
        owner = panel;
        setOutput(xml, panel, values);
        ret = cast panel;
      case "Sizer":
        var left:AutoSizeParameter = getSizerParam(xml, "left", AutoSizerValue.None, values);
        var right:AutoSizeParameter = getSizerParam(xml, "right", AutoSizerValue.None, values);
        var top:AutoSizeParameter = getSizerParam(xml, "top", AutoSizerValue.None, values);
        var bottom:AutoSizeParameter = getSizerParam(xml, "bottom", AutoSizerValue.None, values);
        var width:AutoSizeParameter = getSizerParam(xml, "width", AutoSizerValue.None, values);
        var height:AutoSizeParameter = getSizerParam(xml, "height", AutoSizerValue.None, values);
        
        if (getBool(xml, "once", false, values))
        {
          owner.sizer.applyOnce(left, top, right, bottom, width, height);
        }
        else
        {
          owner.sizer.setAll(left, top, right, bottom, width, height);
        }
      case "Label":
        var label:Label = new Label();
        label.align = getString(xml, "align", "left", values).toLowerCase();
        label.color = getInt(xml, "color", label.color, values);
        label.text = getString(xml, "text", label.text, values);
        applyBounds(xml, label, values);
        if (parent != null) parent.add(label);
        owner = label;
        setOutput(xml, label, values);
        ret = cast label;
        
      case "TextArea", "TextInput":
        var area:TextArea = xml.nodeName == "TextArea" ? new TextArea() : new TextInput();
        area.color = getInt(xml, "color", area.color, values);
        area.placeholderColor = getInt(xml, "placeholderColor", area.color, values);
        area.placeholder = getString(xml, "placeholder", "", values);
        area.text = getString(xml, "text", "", values);
        area.background = getBool(xml, "background", area.background, values);
        area.outline = getBool(xml, "outline", area.outline, values);
        area.backgroundColor = getInt(xml, "backgroundColor", area.backgroundColor, values);
        area.outlineColor = getInt(xml, "outlineColor", area.outlineColor, values);
        
        applyBounds(xml, area, values);
        if (parent != null) parent.add(area);
        owner = area;
        setOutput(xml, area, values);
        ret = cast area;
        
      case "Button":
        var icon:Shape = null;
        for (ico in xml.elementsNamed("Icon"))
        {
          var fn:Int->Int->Shape = ico.exists("name") && Reflect.hasField(Icons, ico.get("name")) ? Reflect.field(Icons, ico.get("name")) : null;
          if (fn != null)
          {
            icon = fn(getInt(ico, "foreground", 0xffffff, values), getInt(ico, "background", 0, values));
          }
          break;
        }
        var button:Button = new Button(getString(xml, "text", "", values), getInt(xml, "foreground", 0xffffff, values),
            getInt(xml, "background", 0, values), getInt(xml, "width", 100, values), icon);
        owner = button;
        applyBounds(xml, button, values);
        if (parent != null) parent.add(button);
        ret = cast button;
      case "Icon":
        // Do nothing
      default:
        throw "Unknown node: " + xml.nodeName;
    }
    
    for (el in xml.elements()) execNode(el, parent, owner, values);
    
    return ret;
  }
  
  private static inline function setOutput(xml:Xml, v:Dynamic, values:Map<String, Dynamic>):Void
  {
    if (xml.exists("output")) values.set(xml.get("output"), v);
  }
  
  private static inline function applyBounds(xml:Xml, comp:Component, values:Map<String, Dynamic>):Void
  {
    comp.setBounds(getFloat(xml, "x", comp.x, values), getFloat(xml, "y", comp.y, values), getInt(xml, "width", comp.width, values), getInt(xml, "height", comp.height, values));
  }
  
  private static inline function getInt(xml:Xml, att:String, def:Int, vals:Map<String, Dynamic>):Int
  {
    if (xml.exists("arg:" + att) && vals.exists(xml.get("arg:" + att)))
    {
      return vals.get(xml.get("arg:" + att));
    }
    else if (xml.exists(att)) return Std.parseInt(xml.get(att));
    else return def;
  }
  
  private static inline function getFloat(xml:Xml, att:String, def:Float, vals:Map<String, Dynamic>):Float
  {
    if (xml.exists("arg:" + att) && vals.exists(xml.get("arg:" + att)))
    {
      return vals.get(xml.get("arg:" + att));
    }
    else if (xml.exists(att)) return Std.parseFloat(xml.get(att));
    else return def;
  }
  
  private static inline function getBool(xml:Xml, att:String, def:Bool, vals:Map<String, Dynamic>):Bool
  {
    if (xml.exists("arg:" + att) && vals.exists(xml.get("arg:" + att)))
    {
      return vals.get(xml.get("arg:" + att));
    }
    else if (xml.exists(att)) return xml.get(att).toLowerCase() == "true";
    else return def;
  }
  
  private static inline function getString(xml:Xml, att:String, def:String, vals:Map<String, Dynamic>):String
  {
    if (xml.exists("arg:" + att) && vals.exists(xml.get("arg:" + att)))
    {
      return vals.get(xml.get("arg:" + att));
    }
    else if (xml.exists(att)) return xml.get(att);
    else return def;
  }
  
  private static inline function getSizerParam(xml:Xml, att:String, def:AutoSizeParameter, vals:Map<String, Dynamic>):AutoSizeParameter
  {
    if (xml.exists("arg:" + att) && vals.exists(xml.get("arg:" + att)))
    {
      return vals.get(xml.get("arg:" + att));
    }
    else if (xml.exists(att)) return xml.get(att);
    else return def;
  }
  
}