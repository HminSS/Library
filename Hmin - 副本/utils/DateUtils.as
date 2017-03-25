package Hmin.utils
{
	public final class DateUtils
	{
		/** 星期缩写 */
		public static const DAY_SHORT_ARR:Array = ["Mon", "Tues", "Wed", "Thur", "Fri", "Sat", "Sun"];
		/** 星期全称 */
		public static const DAY_LONG_ARR:Array = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"];
		
		/** 月份缩写 */
		public static const MONTH_SHORT_ARR:Array = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
		/** 月份全称 */
		public static const MONTH_LONG_ARR:Array = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];
		
		/**
		 * 当前系统时间,格式[年年年年月月日日时时分分秒秒毫秒毫秒毫秒],17位定长,不足位补0
		 */
		public static function get now():String
		{
			var date:Date = new Date();
			var s:String = String(date.fullYear);
			var m:uint = date.month;
			var d:uint = date.date;
			
			s += m < 9 ? "0"+(m+1) : (m+1);
			s += d < 10 ? "0"+d : d;
			
			var hour:uint = date.hours;
			var minu:uint = date.minutes;
			var sec:uint = date.seconds;
			var ms:uint = date.milliseconds;
			
			s += hour < 10 ? "0"+hour : hour;
			s += minu < 10 ? "0"+minu : minu;
			s += sec < 10 ? "0"+sec : sec;
			s += ms < 100 ? (ms < 10 ? "00"+ms : "0"+ms) : ms;
			
			return s;
		}
		
		/**
		 * 计算两个时间之间的毫秒差.格式[年年年年月月日日时时分分秒秒毫秒毫秒毫秒],17位定长,不足位报错
		 * @param s 开始时间
		 * @param e 结束时间
		 * 
		 * @return 返回NaN时,表示输入的时间格式不对
		 */
		public static function caculatDuration(s:String, e:String):Number
		{
			if(s.length != 17 || e.length != 17)
			{
				throw new Error("DateUtils.caculatDuration()::: 时间格式错误");
				
				return NaN;
			}
			
			var timeStart:Date = new Date(s.substr(0, 4), s.substr(4, 2), s.substr(6, 2), s.substr(8, 2), s.substr(10, 2), s.substr(12, 2), s.substr(14, 3));
			var timeEnd:Date   = new Date(e.substr(0, 4), e.substr(4, 2), e.substr(6, 2), e.substr(8, 2), e.substr(10, 2), e.substr(12, 2), e.substr(14, 3));
			
			return timeEnd.getTime() - timeStart.getTime();
		}
		
		/**
		 * 计算字符串时间的毫秒.格式[年年年年月月日日时时分分秒秒毫秒毫秒毫秒],17位定长,不足位报错
		 * @return 返回NaN时,表示输入的时间格式不对
		 */
		public static function getTime(s:String):Number
		{
			if(s.length != 17)
			{
				throw new Error("DateUtils.caculatDuration()::: 时间格式错误");
				
				return NaN;
			}
			
			var date:Date = new Date(s.substr(0, 4), s.substr(4, 2), s.substr(6, 2), s.substr(8, 2), s.substr(10, 2), s.substr(12, 2), s.substr(14, 3));
			
			return date.getTime();
		}
	}
}