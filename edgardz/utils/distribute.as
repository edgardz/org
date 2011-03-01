package org.edgardz.utils
{
	import flash.display.DisplayObject;
	import flash.geom.Point;

	public function distribute( item:DisplayObject, index:int, cols:int, gap:int = 0, changeItemPosition:Boolean = false ):Point
	{
		var multiplierCol :int = index % cols;
		var multiplierRow :int = Math.floor(index/cols);
		
		var point : Point = new Point();
		
		point.x = multiplierCol * item.width  + (gap*multiplierCol);
		point.y = multiplierRow * item.height + (gap*multiplierRow);
		
		if(changeItemPosition)
		{
			item.x = point.x;
			item.y = point.y;
		}
		
		return point;
	}
}