package core.ioc 
{
  import core.collections.SimpleMap;
  import core.ioc.analyzator.MetatagProcessor;
  import core.ioc.analyzator.Metatags;
  import core.ioc.metacommands.Inject;
  import flash.utils.describeType;
  import flash.utils.getQualifiedClassName;
	/**
	 * ...
	 * @author Nikro
	 */
	public class Context 
	{
		static public const FLASH_PACKET:String = "flash.";
		
		private static var _instance:Context;
		
		static public function get instance():Context 
		{
			if (!_instance)
				_instance = new Context();
			
			return _instance;
		}
		
		public var settings:ContextSettings = new ContextSettings();
		public var metatags:Metatags = new Metatags();
		
		private var metatagProcessor:MetatagProcessor;
		private var objectByType:SimpleMap = new SimpleMap();
		private var objectByIface:SimpleMap = new SimpleMap();
		private var objectsByIdent:SimpleMap = new SimpleMap();
		
		public function Context() 
		{
			initilize();
		}
		
		private function initilize():void 
		{
			metatags.addTag(Inject);
			
			metatagProcessor = new MetatagProcessor(this);
		}
		
		public function init():void
		{
			
		}
		
		public function inject(object:Object):void
		{
			metatagProcessor.process(object);
		}
		
		public function addObjectToContext(object:Object, ident:String = ''):Context
		{
			if (ident.length)
			{
				objectsByIdent.addItem(ident, object);
			}
			
			objectByType.addItem(getQualifiedClassName(object), object);
			
			var desc:XML = describeType(object);
			var iFaces:XMLList = desc..implementsInterface.((@type.indexOf(FLASH_PACKET) == -1));
			
			var l:int = iFaces.length();
			
			objectByIface.addItem(iFaces[l-1].@type, object);
			
			return this;
		}
		
		public function getObjectByInterface(iFace:String):Object
		{
			return objectByIface.getItem(iFace);
		}
		
		public function getObjectById(id:String):Object
		{
			var o:Object = objectsByIdent.getItem(id);
			if (!o)
				trace("Warning: Context.getObjectById object with id " + id + " not found");
				
			return o;
		}
		
		public function getObjectByType(methodType:String):Object 
		{
			return objectByType.getItem(methodType);
		}
		
	}
 
}