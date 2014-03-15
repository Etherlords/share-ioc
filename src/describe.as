package  
{
	import core.broadcasting.BroadcastingManager;
	import flash.events.Event;
	
	public function describe(scope:String, type:String, handler:Function):void
	{
		BroadcastingManager.instance.addListener(scope, type, handler);
	}
}