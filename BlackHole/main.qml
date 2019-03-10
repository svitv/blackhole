import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import QtQuick.Particles 2.12
import "help.js" as Help

// Okno programa velikosti 1024x1024
ApplicationWindow
{
   id: window
   visible: true

   width: 1024
   height: 1024

   // Onemogočimo spreminjanje velikosti
   minimumWidth: 1024
   minimumHeight: 1024
   maximumHeight: 1024
   maximumWidth: 1024

   // Naslov okna
   title: "Črna luknja"

   // Meni okna
   menuBar:
      MenuBar
      {
         Menu
         {
            title: "Datoteka"

            // Izhod iz programa
            MenuItem
            {
               text: "Izhod"
               onTriggered:
               {
                  // Zapri okno
                  window.close();
               }
            }
         }
         Menu
         {
            title: "Pomoč"

            // Prikaz vizitke
            MenuItem
            {
               text: "Vizitka"
               onTriggered:
               {
                  // Prikaži vizitko
                  dlg.open();
               }
            }
         }
      }

   // Ozadje
   Rectangle
   {
      // Je raztegnjen do konca
      anchors.fill: parent

      // Slika vesolja raztegnjena kot ozadje
      Image
      {
         source: "Space.jpg"
         opacity: 0.65
         anchors.fill: parent
      }

      // Slika črne luknje v sredini
      Image
      {
         source: "black_hole.png"
         width: 16
         height: 16
         x: 496
         y: 496
      }

      // Sistem prikazovanja delcev - v našem primeru planeta Zemlje
      ParticleSystem
      {
         id: sys
 //        anchors.fill: parent
         enabled: true
      }

      // Zemlja kot delec
      ImageParticle
      {
         id: earth
         system: sys
         source: "earth.png"

         // Se takoj prikaže
         entryEffect: ImageParticle.None

         // Se zavrti 360 stopinj na dan - 1 sekunda v simulaciji
         rotationVelocity: 360

         // Velikost Zemlje
         width: 32
         height: 32
      }

      // Oddajnik, ki kreira Zemljo in jo požene v gibanje
      Emitter
      {
         id: em
         system: sys
         enabled: true

         // Življenska doba Zemlje je neskončna
         lifeSpan: 600000

         // Oddaja en delec na sekundo
         emitRate: 1

         // Samo 1 delec je lahko na ekranu
         maximumEmitted: 1

         x: 512
         y: 362
         width: 0
         height: 0

         // Začetna hitrost Zemlje
         velocity:
            PointDirection
            {
               x: 2.6
               y: 0
            }
      }

      // Gravitacija, ki deluje stalno na Zemljo
      Gravity
      {
         id: g
         system: sys
         magnitude: 3
         angle: 90

         // Na vsako spremembo se kliče tale kos kode
         onAffected:
         {
            // Če je Zemlja že v črni luknji, potem končaj
            if (x > 504 && x < 520 && y > 504 && y < 520)
            {
               sys.stop();
               em.enabled = false;
               earth.enabled = false;
            }

            // Izračunaj novi kot in novi pospešek - razvil oče od Svita V.
            var angle = Help.getAngle(x, y)
            g.angle = angle;
            g.magnitude = Help.getMagnitude(x, y);
         }
      }
   }

   // Vizitka
   Dialog
   {
      id: dlg
      title: "Vizitka"

      x: 256
      y: 256
      width: 512
      height: 512

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

         // Gumb za zapiranje vizitkr
         Button
         {
            Layout.fillWidth: true
            text: "Zapri"

            // Na klik pokliči tale kos kode
            onClicked:
            {
               // Zapri vizitko
               dlg.close();
            }
         }
      }
   }
}
