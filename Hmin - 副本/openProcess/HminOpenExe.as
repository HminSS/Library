package Hmin.openProcess
{
	import flash.filesystem.File;
	import flash.utils.setTimeout;
	import flash.desktop.NativeProcess;
	import flash.desktop.NativeProcessStartupInfo;
	/**
	 * 此类主要用于打开网页
	 * 所需的参数只要两个
	 * 一个是浏览器的路径
	 * 一个是所需打开的网页
	 * @author ...
	 */
	public class HminOpenExe extends NativeProcess
	{	
		private var _url:String = "";
		private var _file:File;
		private var _np:NativeProcess;
		private var _processInfo:NativeProcessStartupInfo;
		
		/**
		 * @param	url 路径
		 * 包括后缀名exe
		 */
		public function HminOpenExe(url:String)
		{
			_url = File.applicationDirectory.nativePath;
			_file = new File(_url + "/" + url);
			_np = new NativeProcess();
			_processInfo = new NativeProcessStartupInfo();
			
			_processInfo.executable = _file;
		}
		
		/**
		 * @param	webUrl 网页的地址
		 */
		public function pullProcessInfo(webUrl:String):void
		{
			_processInfo.arguments = new <String>[webUrl];
		}
		
		/**
		 * @param	index 延迟打开的时间
		 * 此延迟时间主要是为了
		 * 若 此进程已经打开了
		 * 那么 当前进程将关闭 
		 */
		public function openExe(index:int = 0):void
		{
			if (_np.running)
			{
				_np.exit();
				
				setTimeout(Open, index);
			}
			else
			{	
				Open();
			}
			trace(_processInfo.arguments);
		}
		
		public function Open():void
		{
			_np.start(_processInfo);
		}
		
		public function exitProcess():void
		{
			_np.exit();
		}
	}
}