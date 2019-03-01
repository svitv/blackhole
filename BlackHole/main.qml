import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import QtQuick.Particles 2.12
import "help.js" as Help


ApplicationWindow
{
   id: window
   visible: true
   width: 512
   height: 540
   minimumWidth: 512
   minimumHeight: 512
   maximumHeight: 512
   maximumWidth: 512
   title: "Črna luknja"

   menuBar:
      MenuBar
      {
         Menu
         {
            title: "Datoteka"

            MenuItem
            {
               text: "Izhod"
               onTriggered:
               {
                  window.close();
               }


            }
         }
         Menu
         {
            title: "Pomoč"

            MenuItem
            {
               text: "Vizitka"
               onTriggered:
               {
                  dlg.open();
               }
            }
         }
      }

   Rectangle
   {
      anchors.fill: parent

      Image
      {
         source: "Space.jpg"
         opacity: 0.73
         anchors.fill: parent
      }

      Image
      {
         source: "black_hole.png"
         width: 16
         height: 16
         x: 248
         y: 248
      }


      ParticleSystem
      {
         id: sys
         anchors.fill: parent
         enabled: true
      }

      ImageParticle
      {
         id: earth
         system: sys
         source: "earth.png"
         entryEffect: ImageParticle.None
         rotationVelocity: 30
         width: 32
         height: 32
      }


      Emitter
      {
         id: em
         system: sys
         enabled: true
         lifeSpan: 6000000
         emitRate: 1
         maximumEmitted: 1
         x: 127
         y: 127
         width: 0
         height: 0
         velocity:
            PointDirection
            {
               x: 3
               y: 0
            }

      }

      Gravity
      {
         id: g
         system: sys
         magnitude: 5
         angle: 90
         onAffected:
         {
            if (x > 250 && x < 260 && y > 250 && y < 260)
            {
               sys.stop();
               em.enabled = false;
               earth.enabled = false;
            }

            var angle = Help.getAngle(x, y)
            g.angle = angle;
            g.magnitude = Help.getMagnitude(x, y);
         }
      }
   }

   Dialog
   {
      id: dlg
      title: "Vizitka"
      x: 128
      y: 128
      width: 256
      height: 256

      ColumnLayout
      {
         anchors.fill: parent

         Label
         {
            Layout.fillWidth: true
            text: "ČRNA LUKNJA"
            font.weight: Font.Black
            font.pixelSize: 20
            horizontalAlignment: "AlignHCenter"
         }

         Label
         {
            Layout.fillWidth: true
            text: "Napisala Svit Verhovšek in Svit Selan"
            horizontalAlignment: "AlignHCenter"
         }

         Label
         {
            Layout.fillWidth: true
            text: "Mentorica: Vesna Jeromen"
            horizontalAlignment: "AlignHCenter"
         }

         Label
         {
            Layout.fillWidth: true
            text: "OŠ Brinje Grosuplje"
            font.italic: true
            horizontalAlignment: "AlignHCenter"
         }

         Button
         {
            Layout.fillWidth: true
            text: "Zapri"
            onClicked:
            {
               dlg.close();
            }
         }
      }



   }
}
