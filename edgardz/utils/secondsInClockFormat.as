package org.edgardz.utils
{
	public function secondsInClockFormat( value:int ):String
	{
		var seconds :int = value % 60; 
		var minutes :int = Math.floor( value / 60 ); 
		var hours	:int = Math.floor( minutes / 60 ); 
		
		var str : String;
		
		if( hours > 0 )
		{
			str = hours.toString() + ":" + fillZeros(minutes,2) + ":" + fillZeros(seconds,2);
		}
		else if( minutes > 0 )
		{
			str = minutes.toString() + ":" + fillZeros(seconds,2);
		}
		else
		{
			str = "0:" + fillZeros(seconds, 2);
		}
		
		return str;
	}
}