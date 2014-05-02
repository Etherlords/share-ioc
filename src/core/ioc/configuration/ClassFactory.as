package core.ioc.configuration 
{
	
	import avmplus.DescribeTypeJSON;
	
	import core.error.ClassReferenceError;
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
                var classRef:Class = ClassesRef;
				var __typesOf:Vector.<String> = new Vector.<String>
				var variables:Object = DescribeTypeJSON.instance.getClassDescription(classRef).traits.variables;
				
				for (var i:int = 0; i < variables.length; i++)
				{
					if (variables[i].type.split("::")[1] == reference.split('.')[reference.split('.').length - 1])
						__typesOf.push(variables[i].type);
				}
				
				
				var msg:String = '';
				
				if (__typesOf.length)
					msg = " maybe u mean one of values: " + __typesOf.join(', ');
				
				throw new ClassReferenceError(reference, msg);
			}
			
			return null;
		}
		
	}

}