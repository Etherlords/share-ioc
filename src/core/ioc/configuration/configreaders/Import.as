package core.ioc.configuration.configreaders 
{
	/**
	 * ...
	 * @author Nikro
	 */
	public class Import implements IConfigReader 
	{
		public static const IDENT:String = 'import';
		
		public function Import() 
		{
			
		}
		
		public function read(config:XML):void 
		{
			var resSource:String = config.@resource;
		}
		
		public function inject():void 
		{
			
		}
		
		public function callConstructor():void 
		{
			
		}
		
		public function get ident():String 
		{
			return IDENT;
		}

        public function handleProperties():void {
        }

        public function invocMethods():void {
        }

        public function postProcedures():void {
        }
    }

}