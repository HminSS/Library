package Hmin.media
{
	import flash.display.MovieClip;
	import flash.media.Video;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	import flash.events.NetStatusEvent;
	import flash.events.AsyncErrorEvent;
	
	/**
	 * ...
	 * @author Hmin
	 */
	public class  RTMP extends MovieClip
	{
		private var _nc:NetConnection;
		private var _ns:NetStream;
		private var _video:Video;
		
		private var _videoWidth:int;
		private var _videoHeight:int;
		private var _nsPlayName:String = "";
		
		/**
		 * "rtmp://192.168.30.150:1935/live/stream"
		 * 	如果为上面那个样子，那么ncUrl为到live为止，rtmp://192.168.30.150:1935/live
		 * 	nsPlayName为stream，为live后面的东西
		 * 
		 * @param	videoWidth		视频宽度
		 * @param	videoHeight		视频高度
		 * @param	ncUrl			流的url
		 * @param	nsPlayName		流的名字
		 */
		public function RTMP(videoWidth:int,videoHeight:int,ncUrl:String,nsPlayName:String)
		{	
			_videoWidth = videoWidth;
			_videoHeight = videoHeight;
			_nsPlayName = nsPlayName;
			
			_nc = new NetConnection();
			_nc.addEventListener(NetStatusEvent.NET_STATUS, onNetConnectionHandler);
			_nc.connect(ncUrl);
		}
		
		private function onNetConnectionHandler(e:NetStatusEvent):void
		{	
			trace(e.info.code);
			switch (e.info.code)  
            {  	
				
                case "NetConnection.Connect.Success":  
                    doVideo(_nc);  
                    break;  
                case "NetConnection.Connect.Failed":  
                    break;  
                case "NetConnection.Connect.Rejected":  
                    break;  
                case "NetStream.Play.Stop":  
                    break;  
                case "NetStream.Play.StreamNotFound":  
                    break;  
            }  	
		}
		
		public function doVideo(nc:NetConnection):void
		{
			_ns = new NetStream(nc);
			_ns.addEventListener(NetStatusEvent.NET_STATUS, onNetConnectionHandler);
			_ns.addEventListener(AsyncErrorEvent.ASYNC_ERROR,asyncErrorHandler);
			
			_video = new Video(_videoWidth, _videoHeight);
			_video.attachNetStream(_ns);
			_ns.play(_nsPlayName);
			addChild(_video);
		}
		
		private function asyncErrorHandler(e:AsyncErrorEvent):void
		{
			trace("asyncerror");
		}
		
		public function closeRTMP():void
		{
			_ns.dispose();
			_nc.close();
			removeChild(_video);
		}
	}
	
}