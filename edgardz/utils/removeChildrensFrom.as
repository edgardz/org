package org.edgardz.utils
{
	import flash.display.DisplayObjectContainer;

	public function removeChildrensFrom( obj:DisplayObjectContainer ):void
	{
		while( obj.numChildren ) obj.removeChildAt(0);
	}
}