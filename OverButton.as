package {
  import flash.display.Bitmap;
  import flash.display.Sprite;
  
  import flash.events.MouseEvent;
  
  public class OverButton extends Sprite {
    protected var _child:Bitmap;
    
    private var _off:Bitmap;
    private var _on:Bitmap;
    
    public function OverButton(off:Class,on:Class):void {
      _off = new off();
      _on = new on();
      _child = new Bitmap(_off.bitmapData);
      addChild(_child);
      
      addEventListener(MouseEvent.MOUSE_OVER,onMouseOver);
      addEventListener(MouseEvent.MOUSE_OUT,onMouseOut);
    }
    
    private function onMouseOver(event:MouseEvent):void {
      _child.bitmapData = _on.bitmapData;
    }
    
    private function onMouseOut(event:MouseEvent):void {
      _child.bitmapData = _off.bitmapData;
    }
    
  } // end class
} // end package