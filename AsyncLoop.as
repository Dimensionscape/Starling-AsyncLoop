﻿package {
	import starling.events.EventDispatcher;
	import starling.core.Starling;
	import starling.animation.DelayedCall;
	import flash.utils.getTimer;
	import starling.events.Event;



	public class AsyncLoop extends EventDispatcher {
		private var _loopFunction: Function;
		private var _length: int;
		private var _passIndex: Boolean;
		private var _maxScriptTime:int;
		private var _args: Array;
		private var _startIndex:int;
		public function AsyncLoop(loopFunction: Function, length: int, passIndex: Boolean = false, maxScriptTime:int = 16, args: Array = null, startIndex:int = 0) {
			super();
			_loopFunction = loopFunction;
			_length = length;
			_passIndex = passIndex;
			_maxScriptTime = maxScriptTime;
			_args = args;
			_startIndex = startIndex;

		}

		public function start(): void {
			_runLoop(_loopFunction, _length, _maxScriptTime, _passIndex, _args, _startIndex);			
		}
				
		public function _runLoop(loopFunction: Function, length: int, maxScriptTime: int, passIndex: Boolean, args: Array, lastIndex: int) {
			var startTime: int = getTimer();
			var data:Object;
			for (var i: int = lastIndex; i < length; i++) {
				var delta: int = getTimer() - startTime;
				if (delta > maxScriptTime) {	
					Starling.juggler.delayCall(_runLoop, .001, loopFunction, length, maxScriptTime, passIndex, args, i);					
					return;
				} else {
					if (passIndex) {
						if (args == null) args = [i];
						else if(i==0) args.unshift(i);
						else args[0] = i;
					}
					data = loopFunction.apply(this, args);
					if(data!=null){ 
						break;
					}
				}
			}			
			this.dispatchEventWith(Event.COMPLETE,false, data);			
		}

	}

}