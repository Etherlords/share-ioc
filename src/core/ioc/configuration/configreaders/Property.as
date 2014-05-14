package core.ioc.configuration.configreaders 
{
	import core.error.PropertyValueError;
	import core.ioc.configuration.ClassFactory;
	import core.ioc.configuration.KeyConstants;
	import core.ioc.Context;
	import core.utils.Cast;

	public class Property implements IProperty
	{
		public var instance:Object;
		public var name:String;
		
		public function Property() 
		{
			
		}
		
		public function assign(obj:Object):void
		{
			obj[name] = instance;
		}
		
		static public function createFromXML(xml:XML):IProperty
		{
			var instance:Property = new Property();
			
			instance.name = xml.@[KeyConstants.NAME];
			
			if (!instance.name)
				throw new Error("Name for property is not set");
			
			var reference:String = xml.@[KeyConstants.REFERANCE]
			var value:String = xml.@[KeyConstants.VALUE];
			var clazz:String = xml.@[KeyConstants.CLASS_REF];
			
			if (reference)
				fromInstance(reference, instance);
			else if (value)
				fromValue(value, instance);
			else if(clazz)
				fromClass(clazz, instance);
			else
				throw new PropertyValueError(instance.name) 
				
			return instance;
		}
		
		static private function fromValue(value:String, instance:Property):void 
		{
			instance.instance = Cast.cast(value);
		}
		
		static private function fromClass(clazz:String, instance:Property):void 
		{
			instance.instance = ClassFactory.createClass(clazz);
		}
		
		static private function fromInstance(referance:String, instance:Property):void 
		{
			instance.instance = Context.instance.getObjectById(referance);
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