package Hmin.display
{
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.geom.Point;
	
	/**
	 * 2017/02/06
	 * @author by Hmin
	 * 此类用于绘制正多边形
	 * Regular有规则
	 * Polygon多边形
	 * 
	 *  例子：
	 *  import Hmin.display.RegularPolygon;
		import flash.events.Event;
		import flash.events.MouseEvent;

		var i:int = 2;
		var shape:RegularPolygon = new RegularPolygon(960,540,250,8,0x0ECDE6,false);
		shape.drawSmallPolygon(5);
		this.addChild(shape);

		btn.addEventListener(MouseEvent.CLICK,onMouseClickHandler);

		function onMouseClickHandler(e:MouseEvent):void
		{	
			shape.clear();
			shape.drawSmallPolygon(5);
			if(i == 10)
			{
				shape.changePoint(1,i/10);
				i = 0;
			}
			else
			{
				shape.changePoint(1,i/10);
				i +=2
			}s
		}
	 * 
	 * 这个东西一开始只是为了绘制正六边形而已
	 * 感觉只要是正的多边形都可以绘制
	 */
	public class RegularPolygon extends MovieClip 
	{
		//圆的半径
		public var _radius:int;
		//圆心x
		public var _cirX:Number;
		//圆心y
		public var _cirY:Number;
		//正多边形的面数
		private var _faceNumber:int;
		//绘制多边形的shape对象
		private var _shape:Shape;
		//是否从圆心连到中点
		private var _isLineToCenter:Boolean;
		//颜色值
		private var _color:uint;
		//存储要画图的点的坐标的数组，点的值可以改变的
		private var _pointArr:Vector.<Point> = new <Point>[];
		//存储要画图的点的坐标的数组，点的值不可以改变
		private var _pointArrClone:Vector.<Point> = new <Point>[];
		
		/**
		 * 
		 * @param	cirX	圆心的x
		 * @param	cirY	圆心的y
		 * @param	radius	圆的半径
		 * @param	faceNumber	所需的正多边形的面数
		 * @param	lineToCirCenter	每个点是否与圆心相连，默认为true
		 */
		public function RegularPolygon(cirX:Number = 100,cirY:Number = 100,radius:int = 100,faceNumber:int = 6,color:uint = 0x0ECDE6,lineToCirCenter:Boolean = true) 
		{
			_cirX = cirX;
			_cirY = cirY;
			_radius = radius;
			_color = color;
			_faceNumber = faceNumber;
			_isLineToCenter = lineToCirCenter;
			
			if (radius == 0 || faceNumber == 0) 
			{	
				trace("半径为0或者面数为0？请检查");
				return;
			}
			
			init();
		}
		
		/**
		 * 初始化
		 */
		private function init():void
		{	
			_shape = new Shape();
			this.addChild(_shape);
				
			for (var i:int = 0; i < _faceNumber; i++)
			{	
				_pointArr.push(new Point(circleX(2 * Math.PI / _faceNumber * i), circleY(2 * Math.PI / _faceNumber * i)))
				_pointArrClone.push(new Point(circleX(2 * Math.PI / _faceNumber * i), circleY(2 * Math.PI / _faceNumber * i)))
			}	
			drawShape();
		}
		
		/**
		 * 这个方法为改变线段的长度
		 * 其实为改变点的缩放值，若缩放值为0，那么其实就是圆心的本身
		 * @param	pointNum	点的索引值，从0开始，不得大于面数
		 * @param	scaleNum	缩放的大小不得大于1
		 */
		public function changePoint(pointNum:int,scaleNum:Number):void
		{	
			if (pointNum > _faceNumber || scaleNum > 1) return;
			
			if (scaleNum == 0)
			{
				_pointArr[pointNum].x = _cirX;
				_pointArr[pointNum].y = _cirY;
			}
			else
			{
				_pointArr[pointNum].x = (_pointArrClone[pointNum].x - _cirX) * scaleNum +_cirX;
				_pointArr[pointNum].y = (_pointArrClone[pointNum].y - _cirY) * scaleNum +_cirY;
			}
			drawShape();
		}
		
		/**
		 * 绘制正多边形
		 */
		public function drawShape():void
		{	
			//_shape.graphics.clear();
			_shape.graphics.beginFill(0xECDE69,.5);
			_shape.graphics.lineStyle(1,_color, 1);
			_shape.graphics.moveTo(_pointArr[0].x, _pointArr[0].y);
		//	_shape.graphics.drawCircle(_cirX, _cirY, _radius);
			for (var i:int = 0; i < _faceNumber; i++)
			{
				if (i == _faceNumber - 1)
				{
					_shape.graphics.lineTo(_pointArr[0].x, _pointArr[0].y);
				}
				else
				{
					_shape.graphics.lineTo(_pointArr[i + 1].x, _pointArr[i + 1].y);
				}
			}
			_shape.graphics.endFill();
			
			if (_isLineToCenter)
			{
				lineToCircleCenter();
			}
		}
		
		/**
		 * 圆心连接各个点的方法
		 */
		public function lineToCircleCenter():void
		{
			for (var i:int = 0; i < _faceNumber; i++)
			{	
				_shape.graphics.moveTo(_cirX, _cirY);
				_shape.graphics.lineTo(_pointArr[i].x,_pointArr[i].y);
			}
		}
		
		/**
		 * 清楚绘制对象
		 */
		public function clear():void
		{
			_shape.graphics.clear();
		}
		
		/**
		 * 删除
		 */
		public function dispose():void
		{
			_shape.graphics.clear();
			this.removeChild(_shape);
			_shape = null;
		}
		
		/**
		 * 填入角度获取点的x值
		 * @param	angle
		 * @return
		 */
		public function circleX(angle:Number):Number
		{	
			return _cirX + Math.cos(angle) * _radius;
		}
		
		/**
		 * 填入角度获取点的y值
		 * @param	angle
		 * @return
		 */
		public function circleY(angle:Number):Number
		{	
			return _cirY + Math.sin(angle) * _radius;
		}
		
		public function pointPos(index:int):Point
		{	
			return _pointArrClone[index];
		}
		
		public function changePointPos(index:int):Point
		{	
			return _pointArr[index];
		}
		
		/**
		 * 以linePointNum为值，将多边形的每一条边等分为linePointNum
		 * 再把点连接起来
		 * 
		 * @param	linePointNum
		 */
		public function drawSmallPolygon(linePointNum:int,color:uint = 0xFF0000):void
		{
			if (linePointNum == 0) return;
			
			_shape.graphics.lineStyle(1, color, 1);
			_shape.graphics.beginFill(color,1);
			
			for (var k:int = 0; k < linePointNum + 1; k++)
			{
				for (var i:int = 0; i < _faceNumber; i++)
				{	
					if (i == _faceNumber -1)
					{
						_shape.graphics.moveTo((_pointArrClone[i].x - _cirX) * k/linePointNum +_cirX,(_pointArrClone[i].y - _cirY) * k/linePointNum +_cirY);
						_shape.graphics.lineTo((_pointArrClone[0].x - _cirX) * k/linePointNum +_cirX,(_pointArrClone[0].y - _cirY) * k/linePointNum +_cirY);
					}
					else
					{
						_shape.graphics.moveTo((_pointArrClone[i].x - _cirX) * k/linePointNum +_cirX,(_pointArrClone[i].y - _cirY) * k/linePointNum +_cirY);
						_shape.graphics.lineTo((_pointArrClone[i+1].x - _cirX) * k/linePointNum +_cirX,(_pointArrClone[i+1].y - _cirY) * k/linePointNum +_cirY);
					}
				}
			}		
			_shape.graphics.endFill();
		}
	}	
}
