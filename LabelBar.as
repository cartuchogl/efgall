package {
  import flash.events.Event;
  import flash.events.MouseEvent;
  import flash.display.Sprite;
  import flash.display.Bitmap;
  import flash.display.StageDisplayState;
  import flash.text.TextField;
  import flash.text.TextFieldAutoSize;
  import flash.text.TextFormat;
  import flash.display.Graphics;
  import flash.display.Shape;
  
  public class LabelBar extends Sprite {
    
    private var label:TextField;
    private var labelText:String = "Loading...";
    
    private var backgroundRect:Shape;

    public function LabelBar() {
        addChild(backgroundRect = new Shape());
        configureLabel();
        setLabel(labelText);
    }

    public function setLabel(str:String):void {
        label.text = str;
    }
    
    public function refreshState():void {
      backgroundRect.graphics.clear();
      backgroundRect.graphics.beginFill(0x000000);
      backgroundRect.graphics.drawRect(0, 0, stage.stageWidth, height+8*2);
      backgroundRect.graphics.endFill();
/*      label.width = stage.stageWidth;*/
/*      label.height = label.textHeight*1.8;*/
    }

    private function configureLabel():void {
        label = new TextField();
        label.background = true;
        label.backgroundColor = 0x000000;
        label.border = false;
        label.autoSize = TextFieldAutoSize.LEFT;
        label.x = 12;
        label.y = 8;

        var format:TextFormat = new TextFormat();
        format.font = "Verdana";
        format.color = 0xAAAAAA;
        format.size = 9;

        label.defaultTextFormat = format;
        addChild(label);
    }
  }
}

