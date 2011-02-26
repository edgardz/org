package org.edgardz.embed
{
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.utils.ByteArray;
	
	/**
	 * The EmbeddedSwf class allow Swf files to be embedded with full 
	 * action script access on Adobe Flex Builder.
	 * 
	 * @author Edgard Zavarezzi / edgardz.com
	 */

	
	public class EmbeddedSwf extends MovieClip
	{
		private var mcInstanceName	:String;
		private var loader			:Loader;
		private var bytes			:ByteArray;
		private var okToAdd			:Boolean;
		private var evt				:EmbedEvent;
		private var _swf			:MovieClip;
		private var _isLoaded		:Boolean;
		private var onComplete		:Function;
		
		public var postLoadAction	:Function;
		
		protected var i				:Number;
		
		public function EmbeddedSwf()
		{
			super();
			evt = new EmbedEvent(EmbedEvent.COMPLETE, false, false);
		}
		
		public function embed(SwfClass:Class, onCompleteAction:Function = null, addAsChild:Boolean = true):void
		{
			okToAdd = addAsChild;
			bytes = (new SwfClass() as ByteArray);
			
			onComplete = onCompleteAction;
			
			loader = new Loader();
			loader.loadBytes(bytes, new LoaderContext(false,ApplicationDomain.currentDomain) );
			//loader.loadBytes(bytes);
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoadComplete, false, 0, true);
		}
		
		public function get swf():MovieClip
		{
			if(_swf == null)
			{
				trace("Swf not completely loaded, listen for EmbedEvent.COMPLETE event");
				return null;
			}
			else
			{
				return _swf;
			}
		}
		
		public function get loaded():Boolean
		{
			return _isLoaded;
		}
		
		private function onLoadComplete(e:Event):void
		{
			loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, onLoadComplete);
			
			_swf = MovieClip(loader.content);
			
			_isLoaded = true;
			
			if(okToAdd) 
			{
				addChild(_swf);
			}
			dispatchEvent(evt);
			
			if(onComplete != null) onComplete();
			if(postLoadAction != null) postLoadAction();
		}
		
		public function getLibraryClass(className:String):Class
		{
			try
			{
				return loader.contentLoaderInfo.applicationDomain.getDefinition(className) as Class;
			}
			catch(e:Error)
			{
				throw new Error( className +" definition not found!");
			}
			
			return null;
		}

	}
}