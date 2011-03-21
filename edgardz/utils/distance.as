package org.edgardz.utils
{
	import flash.display.DisplayObject;
	import flash.geom.Point;

	public function distance( obj1:Object, obj2:Object ):Number
	{
		var dx : Number = obj2.x - obj1.x;
		var dy : Number = obj2.y - obj1.y;
		
		return Math.sqrt(dx*dx + dy*dy);
	}
}