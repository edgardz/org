package org.edgardz.utils
{
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;

	public function addLoaderListeners( loader:Loader, onProgress:Function, onComplete:Function, onIoError:Function ):void
	{
		if( onProgress != null ) loader.contentLoaderInfo.addEventListener( ProgressEvent.PROGRESS, onProgress, false, 0, true );
		if( onComplete != null ) loader.contentLoaderInfo.addEventListener( Event.COMPLETE, 		onComplete, false, 0, true );
		if( onIoError  != null ) loader.contentLoaderInfo.addEventListener( IOErrorEvent.IO_ERROR, 	onIoError,  false, 0, true );
	}
}