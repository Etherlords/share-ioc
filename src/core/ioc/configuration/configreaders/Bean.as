package core.ioc.configuration.configreaders 
{
	import core.error.BeanError;
	import core.ioc.configuration.ClassFactory;
	import core.error.ClassReferenceError;
	import core.ioc.configuration.KeyConstants;
	import core.utils.Cast;
	
	public class Bean extends AbstractConfigReader
	{	
		public static const _IDENT:String = 'bean';
		
		public static const DESTROY_METHOD:String = 'destroy-method';
		public static const INIT_METHOD:String = 'init-method';
		public static const INJECT_FLAG:String = 'inject';
		
		private var destructor:String;
		private var init_method:String;
		
		private var injectFlag:Boolean = false;
		
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
			
			var inject_flag:String = config.@[INJECT_FLAG];
			
			if (inject_flag)	
				injectFlag = Cast.toBoolean(config.@[INJECT_FLAG]);
			
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
			assignProperties(KeyConstants.SCOPE, Scope);
			assignProperties(KeyConstants.METHOD_LOOKUP, MethodLookup);
			assignProperties(KeyConstants.DESCRIBE_EVENT, DescribeEvent);
		}
		
		override public function invorkMethods():void 
		{
			if (!init_method)
				return;
				
			if (init_method in instance)
				instance[init_method]();
		}
		
		override public function postProcedures():void 
		{
			if (injectFlag)
				inject(instance)
		}
		
	}

}