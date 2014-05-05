package core.ioc.configuration.configreaders 
{
	import core.broadcasting.IEventBroadcaster;
	import core.error.PropertyValueError;
	import core.ioc.configuration.KeyConstants;
	import core.ioc.Context;
	import core.utils.Cast;

	public class Scope implements IProperty
	{
		public var value:String;
		
		public var instance:Object;
		
		public function Scope() 
		{
			
		}
		
		public function assign(obj:Object):void
		{
			if (!(obj is IEventBroadcaster))
				throw new Error("Scope can be added only on IEventBroadcaster object");
				
			(obj as IEventBroadcaster).addScope(value);
		}
		
		static public function createFromXML(xml:XML):IProperty
		{
			var instance:Scope = new Scope();
			
			var value:String = instance.value = xml.@[KeyConstants.VALUE];
			
			if (value)
				fromValue(value, instance);
			else
				throw new PropertyValueError("scope of " + xml.toXMLString()) 
				
			return instance;
		}
		
		static private function fromValue(value:String, instance:Scope):void 
		{
			instance.instance = Cast.cast(value);
		}
		
		static public function createFromXMLList(xml:XMLList):Vector.<IProperty>
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
		
	}

}