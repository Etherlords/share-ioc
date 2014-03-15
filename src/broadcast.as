package  
{
	import core.broadcasting.BroadcastingManager;
	import flash.events.Event;
	
	public function broadcast(scope:String, e:Event):void
	{
		BroadcastingManager.instance.dispatch(scope, e);
	}
}