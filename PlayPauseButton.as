package {
  import flash.events.Event;
  import flash.events.MouseEvent;
  import flash.display.Sprite;
  import flash.display.Bitmap;
  
  public class PlayPauseButton extends Sprite {
    
    [Embed(source="assets/play.png")] private static var _play:Class;
    [Embed(source="assets/play_over.png")] private static var _play_over:Class;
    
    [Embed(source="assets/pause.png")] private static var _pause:Class;
    [Embed(source="assets/pause_over.png")] private static var _pause_over:Class;
    
    private var _control:Bitmap;
    private var _playing:Boolean = false;
    private var _over:Boolean = false;
    
    public function PlayPauseButton():void {
      _control = new _play();
      addChild(_control);
      addEventListener(MouseEvent.MOUSE_OVER,onMouseOver);
      addEventListener(MouseEvent.MOUSE_OUT,onMouseOut);
    }
    
    public function get playing():Boolean {
      return _playing;
    }
    public function set playing(state:Boolean):void {
      _playing = state;
      update();
    }
    
    private function onMouseOver(event:MouseEvent):void {
      _over = true;
      update();
    }
    
    private function onMouseOut(event:MouseEvent):void {
      _over = false;
      update();
    }
    
    
    private function update():void {
      if(_playing)
        _control.bitmapData = _over ? new _pause_over().bitmapData : new _pause().bitmapData;
      else
        _control.bitmapData = _over ? new _play_over().bitmapData : new _play().bitmapData;
    }
        
  }
  
}

