package Hmin.single
{
	import flash.display.IBitmapDrawable;
	import flash.events.EventDispatcher;
	
	/**
	 * ...
	 * @author ...CatmimiGod
	 */
	public class mySingle extends EventDispatcher
	{
		/**单例*/
		private static var instance:mySingle = new mySingle();
		
		/**抽象模型*/
		protected var _params:Object = new Object;
		
		public function mySingle():void
		{
			if (instance)
			{
				throw new Error("Single.getInstance()获取实例");
			}
		}
		
		/***/
		public static function getInstance():mySingle
		{
			return instance;
		}
		
		/**
		 * 设置模型焦点
		 * @param	params
		 */
		public function setParams(params:Object):void
		{
			_params = params;
		}
		
		/**
		 * 播放索引
		 * @param	index
		 */
		public function playIndex(index:int):void
		{
			if (_params.hasOwnProperty("playIndex"))
				_params.playIndex(index);
		}
		
		/**
		 * 播放当前索引的视频
		 * @param	index
		 */
		public function playSwfVideo(index:int):void
		{
			if (_params.hasOwnProperty("playSwfVideo"))
				_params.playSwfVideo(index);
		}
		
		/**
		 * 清除SWF播放的视频
		 */
		public function clearSwfVideo():void
		{
			if (_params.hasOwnProperty("clearSwfVideo"))
				_params.clearSwfVideo();
		}
		
		/**
		 * 返回主页
		 */
		public function home():void
		{
			if (_params.hasOwnProperty("home"))
				_params.home();
		}
		
		/**
		 * 绘画video背景
		 * @param	source
		 */
		public function drawVideoBackGround(source:IBitmapDrawable):void
		{
			if (_params.hasOwnProperty("drawVideoBackGround"))
				_params.drawVideoBackGround(source);
		}
	}
	
}