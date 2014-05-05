package core.ioc.configuration 
{
	import core.ioc.configuration.configreaders.Bean;
	import core.ioc.configuration.configreaders.EventScope;
	import core.ioc.configuration.configreaders.IConfigReader;
	public class Configuration 
	{
		private static var configReaders:Vector.<Class>;
		
		public function Configuration() 
		{
			if (!configReaders)
				initilize();
		}
		
		private function initilize():void 
		{
			configReaders = new Vector.<Class>
			configReaders.push(EventScope) //should go before bean;
			configReaders.push(Bean);
		}
		
		public function processConfig(config:IConfig):void
		{
			var currentConfigList:XMLList;
			var currentSize:int;
			var i:int;
			
			var configReader:IConfigReader;
			var xmlConfig:XML = config.value;
			
			//trace(config.value.toXMLString());
			
			var configurators:Vector.<IConfigReader> = new Vector.<IConfigReader>;
			
			for each(var constructor:Class in configReaders)
			{
				configReader = new constructor();
				currentConfigList = xmlConfig.children().(name() == configReader.ident);
				currentSize = currentConfigList.length();
				
				for (i = 0; i < currentSize; i++)
				{
					configReader = new constructor();
					configReader.read(currentConfigList[i]);
					configurators.push(configReader);
				}
			}
			
			for (i = 0; i < configurators.length; i++)
			{
				configurators[i].handleProperties();
			}
			
			for (i = 0; i < configurators.length; i++)
			{
				configurators[i].postProcedures();
			}
			
			for (i = 0; i < configurators.length; i++)
			{
				configurators[i].invorkMethods();
			}
		}
		
	}

}