package org.edgardz.utils
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.net.URLRequest;
	import flash.net.URLStream;
	import flash.utils.ByteArray;
	import flash.utils.getTimer;

	public class ImageLoader extends MovieClip
	{
		private var _loader			:Loader;
        private var stream			:URLStream;
        private var data			:ByteArray;
        
        private var subloaders		:Sprite;
        
        private var subloadersBmp	:Bitmap;
		
		public function ImageLoader()
		{
			super();
			
			stream = new URLStream();
            stream.addEventListener( ProgressEvent.PROGRESS , streamProgress, false, 0, true );
            stream.addEventListener( Event.COMPLETE , streamComplete, false, 0, true );
            
            _loader = new Loader();
            
			subloaders = new Sprite();
			subloadersBmp = new Bitmap(new BitmapData(1,1,true,0x00ffffff));
            addChild(subloadersBmp);
		}
		
		public function load(input:String):void
		{
			if ( stream.connected ) stream.close();

            stream.load( new URLRequest( input + '?' + getTimer() ) );
            
           _loader.unload();    
     
            data = new ByteArray();
		}
		
		public function get content():*
		{
			return _loader.content;
		}
		
		public function get loader():*
		{
			return _loader;
		}
		
		private function streamProgress(e:ProgressEvent):void
        {
            if( stream.bytesAvailable == 0 ) return;
			processData();
        }
        
        private function streamComplete(e:Event):void
        {
        	processData();
            if ( stream.connected ) stream.close();
            
            _loader.loadBytes( data );
            _loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loadComplete, false, 0, true);
        }
        
        private function processData():void
        {
            if ( stream.connected ) stream.readBytes( data , data.length );
            
            var l:Loader = new Loader();
            	l.loadBytes( data );
            	
			subloaders.addChild(l);
			
			updateMask();
        }
		
		private function updateMask():void
		{
			subloadersBmp.bitmapData = new BitmapData(subloaders.width+1, subloaders.height+1, true, 0x000000);
			subloadersBmp.bitmapData.draw(subloaders);
			subloadersBmp.bitmapData.threshold(subloadersBmp.bitmapData, new Rectangle(0, 0, subloaders.width, subloaders.height), new Point(0, 0), "==", 0xff808080, 0x00000000, 0xffffff, true);
		}
		
		private function loadComplete(e:Event):void
		{
			_loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, loadComplete);

			addChild(_loader);
			
			removeChild(subloadersBmp);
			
			while(subloaders.numChildren)
			{
				Loader(subloaders.getChildAt(0)).unloadAndStop(false);
				subloaders.removeChildAt(0);
			}
			
			subloaders = null;
			subloadersBmp = null;
			
			dispatchEvent(new Event(Event.COMPLETE));
		}
		

	}
}