package
{
	import flash.events.EventDispatcher;
	
	/**
	 * ...
	 * @author 
	 */
	public class QuestionSingle extends EventDispatcher
	{
		/**单例*/
		private static var instance:QuestionSingle = new QuestionSingle();
		
		/**抽象模型*/
		protected var _params:Object = new Object;
		
		protected var _xml:XML;
		
		public function QuestionSingle():void
		{
			if (instance)
			{
				throw new Error("Single.getInstance()获取实例");
			}
		}
		
		/***/
		public static function getInstance():QuestionSingle
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
		 * 返回主页
		 */
		public function home():void
		{
			if (_params.hasOwnProperty("home"))
				_params.home();
		}
		
		public function setConfig(xml:XML):void
		{
			xml = _xml;
		}
		
		public function get config():XML
		{
			return _xml;
		}
	}
	
}