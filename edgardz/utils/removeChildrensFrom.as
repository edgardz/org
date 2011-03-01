package org.edgardz.utils
{
	import flash.display.DisplayObjectContainer;

	public function removeChildrensFrom( container:DisplayObjectContainer ):void
	{
		while( container.numChildren ) container.removeChildAt(0);
	}
}