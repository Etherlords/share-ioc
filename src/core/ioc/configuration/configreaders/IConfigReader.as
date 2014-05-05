package core.ioc.configuration.configreaders 
{
	
	/**
	 * ...
	 * @author Nikro
	 */
	public interface IConfigReader 
	{
		
		function read(config:XML):void;
		function handleProperties():void
		function invocMethods():void
		
		function postProcedures():void;
		function get ident():String;
	}
	
}