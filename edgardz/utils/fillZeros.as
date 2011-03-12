package org.edgardz.utils
{
	public function fillZeros(input:int, totalDigits:int):String
	{
		var output : String = input.toString();
		
		while(output.length < totalDigits)
		{
			output = "0"+output;
		}
		
		return output;
	}
}