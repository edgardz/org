package org.edgardz.utils
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.BlendMode;
	import flash.display.DisplayObject;
	import flash.display.IBitmapDrawable;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.filters.BlurFilter;
	import flash.geom.Point;
	import flash.utils.Timer;
	
	public class BlurLayer extends Sprite
	{
		private var input		:IBitmapDrawable;
		public var bitmap		:Bitmap;
		private var bitmapData	:BitmapData;
		private var filter		:BlurFilter;
		private var numPasses	:Number;
		
		private var timer		:Timer;
		
		public function BlurLayer(w:Number, h:Number, _input:IBitmapDrawable, blurAmount:Number = 4, blurQuality:Number = 2, passesPerFrame:Number = 1, fps:int=24)
		{
			super();
			
			input = _input;
			numPasses = passesPerFrame;
			
			filter = new BlurFilter(blurAmount, blurAmount, blurQuality);
			
			bitmapData = new BitmapData( w, h, true, 0x000000 );
			
			bitmap = new Bitmap(bitmapData);
			
			addChild( bitmap );
			
			timer = new Timer(1000/fps);
			timer.addEventListener(TimerEvent.TIMER, onTimer, false, 0, true);
			
			start();
		}
		
		private function onTimer(e:TimerEvent):void
		{
			bitmapData.lock(); 
			
			bitmapData.draw(input);
			
			for(var i:int = 0; i<numPasses; i++)
			{
				bitmapData.applyFilter( bitmapData, bitmapData.rect, new Point(0,0), filter );
			}

			bitmapData.unlock();
		}
		
		private function start():void
		{
			timer.start();
		}
		
		private function stop():void
		{
			timer.stop();
		}
		
	}
}