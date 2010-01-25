package {
  import flash.events.Event;
  import flash.events.MouseEvent;
  import flash.display.Sprite;
  import flash.display.Bitmap;
  import flash.display.StageDisplayState;
  
  public class FullScreenButton extends Sprite {
    
    [Embed(source="assets/fullscreen.png")] private static var _fullscreen:Class;
    
    private var _control:Bitmap;
    
    public function FullScreenButton():void {
      _control = new _fullscreen();
      addChild(_control);
      addEventListener(MouseEvent.MOUSE_OVER,onMouseOver);
      addEventListener(MouseEvent.MOUSE_OUT,onMouseOut);
      addEventListener(MouseEvent.CLICK,onClick);
    }
    
    private function onMouseOver(event:MouseEvent):void {
      
    }
    
    private function onMouseOut(event:MouseEvent):void {
      
    }
    
    private function onClick(event:MouseEvent):void {
      if(stage.displayState == StageDisplayState.FULL_SCREEN) {
				stage.displayState = StageDisplayState.NORMAL;
			} else {
				stage.displayState = StageDisplayState.FULL_SCREEN;
			}
    }        
  }
  
}

