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
		private var _timeZoneOffset:int;
		
		private var theTimer:Timer;
		
		private var currentTime:Date;
		private var currentUTCTime:Date;
		
		public function Model()
		{
			// ** Init Time ** //
			currentUTCTime = new Date();
			_hours 	 = currentUTCTime.getHours();
			_minutes = currentUTCTime.getMinutes();
			_seconds = currentUTCTime.getSeconds();
			
			theTimer = new Timer(1000);
			theTimer.addEventListener(TimerEvent.TIMER, tick);
			theTimer.start();
		}	
		
		// ----------------------------------------------------
		private function tick(event:TimerEvent):void {				
			currentUTCTime = new Date();
			//currentUTCTime.setTime(currentTime.getTime() + currentTime.getTimezoneOffset() * 60 * 1000);
			currentUTCTime.setTime(currentUTCTime.getTime() + timeZoneOffset * 60 * 60 * 1000);
			//
			_hours 	 = currentUTCTime.getHours();
			_minutes = currentUTCTime.getMinutes();
			_seconds = currentUTCTime.getSeconds();

			trace("T:" + timeZoneOffset);
			dispatchEvent(new Event("currentTimeChanged"));
		}
		
		// ----------------------------------------------------
		// Getter & Setter
		public function set timeZoneOffset(value:int):void	{			
			if(value == _timeZoneOffset)
				return;
			
			_timeZoneOffset = value;
			dispatchEvent(new Event("currentUTCChanged"));
		}
		
		[Bindable(event="currentUTCChanged")]
		public function get timeZoneOffset():int {
			return _timeZoneOffset;
		}

		[Bindable(event="currentTimeChanged")]
		public function get seconds():Number {
			return _seconds;
		}

		[Bindable(event="currentTimeChanged")]
		public function get minutes():int {
			return _minutes;
		}

		[Bindable(event="currentTimeChanged")]
		public function get hours():Number	{
			return _hours;
		}

	}
}