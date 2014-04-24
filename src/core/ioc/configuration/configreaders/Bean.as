package core.ioc.configuration.configreaders 
{
	import core.error.BeanError;
	import core.ioc.configuration.ClassFactory;
	import core.ioc.configuration.error.ClassReferenceError;
	import core.ioc.configuration.KeyConstants;
	
	public class Bean extends AbstractConfigReader
	{	
		public static const _IDENT:String = 'bean';
		
		public static const DESTROY_METHOD:String = 'destroy-method';
		public static const INIT_METHOD:String = 'init-method';
		
		private var destructor:String;
		private var init_method:String;
		
		public function Bean() 
		{
			
		}
		
		override public function get ident():String 
		{
			return _IDENT;
		}
		
		
		override protected function parse():void 
		{
			var clazz:String = config.@[KeyConstants.CLASS_REF];
			var ident:String = config.@id;
			
			destructor = config.@[DESTROY_METHOD];
			init_method = config.@[INIT_METHOD];
			
			if (!clazz)
				throw BeanError.beanClassNotDefinedError(config[0].toXMLString());
			
			if (CONFIG::debug)
			{
				try
				{
					instance = ClassFactory.createClass(clazz);
				}
				catch (e:ClassReferenceError)
				{
					var message:String = e.message;
					
					message += config.toXMLString();
					e.message += ' at\n' + message;
					
					throw e;
				}
			}
			else
			{
				instance = ClassFactory.createClass(clazz);
			}
			
			addToContext(instance, ident);
		}
		
		override public function handleProperties():void
		{
			assignProperties(KeyConstants.PROPERTY, Property);
			assignProperties(KeyConstants.METHOD_LOOKUP, MethodLookup);
			assignProperties(KeyConstants.DESCRIBE_EVENT, DescribeEvent);
		}
		
		override public function invorkMethods():void 
		{
			if (init_method in instance)
				instance[init_method]();
		}
		
	}

}