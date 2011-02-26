package org.edgardz.loaders
{
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;

	public class DataLoader
	{
		public static function get( url:String, onComplete:Function, onError:Function = null):void
		{
			var loader 	:URLLoader 	= new URLLoader();
			var request	:URLRequest = new URLRequest(url);
			
			loader.addEventListener(Event.COMPLETE, onComplete, false, 0, true);
			
			if( onError != null ) 
			{
				loader.addEventListener(IOErrorEvent.IO_ERROR, onError, false, 0, true);
				loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onError, false, 0, true);
			}
			
			try 
			{
				loader.load(request);
			}
			catch (e:SecurityError)
			{
				trace("DataLoader:", e); 
			}
		}

		public static function post(url:String, vars:URLVariables, onComplete:Function, onError:Function, dataFormat:String = ""):void 
		{
			var loader	:URLLoader 	= new URLLoader();
				loader.dataFormat = dataFormat == "" ? URLLoaderDataFormat.VARIABLES : dataFormat; 

			var request	:URLRequest = new URLRequest(url);
				request.data = vars;
				request.method = URLRequestMethod.POST;
			
			if( onComplete != null ) 	
			{
				loader.addEventListener( Event.COMPLETE, onComplete, false, 0, true );
			}
			
			if( onError != null ) 
			{
				loader.addEventListener( IOErrorEvent.IO_ERROR, 	onError, 	false, 0, true );
			}
				
			try 
			{
				loader.load(request);
			}
			catch (e:SecurityError)
			{
				trace("DataLoader.as:", e);
			}
		}

	}
}