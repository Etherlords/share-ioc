package core.ioc.configuration.configreaders 
{
	import core.broadcasting.BroadcastingManager;
	import core.broadcasting.EventBroadcaster;
	
	public class EventScope implements IConfigReader 
	{
		private static var IDENT:String = "eventScope";
		private static var SCOPE:String = "name";
		
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
			
			if (!scopeName)
				throw new Error("Scope name is not defined");
			
			var eventBroadcaster:EventBroadcaster = new EventBroadcaster(scopeName);
			
			BroadcastingManager.instance.registerScope(eventBroadcaster);
		}
		
		public function handleProperties():void 
		{
			
		}
		
		public function invocMethods():void 
		{
			
		}
		
		public function postProcedures():void 
		{
			
		}
		
		
	}

}