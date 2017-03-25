package Hmin.display
{
	import flash.display.Sprite;
	import flash.geom.Point;
	
	/**
	 *	饼图 
	 * @author Administrator
	 * 
	 * @Example
	 * <listing version="1.0">
	 * var pie:PieChart = new PieChart();
			pie.x = pie.y = 100;
			this.addChild(pie);
			
			pie.setRadius(100, 0);
			
			var angle:Array = [20, 80, 75, 120, 65];
			var color:Array = [0xFF0000, 0x00FF00, 0x0000FF, 0xF0F0F0, 0x0FFF0F];
			
			var sAngle:Number = 0;
			var eAngle:Number = angle[0];
			
			//pie.startDrawPie(0, 45, color[0]);
			
			for(var i:int = 0; i < 5; i ++)
			{
				trace(sAngle, eAngle);
				pie.startDrawPie(sAngle, eAngle, color[i]);
				
				sAngle += angle[i];
				eAngle += angle[i + 1];
			}
	 * </listing>
	 */	
	public class PieChart extends Sprite
	{
		private var _od:Number = 100;
		private var _id:Number = 0;
		
		public function PieChart()
		{
			super();
		}
		
		/**
		 *	 设置饼图外径或内径
		 * @param OD	OD:outer diameter	外径
		 * @param ID	ID:inside diameter	内径
		 */		
		public function setRadius(OD:Number, ID:Number = 0):void
		{
			this._od = OD;
			this._id = ID;
			
			_startPoint.x = _id;
		}
		
		
		private var _startPoint:Point = new Point();
		
		public function clear():void
		{
			this.graphics.clear();
		}

		/**
		 *	 开始绘饼
		 * @param startAngle	开始角度值
		 * @param endAngle		结束角度值
		 * @param color			颜色
		 */
		public function startDrawPie(startDegrees:Number, endDegrees:Number, color:uint):void
		{
			//角度转弧度
			var startRadians:Number = startDegrees * Math.PI / 180;
			var endRadians:Number = endDegrees * Math.PI / 180;
			
			//this.graphics.clear();
			this.graphics.beginFill(color);
			this.graphics.lineStyle(.1, color);
			this.graphics.moveTo(_startPoint.x, _startPoint.y);
			
			trace(startDegrees, endDegrees);
			//绘外径弧形
			for(var i:Number = startRadians; i <= endRadians; i += 0.01)
			{
				this.graphics.lineTo(Math.cos(i) * _od, Math.sin(i) * _od);
			}
			
			if(_id != 0)
			{
				_startPoint.x = Math.cos(i) * _id;
				_startPoint.y = Math.sin(i) * _id;
				
				//绘内径弧形
				for(i = endRadians; i >= startRadians; i -= 0.1)
				{
					this.graphics.lineTo(Math.cos(i) * _id, Math.sin(i) * _id);
				}
			}
			else
			{
				this.graphics.lineTo(_startPoint.x, _startPoint.y);
			}
			
			this.graphics.endFill();
		}
	}
}