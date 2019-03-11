// Knjižnica za pomoč pri izračunavanju moči in kota pospeška
// Razvil oče od Svita V.

// Funkcija vrača kot glede na koordinate Zemlje in središče črne luknje (512, 512)
// x ... Zemljina pozicija X
// y ... Zemljina pozicija Y
// Vrača kot v stopinjah
function getAngle(x, y)
{
   var deltaX = 511.0 - x;
   var deltaY = 511.0 - y;

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

// Funkcija vrača moč pospeška glede na koordinate Zemlje in središče črne luknje (512, 512)
// x ... Zemljina pozicija X
// y ... Zemljina pozicija Y
// Vrača moč
function getMagnitude(x, y)
{
   var deltaX = 511.0 - x;
   var deltaY = 511.0 - y;

   var dist2 = deltaX * deltaX + deltaY * deltaY;

   var magnitude = 100 / Math.sqrt(dist2);

   return magnitude;
}
