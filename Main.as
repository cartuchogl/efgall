package {
  import flash.net.navigateToURL;
  import flash.net.URLRequest;
  import flash.net.URLLoader;
  import flash.events.Event;
  import flash.events.MouseEvent;
  import flash.display.Sprite;
  import flash.display.Bitmap;
  import flash.display.StageQuality;
  import flash.display.StageScaleMode;
  import flash.display.StageAlign;
  import flash.external.*;
  import flash.utils.Timer;
  import flash.events.TimerEvent;
  import flash.events.ProgressEvent;
  
  import flash.display.Loader;
  import flash.display.LoaderInfo;
	import flash.display.DisplayObject;
	import flash.net.URLRequest;
  
  [SWF(backgroundColor="#000000", frameRate="10")]
  public class Main extends Sprite {
    [Embed(source="assets/loading.png")] private static var _bgImg:Class;
    public var _background:Bitmap;
    [Embed(source="assets/point1.png")] private static var _Point_1:Class;
    [Embed(source="assets/point2.png")] private static var _Point_2:Class;
    [Embed(source="assets/point3.png")] private static var _Point_3:Class;
    public var _container:Sprite;
    
    private var _label:LabelBar;
    private var _toolbar:ToolBar;
    
    private var _images:Array = [];
    private var _images_indx:int = 0;
    
    private var _timer_circular:CircularStatus;
    private var _bg_circular:CircularStatus;
    private var _loader_circular:CircularStatus;
    
    private var myTimer:Timer;
    
    public function Main():void {
      _container = new Sprite();
      _container.x = _container.y = 0;
      addChild(_container);
      _background = new _bgImg();
      _container.addChild(_background);
      
      stage.scaleMode = StageScaleMode.NO_SCALE;
      stage.align = StageAlign.TOP_LEFT;
      stage.addEventListener(Event.RESIZE, resizeListener);
      center();
      
      addChild(_label = new LabelBar());
      addChild(_toolbar = new ToolBar());
      addChild(_bg_circular = new CircularStatus(30,3,new _Point_2()));
      addChild(_timer_circular = new CircularStatus(30,3,new _Point_1()));
      addChild(_loader_circular = new CircularStatus(30,3,new _Point_3()));
      updateComponents();
      
      _toolbar.addEventListener('ON_PREV',onPrevious);
      _toolbar.addEventListener('ON_NEXT',onNext);
      _toolbar.addEventListener('ON_PLAY_PAUSE',onPlayPause);
      
      ExternalInterface.addCallback("loadGallery",load_gallery); 
      ExternalInterface.addCallback("goToPage",goToPage); 
      
      _timer_circular.value = 0;
      _bg_circular.value = 1;
      _loader_circular.value = 0;
      // 200ms*25 ~= 5sg
      myTimer = new Timer(200, 25);
      myTimer.addEventListener(TimerEvent.TIMER, function(event:TimerEvent):void {
          _timer_circular.value += 1.0/23.0;
      });
      myTimer.addEventListener(TimerEvent.TIMER_COMPLETE, function(event:TimerEvent):void {
          _timer_circular.value = 0;
          _bg_circular.value = 1;
          onNext(null);
          myTimer.reset();
      });
      
      var u:URLRequest = new URLRequest("javascript:efgallReady()"); 
      navigateToURL(u,"_self"); 
    }
    
    private function updateComponents():void {
      _label.refreshState();
      _toolbar.refreshState();
      _timer_circular.x = _bg_circular.x = _loader_circular.x = stage.stageWidth-59;
      _timer_circular.y = _bg_circular.y = _loader_circular.y = stage.stageHeight-64;
    }
    
    public function goToPage(page:int):void {
      if(page>=_images.length) {
        page = 0;
      } else if(page<0) {
        page = _images.length-1;
      }
      load_image(_images[page][0]);
/*      _label.setLabel(_images[page][1]);*/
      _images_indx = page;
    }
    
    private function onNext(event:Event):void {
      if(myTimer.running) {
        myTimer.stop();
        _toolbar.playing = false;
        goToPage(_images_indx+1);
      } else if(_loader_circular.value==0) {
        goToPage(_images_indx+1);
      }
    }
    
    private function onPrevious(event:Event):void {
      if(myTimer.running) {
        myTimer.stop();
        _toolbar.playing = false;
        goToPage(_images_indx-1);
      } else if(_loader_circular.value==0) {
        goToPage(_images_indx-1);
      }
    }
    
    private function onPlayPause(event:Event):void {
      if(myTimer.running) {
        myTimer.stop();
        _toolbar.playing = false;
      } else if(_loader_circular.value==0) {
        myTimer.start();
        _toolbar.playing = true;
      }
    }
      
    private function center():void {
      _container.x = stage.stageWidth/2;
      _container.y = stage.stageHeight/2;

      _background.x = -_background.width/2;
      _background.y = -_background.height/2;
    }
    
    private function resizeListener(e:Event):void {
      updateComponents();
      center();
      fitOr11();
    }

    private function preload_image(url:String):void {
      var loader:Loader = new Loader();
      var request:URLRequest = new URLRequest(url);
      loader.load(request);
    }
    
    public function load_image(url:String):void {
      var loader:Loader = new Loader();
      loader.contentLoaderInfo.addEventListener(Event.COMPLETE, function(e:Event):void {
        _loader_circular.value = 0;
        _background.bitmapData = e.target.content.bitmapData;
        _background.smoothing = true;
        fitOr11();
        _label.setLabel(_images[_images_indx][1]);
        if(_toolbar.playing == true)
          myTimer.start();
        if(_images[_images_indx+1]) {
          preload_image(_images[_images_indx+1][0]);
        }
        var u:URLRequest = new URLRequest(
          "javascript:if(window['efgallLoadImage']){efgallLoadImage("+_images_indx+")}"
        ); 
        navigateToURL(u,"_self");
      });
      loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, progressHandler);
      var request:URLRequest = new URLRequest(url);
      loader.load(request);
    }
    
    private function progressHandler(event:ProgressEvent):void {
      if(myTimer.running) {
        myTimer.stop();
        myTimer.reset();
      }
      _loader_circular.value = event.bytesLoaded/event.bytesTotal;
/*      _label.setLabel('Loading. '+event.bytesLoaded+'/'+event.bytesTotal+' bytes');*/
    }
    
    public function load_gallery(images:Array):void {
      _images = images;
      launchGal();
    }
    
    private function launchGal():void {
      _toolbar.playing = true;
      goToPage(0);
    }
    
    public function scale11():void {
      _background.scaleX = 1;
      _background.scaleY = 1;
      
      center();
    }
    
    private function fitOr11():void {
      var w:Number = _background.bitmapData.width;
      var h:Number = _background.bitmapData.height;
      
      if((w>stage.stageWidth)||(h>stage.stageHeight)) {
        fitWindow();
      } else {
        scale11();
      }
    }
    
    public function fitWindow():void {
      var w:Number = _background.bitmapData.width;
      var h:Number = _background.bitmapData.height;
      var t:Number = h/(w/stage.stageWidth);
      if(t>stage.stageHeight) {
        t = stage.stageHeight/h;
      } else {
        t = stage.stageWidth/w;
      }
      
      _background.scaleX = t;
      _background.scaleY = t;
      
      center();
    }
        
  }
  
}

