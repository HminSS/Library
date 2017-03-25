package Hmin.print
{
	import flash.display.Sprite;
	import flash.printing.PaperSize;
	import flash.printing.PrintJob;
	import flash.printing.PrintJobOptions;
	import flash.printing.PrintJobOrientation;
	import flash.printing.PrintUIOptions;
	
	/**
	 *	打印中心
	 *	@author Huangmin
	 *	@date	2013-6-14
	 * 	@playerversion AIR 2
	 */
	public class PrientCenter
	{
		public static var QWIDTH:Number = 420;
		public static var QHEIGHT:Number = 297;
		
		public static var HWIDTH:Number = 1920;
		public static var HHEIGHT:Number = 1080;
		
		/**
		 *	打印中心 
		 * 	
		 * 	@param job:Sprite 需要打印的作业.
		 * 	@param paperSize:String 打印作业纸张大小.
		 * 	@param pixelsPerInch:Number	指定位图使用的分辨率，以每英寸像素为单位.
		 * 	@param orientation:String	打印方向.
		 * 	
		 * 	@return 打印机接收打印返回true,否则返回false;
		 */
		public static function printer(job01:Sprite, job02:Sprite = null, paperSize:String = PaperSize.A4, pixelsPerInch:Number = 300, orientation:String = PrintJobOrientation.LANDSCAPE):Boolean
		{
			var isPrintSuccess:Boolean = false;
			
			/**
			 * @internal
			 * 如果系统支持打印,并且当前打印作业处于非活动状态.
			 */
			if(PrintJob.isSupported && !PrintJob.active)
			{
				var printJob:PrintJob = new PrintJob();
				//printJob.selectPaperSize(paperSize);					//纸张大小
				printJob.orientation = orientation;						//打印方向
				printJob.jobName = "Electronic Signatures";
				
				trace("printing info:=================================")
				trace("打印机最大分辨率:", printJob.maxPixelsPerInch);
				trace("打印机介质的范围:", printJob.paperArea);
				trace("介质的可打印区域的范围:", printJob.printableArea);
				
				var jobOptions:PrintJobOptions = new PrintJobOptions(true);
				//jobOptions.pixelsPerInch = pixelsPerInch;				//打印分辨率 像素/英寸
				
				var uiOptions:PrintUIOptions = new PrintUIOptions();
				uiOptions.disablePageRange = true;
				
				if(printJob.start2(uiOptions, false))
				{
					try
					{
						job01.width = QWIDTH;
						job01.height = QHEIGHT;
						
						trace(QWIDTH, QHEIGHT);
						
						//printJob.pageHeight;  
						//printJob.pageWidth;  

						printJob.addPage(job01, null, jobOptions);
						isPrintSuccess = true;
						
						job01.width = HWIDTH;
						job01.height = HHEIGHT;
						
						trace(HWIDTH, HHEIGHT);
					}
					catch(e:Error)
					{
						isPrintSuccess = false;
					}
					
					if(job02 != null)
					{
						try
						{
							job02.width = 599;
							job02.height = 490;
							
							printJob.addPage(job02, null, jobOptions);
							isPrintSuccess = true;
						}
						catch(e:Error)
						{
							isPrintSuccess = false;
						}
					}
					
					
					/**
					 * @internal
					 * 如果添加打印作业成功,则发送打印,否则终止打印.
					 */
					if(isPrintSuccess)
					{
						printJob.send();
						isPrintSuccess = true;
					}
					else
					{
						printJob.terminate();
					}
				}
				else
				{
					printJob.terminate();
				}
			}
			
			return isPrintSuccess;
		}
	}
}