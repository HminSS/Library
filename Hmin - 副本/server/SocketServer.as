package Hmin.server
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.ServerSocketConnectEvent;
	import flash.net.ServerSocket;
	import flash.net.Socket;
	import flash.events.ProgressEvent;
	/**
	 * ...
	 * @author ...Hmin
	 * 自己无聊想脱离黄敏所写的一个服务器
	 * Hmm好像也是功能不够强大
	 */
	public class SocketServer extends EventDispatcher 
	{
		private var server:ServerSocket;
		
		public var serverPort:int;
		
		private var socketClientArr:Array = [];
		
		private var clientSocket:Socket;
		
		public function SocketServer(port:int = 2017):void
		{
			server = new ServerSocket();
			serverPort = port;
			server.bind(serverPort);
			server.listen();
			
			server.addEventListener(ServerSocketConnectEvent.CONNECT, onSocketClientConnect);
			server.addEventListener(Event.CLOSE, onSocketClientClose);
		}
		
		/**
		 * 侦听连接上来的socket
		 * @param	e
		 */
		private function onSocketClientConnect(e:ServerSocketConnectEvent):void
		{	
			clientSocket = e.socket;
			socketClientArr.push(e.socket);
			trace("a socket client connected");
			
			clientSocket.addEventListener(ProgressEvent.SOCKET_DATA, onClientSocketHandler);
			clientSocket.addEventListener(Event.CLOSE, onClientSocketClose);
		}
		
		/**
		 * 公开调用的方法，关闭服务端
		 * @param	e
		 */
		public function onSocketClientClose(e:Event = null):void
		{
			server.close();
			server = null;
		}
		
		/**
		 * 收到数据
		 * @param	e
		 */
		private function onClientSocketHandler(e:ProgressEvent):void
		{
			if (e.target.bytesAvailable)
			{
				var str:String = e.target.readUTFBytes(e.target.bytesAvailable);
				trace("接收 : " + str);
			}
		}
		
		/**
		 * 连接上来的socket关闭后
		 * @param	e
		 */
		private function onClientSocketClose(e:Event):void
		{
			if (socketClientArr.length != 0)
			{	
				e.target.removeEventListener(ProgressEvent.SOCKET_DATA, onClientSocketHandler);
				e.target.removeEventListener(Event.CLOSE, onClientSocketClose);
				
				socketClientArr.splice(socketClientArr.indexOf(e.target), 1);
				trace("有客户端断开连接，剩下的客户端 " + socketClientArr.length);
			}
		}
		
		/**
		 * 广播
		 * @param	msg
		 */
		public function boardcastAll(msg:String):void
		{
			if (socketClientArr.length != 0)
			{
				for (var i:int = 0; i < socketClientArr.length; i++)
				{
					if (socketClientArr[i].connected)
					{
						socketClientArr[i].writeUTFBytes(msg);
						socketClientArr[i].flush();
						trace("socket is connect and socket flush  " + msg);
					}
				}
			}
		}
		
		public function get port():void
		{
			return serverPort;
		}
	}
	
}