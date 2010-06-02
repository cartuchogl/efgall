package {
  import flash.events.Event;
  import flash.events.MouseEvent;
  import flash.display.Sprite;
  import flash.display.Bitmap;
  import flash.display.StageDisplayState;
  import flash.display.Graphics;
  import flash.display.Shape;
  
  public class ToolBar extends Sprite {
    
    private var fullBtn:FullScreenButton;
    private var playBtn:PlayPauseButton;
    private var backgroundRect:Shape;
    
    [Embed(source="assets/next.png")] private static var _next:Class;
    [Embed(source="assets/next_over.png")] private static var _next_over:Class;
    [Embed(source="assets/previous.png")] private static var _previous:Class;
    [Embed(source="assets/previous_over.png")] private static var _previous_over:Class;
    
    private var nextBtn:OverButton;
    private var prevBtn:OverButton;

    public function ToolBar() {
      addChild(backgroundRect = new Shape());
      addChild(fullBtn = new FullScreenButton());
      addChild(playBtn = new PlayPauseButton());
      
      prevBtn = new OverButton(_previous,_previous_over);
      addChild(prevBtn);
      prevBtn.addEventListener(MouseEvent.CLICK,function(e:Event):void {
        dispatchEvent(new Event('ON_PREV'));
      });

      
      nextBtn = new OverButton(_next,_next_over);
      addChild(nextBtn);
      nextBtn.addEventListener(MouseEvent.CLICK,function(e:Event):void {
        dispatchEvent(new Event('ON_NEXT'));
      });
      
      playBtn.addEventListener(MouseEvent.CLICK,onMouseClick);
    }
    
    private function onMouseClick(event:MouseEvent):void {
      dispatchEvent(new Event("ON_PLAY_PAUSE"));
    }
    
    public function set playing(t:Boolean):void {
      playBtn.playing = t;
    }
    public function get playing():Boolean {
      return playBtn.playing;
    }
    
    public function refreshState():void {
      x = 0;
      y = stage.stageHeight-height;
      backgroundRect.graphics.clear();
      backgroundRect.graphics.beginFill(0x000000);
      backgroundRect.graphics.drawRect(0, 0, stage.stageWidth, height);
      backgroundRect.graphics.endFill();
      fullBtn.x = stage.stageWidth-fullBtn.width;
      playBtn.x = fullBtn.x-playBtn.width;
      
      prevBtn.x = (stage.stageWidth-prevBtn.width+nextBtn.width)/2;
      nextBtn.x = prevBtn.x+prevBtn.width;
    }
  }
}

