package org.edgardz.utils
{
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.ByteArray;
	import flash.utils.Timer;
	
	import idv.cjcat.stardust.threeD.ThreeDClassPackage;
	
	public class ImageStack extends Sprite
	{
		private var stack	:Vector.<DisplayObject>;
		
		private var _frame			:Number;
		private var _percent		:Number;
		
		private var currentImg		:DisplayObject;
		private var playTimer		:Timer;
		private var playDirection	:int;
		private var playIncrement	:int;
		private var numFrames		:int;
		private var container		:MovieClip;
		
		private var realFrame		:int; 

		public function ImageStack()
		{
			super();
			stack = new Vector.<DisplayObject>();
			container = new MovieClip();
			addChild( container );
		}
		
		public function add( img:DisplayObject ):void
		{
			img.visible = false;
			
			var at :int = stack.length;
			
			stack[at] = img;
			container.addChildAt(img, at);
			
			numFrames = length;
		}
		
		public function addBytes( bytes:ByteArray ):void
		{
			var loader:Loader = new Loader();
				loader.loadBytes(bytes);	
				add(loader);
		}
		
		public function addContainer( _container:DisplayObject ):void
		{
			container = _container as MovieClip;
			
			stack = new Vector.<DisplayObject>();
			
			for( var i:int = 0; i < container.numChildren; i++ )
			{
				stack[i] = container.getChildAt(i);
				stack[i].visible = false;
				if(stack[i] is Bitmap) Bitmap(stack[i]).smoothing = false;
			}
			
			numFrames = length;
			addChild( container );
		}
		
		public function rm( img : DisplayObject ):void
		{
			container.removeChild( img );
			stack = new Vector.<DisplayObject>();
			for( var i:int = 0; i < container.numChildren; i++ )
			{
				stack[i] = container.getChildAt(i);
			}
		}
		
		public function rmAt( at:int ):void
		{
			container.removeChildAt( at );
			stack = new Vector.<DisplayObject>();
			for( var i:int = 0; i < container.numChildren; i++ )
			{
				stack[i] = container.getChildAt(i);
			}
		}
		
		public function play( increment:int = 1, fps:int = -1, direction:int = 1 ):void
		{
			playIncrement = increment;
			playDirection = direction;
			
			currentImg = stack[frame];
			
			if(stage == null && fps == -1) 
			{
				fps = 30;
			}
			else if(fps == -1)
			{
				fps = stage.frameRate;
			}
			
			playTimer = new Timer(1000/fps);
			playTimer.addEventListener( TimerEvent.TIMER, onPlayTimer, false, 0, true );
			playTimer.start();
		}
		
		private function onPlayTimer(e:TimerEvent):void
		{
			frame += playIncrement * playDirection;
		}
		
		public function stop():void
		{
			pause();
			frame = 0;
		}
		
		public function pause():void
		{
			playTimer.reset();
			playTimer.removeEventListener( TimerEvent.TIMER, onPlayTimer );
		}

		public function get frame():Number
		{
			return _frame ? _frame : 0;
		}

		public function set frame(value:Number):void
		{
			if(currentImg != null) currentImg.visible = false;
			
			_frame = value;
			
			var realFrame:int = int(_frame);
			if( realFrame < 0 ) realFrame = stack.length + (realFrame % stack.length); 
			if( realFrame > stack.length-1 ) realFrame %= stack.length;

			currentImg = stack[realFrame];
			currentImg.visible = true;
			
			//trace( _frame, percent );
		}

		public function get length():int
		{
			return stack.length;
		}
		
		public function get percent():Number
		{
			return frame/(length-1);
		}

		public function set percent(value:Number):void
		{
			value *= 0.999; //  senao o percent zera, quando chegar em 1
			frame = Math.round((length-1)*(value%1));
		}
		
		public function set smoothing( value:Boolean ):void
		{
			for( var i:int = 0; i < container.numChildren; i++ )
			{
				var img : DisplayObject = container.getChildAt(i) as DisplayObject;
				
				if(img is Bitmap)
				{
					Bitmap(img).smoothing = value;
					//Bitmap(img).smoothing = false;
				}
			}
		}
		

	}
}