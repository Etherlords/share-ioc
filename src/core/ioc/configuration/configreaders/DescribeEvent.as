package core.ioc.configuration.configreaders 
{
	import core.broadcasting.BroadcastingManager;
	/**
	 * ...
	 * @author Nikro
	 */
	public class DescribeEvent implements IProperty 
	{
		static public const SCOPE_NAME:String = "scopeName";
		static public const EVENT_TYPE:String = "type";
		static public const HANDLER:String = "handler";
		
		public var scopeName:String;
		public var eventType:String;
		public var handler:String;
		
		public function DescribeEvent() 
		{
			
		}
		
		public function assign(obj:Object):void 
		{
			BroadcastingManager.instance.addListener(scopeName, eventType, obj[handler]);
		}
		
		public static function createFromXMLList(xml:XMLList):Vector.<IProperty>
		{
			if (!xml)
				return null;
				
			var size:int = xml.length();
			
			if (!size)
				return null;
				
			var ret:Vector.<IProperty> = new Vector.<IProperty>;
			
			for (var i:int = 0; i < size; i++)
			{
				ret.push(createFromXML(xml[i]));
			}
			
			return ret;
		}
		
		public static function createFromXML(xml:XML):IProperty
		{
			var scopeName:String = xml.@[SCOPE_NAME];
			var eventType:String = xml.@[EVENT_TYPE]; 
			var handler:String = xml.@[HANDLER];
			
			var eventDescriber:DescribeEvent = new DescribeEvent();
			eventDescriber.scopeName = scopeName;
			eventDescriber.eventType = eventType;
			eventDescriber.handler = handler;
			
			return eventDescriber;
		}
		
	}

}