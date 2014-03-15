package core.broadcasting 
{
	import flash.events.EventDispatcher;

	public class EventBroadcaster extends EventDispatcher
	{
		public var scope:String
		
		public function EventBroadcaster(scope:String) 
		{
			this.scope = scope;
			
		}
		
	}

}