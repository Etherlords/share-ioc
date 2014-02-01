package core.ioc.configuration 
{
	
	/**
	 * ...
	 * @author Nikro
	 */
	public interface IConfig 
	{
		function get type():String;
		function get value():XML;
	}
	
}