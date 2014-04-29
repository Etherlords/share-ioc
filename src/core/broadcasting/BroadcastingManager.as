package core.broadcasting 
{
	import core.collections.SimpleMap;
	import flash.events.Event;

	public class BroadcastingManager 
	{
		private static var _instance:BroadcastingManager;
		
		static public function get instance():BroadcastingManager 
		{
			if (!_instance)
				_instance = new BroadcastingManager();
			
			return _instance;
		}
		
		private var broadcasters:SimpleMap = new SimpleMap();
		
		public function BroadcastingManager() 
		{
			
		}
		
		public function addListener(scope:String, type:String, handler:Function):void
		{
			broadcasters.getItem(scope).addEventListener(type, handler);
		}
		
		public function registerScope(broadcaster:EventBroadcaster):void
		{
			trace("Info: register broadcaster scope", broadcaster.scope);
			broadcasters.addItem(broadcaster.scope, broadcaster);
		}
		
		public function dispatch(scope:String, event:Event):void
		{
			trace("Info: broadcast event scope =", scope, "type =", event.type);
			broadcasters.getItem(scope).dispatchEvent(event);
		}
		
		
		
	}

}