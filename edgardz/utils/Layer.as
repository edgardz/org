package org.edgardz.utils
{
	import flash.display.DisplayObject;
	
	public class Layer 
	{
		
		public static function toTop(quem:DisplayObject):void
		{
			if(quem.parent != null)
			{
				if (quem.parent.getChildIndex(quem) < int(quem.parent.numChildren - 1))
				{
					quem.parent.setChildIndex(quem, int(quem.parent.numChildren - 1));
				}
			}
		}
		
		public static function toBottom(quem:DisplayObject):void
		{
			if(quem.parent != null)
			{
					quem.parent.setChildIndex(quem, 0);
			}
		}
		
		public static function setOrder(... quais):void 
		{
			for each(var item:DisplayObject in quais)
			{
				toTop(item);
			}
		}

	}
}