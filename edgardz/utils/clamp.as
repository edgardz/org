package org.edgardz.utils
{
	public function clamp(value:Number, min:Number, max:Number):Number
	{
		if( value < min ) return min;
		if( value > max ) return max;
		
		return value;
	}
}