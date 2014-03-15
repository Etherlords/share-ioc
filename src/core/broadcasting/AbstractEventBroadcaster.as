package core.broadcasting 
{
	import flash.events.Event;

	public class AbstractEventBroadcaster implements IEventBroadcaster
	{
		public var scope:String;
		
		private var broadcastManager:BroadcastingManager = BroadcastingManager.instance;
		
		public function AbstractEventBroadcaster() 
		{
			
		}
		
		public function broadcast(event:Event):void
		{
			broadcastManager.dispatch(scope, event);
		}
	}

}