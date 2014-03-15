package core.ioc 
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	public class IoCConfigLoader extends EventDispatcher
	{
		private var loader:URLLoader;
		public var config:XML;
		
		private var toLoad:Vector.<String>;
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
			directory = path.substr(0, path.lastIndexOf('/'));
			loader.load(new URLRequest(path));
		}
		
		private function onConfigLoaded(e:Event):void 
		{
			config = new XML(loader.data);
			var imports:XMLList = config['import'];
			
			toLoad = new Vector.<String>;
			
			for (var i:int = 0; i < imports.length(); i++)
			{
				toLoad.push(directory+'/'+imports[i].@resource);
			}
			
			loader.removeEventListener(Event.COMPLETE, onConfigLoaded);
			
			loader.addEventListener(Event.COMPLETE, onSubConfigLoaded);
			
			loadSubConfig();
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
			
			loader.load(new URLRequest(toLoad.shift()));
		}
		
		private function onSubConfigLoaded(e:Event):void 
		{
			var child:XML;
			var currentXML:XMLList = new XML(loader.data).children();
			for each(child in currentXML)
			{
				config.appendChild(child);
			}
			
			loadSubConfig();
		}
	}

}