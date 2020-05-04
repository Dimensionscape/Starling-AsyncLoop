package  {
	
	import flash.display.MovieClip;
	import starling.events.Event;
	import starling.display.Sprite;
	import starling.core.Starling;
	
	public class Main extends MovieClip {
		private var _starlingRoot:Sprite;
		
		public var asyncLoop:AsyncLoop;
		public function Main() {
			new Starling(Sprite, this.stage);
			Starling.current.showStats = true;
			Starling.current.start();
			Starling.current.addEventListener(Event.ROOT_CREATED, _onInit);			
		}
		
		private function _onInit(e:Event):void{
			_starlingRoot = Starling.current.root as Sprite;
			function loopFunction(i, a, b, c){
				//example logic
				trace(i, a, b, c);
				for(var j:int = 0; j<100; j++){
					var _x:int = 10*10*10*10*10;
				}
				if(i == 50000) return i;
			}
			asyncLoop = new AsyncLoop(loopFunction,100000,true, 16, ["a","b","c"]);
			asyncLoop.addEventListener(Event.COMPLETE, _onLoopComplete);
			asyncLoop.start();
		}
		
		private function _onLoopComplete(e:Event):void{
			trace("Loop Complete", e.data);
			asyncLoop.removeEventListener(Event.COMPLETE, _onLoopComplete);
		}
	}
	
}
