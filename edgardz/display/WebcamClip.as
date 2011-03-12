package org.edgardz.display
{
	import flash.display.Sprite;
	import flash.events.ActivityEvent;
	import flash.events.ErrorEvent;
	import flash.media.Camera;
	import flash.media.Video;
	import flash.system.Capabilities;
	
	import org.edgardz.utils.removeChildrensFrom;
	
	public class WebcamClip extends Sprite
	{
		public var camera 		:Camera;
		public var video		:Video;
		public var isActive		:Boolean;
		
		private var _smoothing	:Boolean;
		
		public function WebcamClip( width:int = 320, height:int = 240, framerate:int = 30, smoothing:Boolean = false )
		{
			super();
			
			// common webcam resolutions: 640 x 480 / 480 x 360 / 320 x 240 / 240 x 180 / all with aspect = 1.3333;
			
			isActive = false;

			if( Capabilities.manufacturer.toLowerCase().search( "macintosh" ) != -1 ) 
			{ 
				var realCam	:String = null;
				var idCam	:*;
				
				for( idCam in Camera.names )
				{
					if( String( Camera.names[idCam] ).toLowerCase().search( "usb video" ) != -1 ) 
					{
						realCam = idCam.toString();
						break;
					}
				}
				camera = Camera.getCamera(realCam);
			} 
			else 
			{
				camera = Camera.getCamera();
			}
			
			
			if(camera != null) 
			{
				camera.setMode( width, height, framerate);
				camera.addEventListener(ActivityEvent.ACTIVITY, onWebcamActivity, false, 0, true );
				
				video = new Video( width, height );
				video.attachCamera( camera );
				
				video.scaleX = -1;
				video.x = width;
				
				this.smoothing = smoothing;
				
				addChild(video);
			}
			else
			{
				trace("webcam not available");
				dispatchEvent( new ErrorEvent(ErrorEvent.ERROR) );
			}
		}
		
		private function onWebcamActivity(e:ActivityEvent):void
		{
			isActive = true;
			camera.removeEventListener(ActivityEvent.ACTIVITY, onWebcamActivity );
		}
		
		public function turnOff():void
		{
			camera = null;
			removeChildrensFrom( this );
		}

		public function get smoothing():Boolean
		{
			return _smoothing;
		}

		public function set smoothing(value:Boolean):void
		{
			_smoothing = value;
			video.smoothing = _smoothing;
		}

	}
}