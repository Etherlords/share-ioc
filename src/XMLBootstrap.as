package  
{
	import core.ioc.configuration.bootstrap.Bootstrap;
	import core.ioc.configuration.Configuration;
	import core.ioc.configuration.InternalXMLConfig;
	import core.ioc.IoCConfigLoader;
	import flash.events.Event;
	import flash.system.System;
	
	public class XMLBootstrap extends Bootstrap
	{
		private var loader:IoCConfigLoader;
		
		private var config:InternalXMLConfig;
		
		public function XMLBootstrap() 
		{
			
		}
		
		private function onConfigLoaded(e:Event):void 
		{
			config = new InternalXMLConfig(loader.config);
			launch();
		}
		
		public function loadConfig(configUrl:String):void
		{
			loader = new IoCConfigLoader();
			loader.addEventListener(Event.COMPLETE, onConfigLoaded);
			loader.load(configUrl);
		}
		
		public function launch():void
		{
			var configurator:Configuration = new Configuration();
			configurator.processConfig(config);
			
			System.disposeXML(config.value);
			configurator = null;
		}
		
	}

}