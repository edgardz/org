package org.edgardz.embed
{
	import flash.events.Event;

	public class EmbedEvent extends Event
	{
		public static const COMPLETE	:String = "embedComplete";
		
		public function EmbedEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
	}
}