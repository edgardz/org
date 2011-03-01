package org.edgardz.utils
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public function addMouseListeners(obj:Sprite, over:Function = null, out:Function = null, click:Function = null, buttonMode:Boolean = true, mouseChildren:Boolean = false, weakReference:Boolean = true):void
	{
		obj.mouseEnabled = true;
		obj.buttonMode = buttonMode;
		obj.mouseChildren = mouseChildren;
		if(over != null) obj.addEventListener(MouseEvent.ROLL_OVER, over, false, 0, weakReference);	
		if(out != null) obj.addEventListener(MouseEvent.ROLL_OUT, out, false, 0, weakReference);	
		if(click != null) obj.addEventListener(MouseEvent.CLICK, click, false, 0, weakReference);	
	}
}