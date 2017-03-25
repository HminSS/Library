package Hmin.openProcess
{
	import flash.utils.ByteArray;
	import flash.desktop.NativeProcess;
	import flash.desktop.NativeProcessStartupInfo;
	import flash.filesystem.File;
	
	/**
	 * 此类用cmd命令打开一切可以打开的进程
	 * 注意：此类智能用于AIR
	 * @author Hmin
	 * 2016/01/31
	 */
	public class HminCMD 
	{
		private var _file:File;
		private var _bytes:ByteArray;
		private var _np:NativeProcess;
		private var _processInfo:NativeProcessStartupInfo;
		
		public function HminCMD()
		{
			_file = new File("C:/Windows/System32/cmd.exe");
			_bytes = new ByteArray();
			_np = new NativeProcess();
			_processInfo = new NativeProcessStartupInfo();
			
			_processInfo.executable = _file;
			_np.start(_processInfo);
		}
		
		/**
		 * @param	url 需要打开的路径
		 * 注意：里面的"\"要变成"/"这种反斜杠
		 */
		public function startProcess(url:String):void
		{	
			_bytes.clear();
			
			_bytes.writeMultiByte(url + "\n", "gb2312");
			_np.standardInput.writeBytes(_bytes);	
		}
		
		/**
		 * processName为进程的名字，如果不确定，请打开任务管理器去查看
		 * 注：wps和ppt的进程名字是不一样的
		 * @param	processName
		 */
		public function exitProcess(processName:String):void
		{	
			_bytes.clear();
			_bytes.writeMultiByte("taskkill /f /t /im " + processName,"gb2312");
			_np.standardInput.writeBytes(_bytes);	
		}
	}
	
}