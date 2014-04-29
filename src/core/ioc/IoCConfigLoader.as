package core.ioc 
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	
	public class IoCConfigLoader extends EventDispatcher
	{
		private var loader:URLLoader;
		public var config:XML;
		static public const IMPORT:String = "import";
		
		private var toLoad:Vector.<String> = new Vector.<String>
		private var directory:String;
		
		public function IoCConfigLoader() 
		{
			initialize();
		}
		
		private function initialize():void 
		{
			loader = new URLLoader();
			loader.addEventListener(Event.COMPLETE, onConfigLoaded);
		}
		
		public function load(path:String):void
		{
			directory = path.substring(0, path.lastIndexOf('/')+1);
			loader.load(new URLRequest(path));
			loader.dataFormat = URLLoaderDataFormat.TEXT;
		}
		
		private function onConfigLoaded(e:Event):void 
		{
			config = new XML(loader.data);
			
			loader.removeEventListener(Event.COMPLETE, onConfigLoaded);
			
			loader.addEventListener(Event.COMPLETE, onSubConfigLoaded);
			
			if(extreactImports(config, directory))
				loadSubConfig();
		}
		
		private function extreactImports(config:XML, path:String = ''):Boolean
		{
			var imports:XMLList = config.children().(name() == IMPORT);
			var importsCount:int = imports.length();
			
			for (var i:int = 0; i < importsCount; i++)
			{
				toLoad.push(path+imports[i].@resource);
			}
			
			return importsCount > 0;
		}
		
		private function loadSubConfig():void
		{
			if (!toLoad.length)
			{
				loader.removeEventListener(Event.COMPLETE, onSubConfigLoaded);
				dispatchEvent(new Event(Event.COMPLETE))
				loader.close();
				return;
			}
			
			loader.load(new URLRequest(toLoad[0]));
		}
		
		private function onSubConfigLoaded(e:Event):void 
		{
			var child:XML;
			
			var configData:XML = new XML(loader.data);
			var currentXML:XMLList = configData.children();
			
			var path:String = toLoad.shift();
			
			for each(child in currentXML)
			{
				if(child.name() != IMPORT)
					this.config.appendChild(child);
			}
			
			extreactImports(configData, path.substring(0, path.lastIndexOf('/') + 1));
			
			loadSubConfig();
		}
	}

}