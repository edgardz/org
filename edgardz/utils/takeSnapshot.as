package org.edgardz.utils
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.IBitmapDrawable;
	import flash.geom.Matrix;

	public function takeSnapshot(src:DisplayObject, destinationBmp:Bitmap = null, centeredSrc:Boolean = false, smooth:Boolean = false, transparent:Boolean = true):Bitmap
	{
		if( destinationBmp == null ) destinationBmp = new Bitmap(new BitmapData(src.width, src.height, transparent));
			
		destinationBmp.bitmapData.fillRect( destinationBmp.bitmapData.rect, 0 );
		
		if(!transparent) destinationBmp.bitmapData.fillRect( destinationBmp.bitmapData.rect, 0xffffff );
		
		if(centeredSrc)
		{
			destinationBmp.bitmapData.draw( src, new Matrix(1,0,0,1,src.width*0.5,src.height*0.5) );
		}
		else
		{
			destinationBmp.bitmapData.draw( src );
		}
		
		destinationBmp.smoothing = smooth;
		
		return destinationBmp;
	}
}