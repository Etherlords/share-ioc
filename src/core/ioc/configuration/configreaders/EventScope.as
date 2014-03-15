package core.ioc.configuration.configreaders 
{
	import core.broadcasting.BroadcastingManager;
	import core.broadcasting.EventBroadcaster;
	
	public class EventScope implements IConfigReader 
	{
		private static var IDENT:String = "eventScope";
		private static var SCOPE:String = "scopeName";
		
		private var config:XML;
		
		public function EventScope() 
		{
			
		}
		
		public function get ident():String 
		{
			return IDENT;
		}
		
		public function read(config:XML):void 
		{
			this.config = config;
			parse();
		}
		
		private function parse():void
		{
			var scopeName:String = config.@[SCOPE];
			
			var eventBroadcaster:EventBroadcaster = new EventBroadcaster(scopeName);
			
			BroadcastingManager.instance.registerScope(eventBroadcaster);
		}
		
		public function handleProperties():void 
		{
			
		}
		
		public function invorkMethods():void 
		{
			
		}
		
		
	}

}