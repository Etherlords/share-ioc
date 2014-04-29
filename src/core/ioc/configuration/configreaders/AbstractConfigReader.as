package core.ioc.configuration.configreaders 
{
	public class AbstractConfigReader implements IConfigReader 
	{
		static public const PROPERTY_CREATE_METHOD:String = "createFromXMLList";
		
		protected var config:XML;
		protected var instance:Object;
		
		public function AbstractConfigReader() 
		{
			
		}
		
		public function get ident():String
		{
			throw new Error("Ident should be overrided");
			return "";
		}
		
		public function read(config:XML):void 
		{
			this.config = config;
			parse();
		}
		
		protected function parse():void 
		{
			
		}
		
		protected function assignProperties(type:String, builder:Class):void
		{
			var builderr:Function = builder[PROPERTY_CREATE_METHOD]
			var propertySetters:Vector.<IProperty> = builderr(config.children().(name() == type));
			
			if (propertySetters)
			{	
				var propertySetter:IProperty
				for (var i:int = 0; i < propertySetters.length; i++)
				{
					propertySetter = propertySetters[i];
					propertySetter.assign(instance);
				}
			}
		}
		
		public function handleProperties():void 
		{
			
		}
		
		public function invorkMethods():void 
		{
			
		}
		
		public function postProcedures():void 
		{
			
		}
		
	}

}