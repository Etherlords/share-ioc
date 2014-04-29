package core.broadcasting 
{
	import flash.events.Event;
	
	public interface IEventBroadcaster 
	{
		function broadcastFor(scope:String, event:Event):void;
		
		function broadcast(event:Event):void;
		
		function addScope(scope:String):void;
		
		function set scopes(value:Vector.<String>):void;
		function get scopes():Vector.<String>;
	}
	
}