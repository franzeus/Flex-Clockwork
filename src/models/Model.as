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
		private var now:Date;
		
		private var theTimer:Timer;
		
		public function Model()
		{
			now = new Date();
			
			theTimer = new Timer(1000);
			theTimer.addEventListener(TimerEvent.TIMER, tick);
			theTimer.start();
			
			timeZoneOffset = 1;
		}	
		
		// ----------------------------------------------------
		private function tick(event:TimerEvent):void {
			now = new Date();
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
			return now.getSeconds();
		}

		[Bindable(event="currentTimeChanged")]
		public function get minutes():int {
			return now.getMinutes();
		}

		[Bindable(event="currentTimeChanged")]
		public function get hours():Number	{
			trace(_timeZoneOffset);
			return now.getUTCHours() + timeZoneOffset;
		}

	}
}