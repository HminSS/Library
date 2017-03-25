package Hmin.single
{
	/**
	 * ...为了应付hcc而存在的
	 * @author Print
	 */
	public class Singleton 
	{
		private static var instance:Singleton = new Singleton();
		
		protected var _params:Object = new Object;
		
		public static var auto:Boolean = false;
		
		private var _xml:XML;
		
		public function Singleton():void
		{
			if (instance)
				throw new Error("只能用getInstance()来获取实例");
		}
		
		public static function getInstance():Singleton
		{
			return instance;
		}
		
		public function setParams(obj:Object):void
		{
			_params = obj;
		}
		
		public function set config(xml:XML):void
		{
			_xml = xml;
		}
		
		public function get config():XML
		{
			return _xml;
		}
		
		public function sendMsg(msg:String):void
		{
			if (_params.hasOwnProperty("sendMsg"))
				_params.sendMsg(msg);
		}
		
		public function addSwf(index:int):void
		{
			if (_params.hasOwnProperty("addSwf"))
				_params.addSwf(index);
		}
		
		public function home():void
		{
			if (_params.hasOwnProperty("home"))
				_params.home();
				
			trace("home");
		}
		
		public function get stageScale():Number
		{
			return Number(_xml.stageScale);
		}
	}
	
}