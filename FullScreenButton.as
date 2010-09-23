package {
  import flash.events.Event;
  import flash.events.MouseEvent;
  import flash.display.Sprite;
  import flash.display.Bitmap;
  import flash.display.StageDisplayState;
  
  public class FullScreenButton extends OverButton {
    
    [Embed(source="assets/fullscreen.png")] private static var _fullscreen:Class;
    [Embed(source="assets/fullscreen_over.png")] private static var _fullscreen_over:Class;
    
    public function FullScreenButton():void {
      super(_fullscreen,_fullscreen_over);
      addEventListener(MouseEvent.CLICK,onClick);
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

