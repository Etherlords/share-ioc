package core.ioc.configuration 
{
	import core.ioc.configuration.error.ClassReferenceError;
	import flash.system.ApplicationDomain;

	public class ClassFactory 
	{
		public static const application:ApplicationDomain = ApplicationDomain.currentDomain;
		
		public static function createClass(reference:String, ...args:Array):Object
		{
			if (application.hasDefinition(reference))
			{
				var constructor:Class = application.getDefinition(reference) as Class;
				trace('utils.configuration::ClassFactory craete instance of ' + reference);
				return new constructor();
			}
			else
			{
				throw new ClassReferenceError(reference);
			}
			
			return null;
		}
		
	}

}