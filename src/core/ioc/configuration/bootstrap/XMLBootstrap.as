package  core.ioc.configuration.bootstrap
{

	import core.ioc.configuration.bootstrap.Bootstrap;
	import core.ioc.configuration.Configuration;
	import core.ioc.configuration.InternalXMLConfig;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.system.System;

	public class XMLBootstrap extends Bootstrap
	{
		private var loader:URLLoader;
		private var config:InternalXMLConfig;
		private var classesRef:ClassesReference = new ClassesReference();
		
		public function XMLBootstrap() 
		{
			
		}
		
		private function onConfigLoaded(e:Event):void 
		{
			config = new InternalXMLConfig(new XML(loader.data));
			launch();
		}
		
		public function loadConfig(configUrl:String):void
		{
			loader = new URLLoader();
			loader.addEventListener(Event.COMPLETE, onConfigLoaded);
			loader.load(new URLRequest(configUrl));
		}
		
		public function launch():void
		{
			trace('Ashes.launch');
			
			var configurator:Configuration = new Configuration();
			configurator.processConfig(config);
			loader.close();
			System.disposeXML(config.value);
			configurator = null;
		}
		
	}

}