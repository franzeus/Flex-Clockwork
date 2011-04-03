package models
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	public class Model extends EventDispatcher
	{
		private var _hours:Number;
		private var _minutes:Number;
		private var _seconds:Number;
		private var _timeZoneOffset:int = 0;
		
		private var theTimer:Timer;
		private var currentTime:Date;
		
		public function Model()
		{
			// ** Init Time ** //
			currentTime = new Date();
			_hours 	 = currentTime.getHours();
			_minutes = currentTime.getMinutes();
			_seconds = currentTime.getSeconds();
						
			
			theTimer = new Timer(1000);
			theTimer.addEventListener(TimerEvent.TIMER, tick);
			theTimer.start();
		}	
		
		// ----------------------------------------------------
		private function tick(event:TimerEvent):void {

			currentTime = new Date();

			var offsetInHours:Number = timeZoneOffset * 60;
			currentTime.setTime(currentTime.getTime() + offsetInHours * 60 * 1000);

			_hours 	 = currentTime.getHours();
			_minutes = currentTime.getMinutes();
			_seconds = currentTime.getSeconds();

			trace("T:" + timeZoneOffset);
			dispatchEvent(new Event("currentTimeChanged"));
		}
		
		// ----------------------------------------------------
		// Getter & Setter
		public function set timeZoneOffset(value:int):void	{			
			if(value == _timeZoneOffset)
				return;

			_timeZoneOffset = value;
			//dispatchEvent(new Event("currentUTCChanged"));
		}
				
		//[Bindable(event="currentUTCChanged")]
		public function get timeZoneOffset():int {
			return _timeZoneOffset;
		}

		[Bindable(event="currentTimeChanged")]
		public function get seconds():String {		
			return prependCero(_seconds);
		}

		[Bindable(event="currentTimeChanged")]
		public function get minutes():String {
			return prependCero(_minutes);
		}

		[Bindable(event="currentTimeChanged")]
		public function get hours():String	{
			return prependCero(_hours);
		}
		
		// ----------------------------------------------------
		
		private function prependCero(number:Number):String {
			var ceroAddedString:String = number < 10 ? "0" + String(number) : String(number);
			return ceroAddedString;
		}
	}
}