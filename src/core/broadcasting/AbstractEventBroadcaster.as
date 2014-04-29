package core.broadcasting 
{
	import flash.events.Event;

	public class AbstractEventBroadcaster implements IEventBroadcaster
	{
		private var _scopes:Vector.<String> = new Vector.<String>
		
		private var broadcastManager:BroadcastingManager = BroadcastingManager.instance;
		
		public function AbstractEventBroadcaster() 
		{
			
		}
		
		public function broadcastFor(scope:String, event:Event):void
		{
			broadcastManager.dispatch(scope, event);
		}
		
		public function broadcast(event:Event):void
		{
			for (var i:int = 0; i < _scopes.length; i++)
			{
				broadcastManager.dispatch(_scopes[i], event);
			}
		}
		
		public function addScope(scope:String):void
		{
			_scopes.push(scope);
		}
		
		public function get scopes():Vector.<String> 
		{
			return _scopes;
		}
		
		public function set scopes(value:Vector.<String>):void 
		{
			_scopes = value;
		}
	}

}