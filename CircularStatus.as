package {
  import flash.events.Event;
  import flash.display.Sprite;
  import flash.display.Bitmap;
  
  public class CircularStatus extends Sprite {
  
    private var points:Array;
    // a,b center; radio; diametro, sectores
    private var a:Number,b:Number,r:Number,d:Number,s:Number;
    
    private var _value:Number = 1;

    public function CircularStatus(diagonal:int,sector_quantity:int,point:Bitmap) {
      points = [];
      d = diagonal;
      s = sector_quantity;
      a = b = r = d/2;
      var t:Number;
      var p:Bitmap;
      for(var cont:int=0;cont<s*4;cont++) {
        p = new Bitmap(point.bitmapData);
        addChild(p);
        points.push(p);
        
        // http://en.wikipedia.org/wiki/Circle
        t = -Math.PI/2+Math.PI/2/s*cont;
        p.x = a+r*Math.cos(t);
        p.y = b+r*Math.sin(t);
      }
    }
    
    // 0..1 0..s*4-1
    public function get value():Number {
      return _value;
    }
    public function set value(v:Number):void {
      if(v<=0) {
        _value = 0;
      } else if(v>=1) {
        _value = 1;
      } else {
        _value = v;
      }
      var ini:int = 0;
      var f1:int = _value*points.length;
      for(var c:int=0;c<f1;c++) {
        points[c].alpha = 1;
      }
      for(c=f1;c<points.length;c++) {
        points[c].alpha = 0;
      }
    }
    
  } // class
} // package

