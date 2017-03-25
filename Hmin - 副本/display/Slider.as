package Hmin.display
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	/**
	 * 前言：
	 * 
	 * 为了可持续发展而存在的看起来没什么乱用的类
	 * 以后要做拉动的时候可以省略很多事件
	 * 注：拉动条以及拉动条的背景的位置要放中间，别以左上角为准
	 * 注：传过来的刻度必须为number类型的vector
	 * 注：当松开鼠标即mouseUP时，会派遣一个自定义事件
	 * 事件为“change”事件
	 * 
	 * 默认横着拖动，没什么事别多手
	 * 如需竖着，那么请把direction属性改成"vertical"
	 * 一定要是这个 一定要是这个 一定要是这个   除了这个string之外，其他的全部都是横着的，千万别输错
	 * 
	 * 竖着拉动的时候数字都是负数，这个请切记，最下面为最大值即为0，然后慢慢的负上来
	 * 设置的posArray也是一样；
	 *
	 * @author ... 
	 * Hmin 版本v1.0			缺少遍历
	 * Hmin 版本v2.0			缺少竖着拖动的方式
	 * Hmin 版本v3.0			缺少可以跟随的效果
	 */
	public class Slider extends MovieClip 
	{	
		//拖动条
		private var circle:MovieClip = new MovieClip;
		
		//拖动的区域方位的mc
		private var touchArea:MovieClip = new MovieClip;
		
		//自动吸附的范围
		private var _posArray:Vector.<Number> = new <Number>[0];
		
		//默认的拖动方向为横向，当然你可以改变他
		private var _direction:String = "transverse";
		
		public function Slider()
		{		
			if (stage)
			{
				reset();
			}
			else
			{
				this.addEventListener(Event.ADDED_TO_STAGE, reset);
			}
		}
		
		/**
		 * point是什么鬼？point就是你的拉动条，请给他设置个名字叫point
		 * mc是什么鬼？mc就是point的拖动范围的大小，随便画个东西就行
		 * @param	e
		 */
		private function reset(e:Event = null):void
		{
			if (this.hasOwnProperty("point") && this.hasOwnProperty("mc"))
			{
				circle = this["point"];
				touchArea = this["mc"];
				
				initMC();
			}
			else
			{
				trace("这个movieclip里面没有名称为point以及mc的东西，请仔细检查");
			}
		}
		
		//初始化
		public function initMC():void
		{
			circle.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDownHandler);
			
			//初始化拉动条的位置，目的是和拉动区域同高
			circle.y = touchArea.y;
		}
		
		//mousedown事件
		private function onMouseDownHandler(e:MouseEvent):void
		{	
			//这里是设计的横着拖动的，如果你需要竖着的，那么你要修改这里的拖动矩形的范围
			//下面的吸附功能都要改，把x变成y就好
			if (_direction == "vertical")
			{
				e.target.startDrag(false, new Rectangle(touchArea.x, touchArea.y, 0, -touchArea.height));
				trace("竖的拖动了！！！！");
			}
			else
			{
				e.target.startDrag(false, new Rectangle(touchArea.x, touchArea.y, touchArea.width, 0));
				trace("横的拖动了！！！！");
			}
			stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUpHandler);
		}
		
		//mouseup事件
		private function onMouseUpHandler(e:MouseEvent):void
		{	
			stage.removeEventListener(MouseEvent.MOUSE_UP, onMouseUpHandler);
			circle.stopDrag();
			
			updataLocation();
			this.dispatchEvent(new Event("change"));
		}
		
		//自动吸附功能
		//如需此功能，只需要设置posArray值既可以
		private function updataLocation():void
		{	
			if (_posArray.length > 1)
			{	//竖着拖动的
				if (_direction == "vertical")
				{
					for (var i:int = _posArray.length; i > 0; i--)
					{
						if (circle.y <= _posArray[_posArray.length - 1] + (_posArray[_posArray.length - 1] - _posArray[_posArray.length - 2]) / 2)
						{
							circle.y = _posArray[_posArray.length - 1];
							break;
						}
						else if (circle.y > (_posArray[1] - _posArray[0]) / 2 + _posArray[0])
						{
							circle.y = _posArray[0];
							break;
						}
						if (circle.y <= _posArray[i - 2] + (_posArray[i - 1] - _posArray[i - 2]) / 2)
						{
							circle.y = _posArray[i - 1];
							break;
						}
						else
						{
							trace("竖的继续遍历中");
						}
						
					}
					
				}
				else
				{	
					//横着拖动的
					//头和尾，然后就是中间的了
					for (var i:int = _posArray.length; i > 0; i--)
					{
						if (circle.x > _posArray[_posArray.length - 1] + (_posArray[_posArray.length - 1] - _posArray[_posArray.length - 2]) / 2)
						{
							circle.x = _posArray[_posArray.length - 1];
							break;
						}
						else if (circle.x < (_posArray[1] - _posArray[0]) / 2 + _posArray[0])
						{
							circle.x = _posArray[0];
							break;
						}
						if (circle.x >= _posArray[i - 2] + (_posArray[i - 1] - _posArray[i - 2]) / 2)
						{
							circle.x = _posArray[i - 1];
							break;
						}
						else
						{
							trace("横的继续遍历中");
						}
						
					}
				}
			}
		}
		
		/**
		 * 设置他的刻度值
		 * 一般为 两个范围数相减/2+上最小的那个数，如果小于此值，那么就归前者，大于或等于归后者
		 * 这里面最好别有负数，有负数估计会出错
		 * 例子如下：
		 * var i:Vector.<Number> = new <Number>[0,100,200,300,400,500];
		 * this.posArray = i;
		 * 
		 * 如果是这样，那么他的区间分布实际为 0-49归 0 50-149 归100 等等等等。。。。  这是横的
		 * 
		 * 
		 * 如果是竖的一般都是越上数值越负，例如
		 * var i:Vector.<Number> = new <Number>[0,-100,-200,-300,-400,-500];
		 * this.posArray = i;
		 * this.direction = "vertical"; 		这行很重要
		 * 如果没有上面那一行，而且输入的不是vertical这个单词的话，此脚本只会当做你是横着拖动的
		 * 缺一不可
		 * 
		 */
		public function set posArray(arr:Vector.<Number>):void
		{
			_posArray = arr;
		}
		
		/**
		 * 获取他的刻度
		 * 一般都是你设置过来的刻度范围
		 */
		public function get posArray():Vector.<Number>
		{
			return _posArray;
		}
		
		/**
		 * 获取拉动条当前的位置
		 */
		public function get pos():Number
		{
			if (_direction == "vertical")
				return circle.y;
			else
				return circle.x;
		}
		
		/**
		 * 返回一个百分比的值
		 * 公式为 现在拉动条的位置/拖动区域的总长
		 */
		public function get posPercent():Number
		{	
			if (_direction == "vertical")
				return circle.y / touchArea.height;
			else
				return circle.x / touchArea.width;
		}
		
		/**
		 * 设置是横着拖动还是竖着拖动
		 * 默认是横着拖动的
		 * 如果需求是横着拖动那么你不用理会这里
		 * 如果是竖着拖动的，那么拜托，请设置direction这个属性为"vertical"
		 */
		public function set direction(dir:String):void
		{
			if (dir == "vertical")
				_direction = dir;
			else
				_direction = "transverse";
		}
		
		/**
		 * 返回拖动的方向
		 * 横着或者竖着，就是那么自信
		 */
		public function get direction():String
		{
			return _direction;
		}
		
		/**
		 * 返回当前所在的数组索引值
		 */
		public function get arrPos():int
		{	
			if (_direction == "vertical")
				return _posArray.indexOf(circle.y);
			else
				return _posArray.indexOf(circle.x);
		}
	}
	
}