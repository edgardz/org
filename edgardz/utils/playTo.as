package org.edgardz.utils
{
	import flash.display.MovieClip;
	import flash.events.Event;

	public function playTo(mc:MovieClip, frame:int):void
	{
		if( mc.hasEventListener( Event.ENTER_FRAME ) )
		{
			try
			{
				mc.removeEventListener( Event.ENTER_FRAME, onEf );
			}
			catch(e:Error)
			{
				trace(e);
			}
		}
		
		mc.addEventListener( Event.ENTER_FRAME, onEf, false, 0, true );
		
		function onEf(e:Event):void
		{
			if( mc.currentFrame > frame )
			{
				mc.prevFrame();
			}
			else
			{
				mc.nextFrame();
			}
			
			if( mc.currentFrame == frame )
			{
				mc.removeEventListener( Event.ENTER_FRAME, onEf );
			}
		}
	}
}