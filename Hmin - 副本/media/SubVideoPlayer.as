package Hmin.media
{
	import fl.video.VideoPlayer;
	import fl.video.VideoEvent;
	import fl.video.VideoState;
	import flash.events.Event;
	
	public class SubVideoPlayer extends VideoPlayer
	{
		private var _playing:Boolean = false;
		
		public function SubVideoPlayer(width:int = 1920, height:int = 1080):void
		{
			super(width, height);
			super.addEventListener(VideoEvent.STATE_CHANGE, onVideoEventHandler, false, 0, true);
			//super.addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStageHandler);
		}
		
		private function onVideoEventHandler(e:VideoEvent):void
		{
			_playing = e.state == VideoState.PLAYING;
		}
		
		private function onRemovedFromStageHandler(e:Event):void
		{
			super.removeEventListener(VideoEvent.STATE_CHANGE, onVideoEventHandler);
			super.removeEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStageHandler);
		}
		
		public function get playing():Boolean{		return _playing;	};
		
	}	
}