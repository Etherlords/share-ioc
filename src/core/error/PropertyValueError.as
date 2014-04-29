package core.error 
{
	/**
	 * ...
	 * @author Nikro
	 */
	public class PropertyValueError extends Error 
	{
		
		public function PropertyValueError(message:*="") 
		{
			super("instance or value is not set or is in not right format for " + message);
			
		}
		
	}

}