function getAngle(x, y)
{
   var deltaX = 255.0 - x;
   var deltaY = 255.0 - y;

   if (deltaX == 0)
   {
      if (deltaY > 0)
      {
         return 90;
      }
      else
      {
         return 270;
      }
   }

   if (deltaY == 0)
   {
      if (deltaX > 0)
      {
         return 0;
      }
      else
      {
         return 180;
      }
   }

   var radAngle = Math.atan(deltaY / deltaX);
   var angle = radAngle * 180.0 / Math.PI;

   if (deltaX > 0)
   {
      return angle;
   }

   angle = 180 + angle;

   return angle;
}

function getMagnitude(x, y)
{
   var deltaX = 255.0 - x;
   var deltaY = 255.0 - y;

   var dist2 = deltaX * deltaX + deltaY * deltaY;

   var magnitude = 100 / Math.sqrt(dist2);

   return magnitude;
}
