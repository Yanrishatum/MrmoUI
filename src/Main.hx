package;

import com.yanrishatum.mrmoui.components.Button;
import com.yanrishatum.mrmoui.components.Component;
import com.yanrishatum.mrmoui.components.Label;
import com.yanrishatum.mrmoui.components.Panel;
import com.yanrishatum.mrmoui.components.RootComponent;
import com.yanrishatum.mrmoui.components.TextArea;
import com.yanrishatum.mrmoui.utils.GuiBuilder;
import com.yanrishatum.mrmoui.utils.Icons;
import haxe.CallStack;
import haxe.Log;
import openfl.Assets;
import openfl.display.Sprite;
import openfl.Lib;
import openfl.text.TextField;
import openfl.text.TextFormatAlign;

/**
 * ...
 * @author Yanrishatum
 */
class Main extends Sprite 
{
  private var rootComp:RootComponent;
  private var panel:Component;
  private var input:TextArea;
  
	public function new() 
	{
		super();
    trace("DONE");
    
    var btn:Button = new Button("Refresh", 0xffffff, 0x3c8ee7, 100);
    btn.onClick.add(refresh);
    
    input = new TextArea();
    input.sizer.top = 30;
    input.sizer.bottom = 0;
    input.sizer.width = "100%";
    input.text = Assets.getText("assets/test.xml");
    
    var label:Label = new Label();
    label.color = 0;
    label.text = "Build #" + Lib.application.config.build;
    label.x = 120;
    
    rootComp = new RootComponent(this);
    rootComp.useStageSize = true;
    rootComp.invalidate();
    rootComp.add(btn);
    rootComp.add(input);
    rootComp.add(label);
    
    refresh();
    //try
    //{
      //trace("root");
      //var xml:Xml = Xml.parse(Assets.getText("assets/test.xml"));
      //trace(xml);
      //var panel:Panel = GuiBuilder.build(xml, rootComp, ["text"=>"Mrmo doing awesome designs]"]);
      //
      //var ok:Button = new Button("Yes", 0xffffff, 0x62696f, 66, Icons.ok(0xffffff, 0x49bb00));
      //ok.sizer.right = "52%";
      //ok.sizer.bottom = 11;
      //panel.add(ok);
      //
      //var cancel:Button = new Button("No", 0xffffff, 0x62696f, 66, Icons.cross(0xffffff, 0xdb824d));
      //cancel.sizer.left = "52%";
      //cancel.sizer.bottom = 11;
      //panel.add(cancel);
    //}
    //catch (e:Dynamic)
    //{
      //Log.trace(e);
      //haxe.Log.trace(CallStack.toString(CallStack.exceptionStack()));
    //}
    
	}
  
  private function refresh():Void
  {
    if (panel != null)
    {
      rootComp.remove(panel);
      panel = null;
    }
    var t:String = StringTools.htmlUnescape(StringTools.replace(input.text, "<br>", "\n"));
    panel = GuiBuilder.build(Xml.parse(t), rootComp, ["text"=>"Mrmo doing awesome designs"]);
  }

}
