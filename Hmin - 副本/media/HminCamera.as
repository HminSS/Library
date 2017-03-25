package Hmin.media
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.media.Camera;
	import flash.media.Video;
	
	/**
	 * ...
	 * @author ...
	 */
	public class HminCamera extends MovieClip
	{
		private var camera:Camera;
		private var video:Video;
		
		public function HminCamera(width:int = 1920,height:int = 1080,fps:int = 30,name:String = null):void
		{
			var camera = Camera.getCamera(name);
			
			if (camera != null)
			{
				camera.setMode(width, height, fps, true);
				video = new Video(width, height);
				video.attachCamera(camera);
				addChild(video);
				
				this.dispatchEvent(new Event("cameraStart"));
			}
			else
			{
				trace("no camera,plz check");
			}
		}
		
		public function dispose():void
		{
			removeChild(video);
			video = null;
			camera = null;
			this.dispatchEvent(new Event("cameraExit"));
		}
	}
	
}