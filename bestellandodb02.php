

<?php
echo '<form action="bestellandodb03.php" method="POST">';
// Überprüfen, ob das Formular gesendet wurde
if ($_SERVER["REQUEST_METHOD"] == "POST") 
{
    // Überprüfen, ob die erforderlichen Felder "gerichte","Kellner_ID", "Tisch_ID", "bestelldatum" vorhanden sind
    if (isset($_POST["gerichte"]) && isset($_POST["Kellner_ID"]) && isset($_POST["Tisch_ID"])
		&& isset($_POST["bestelldatum"])) 
		{ // Die ausgewählten Daten abrufen 
		$bestelldatum = $_POST["bestelldatum"];
        $bestellteGerichte = $_POST["gerichte"];
        $kellnerID = $_POST["Kellner_ID"];
        $tischID = $_POST["Tisch_ID"];
		
		echo "<input type='hidden' name='Kellner_ID' Value= {$kellnerID} />";
		echo "<input type='hidden' name='Tisch_ID' Value= {$tischID} />";
        echo "<input type='hidden' name='bestelldatum' Value= {$bestelldatum} />";

         // Datenbankverbindung herstellen
        $mysqli = new mysqli("localhost", "root", "", "bestellando");
        if ($mysqli->connect_error) 
		   {
            die("Datenbankverbindung fehlgeschlagen: " . $mysqli->connect_error);
           }
        
		// SQL-Befehl zum Einfügen der Daten in die Tabelle bestellung
         
		$sql = "INSERT INTO bestellung (Bestellung_Tisch_ID, Bestellung_Kelner_ID, Datum) 
                VALUES ('$tischID', '$kellnerID', '$bestelldatum')";		
         
         if ($mysqli->query($sql) === TRUE) 
             {
            echo "Die Daten wurden erfolgreich in die Tabelle 'bestellung' eingefügt.";
             } 
			 else 
			 {
            echo "Fehler beim Einfügen der Daten: " . $mysqli->error;
              }
			  
			  
			  // SQL-Befehl zum Abrufen der zuletzt eingefügten Bestellungs-ID
        $getBestellungsID = "SELECT Bestellung_ID FROM bestellung 
                             WHERE Bestellung_Tisch_ID = $tischID 
                             ORDER BY Bestellung_ID DESC 
                             LIMIT 1";
							 
         $result = $mysqli->query($getBestellungsID);
          $row = $result->fetch_assoc();
         $bestellungsID = $row["Bestellung_ID"]; 
		 echo "bestellungsID = ". $bestellungsID ;
		 
  //$bestellungsID übermitteln
         echo "<input type='hidden' name='Bestellung_ID' Value= '$bestellungsID' />";
		 
     // Durchlaufe die ausgewählten Gerichte und füge sie in die Tabelle bestellung_deteile ein
         foreach ($bestellteGerichte as $gerichtID => $menge) 
		  {
    // Überprüfen, ob die Anzahl größer als 0 ist
         if ($menge > 0) 
		    {
        // SQL-Befehl zum Einfügen der Daten in die Tabelle bestellung_deteile
             $insertDetal = "INSERT INTO bestellung_deteile (Geri_ID, Best_ID, Gerichte_Anzahl)
                        VALUES ('$gerichtID', '$bestellungsID', '$menge')";
             $mysqli->query($insertDetal);
            }
          }
		  

        // Datenbankverbindung schließen
        $mysqli->close();
        

        // Die ausgewählten Gerichte und Nr anzeigen
        echo "<h1>Bestellung für Kellner $kellnerID, Tisch $tischID:</h1>";
		echo "<h1>Bestelldatum: $bestelldatum</h1>";
        foreach ($bestellteGerichte as $gerichtID => $menge) 
		{
            echo "<p>Gericht Nr: $gerichtID, Anzahl von Portionen: $menge</p>";
        }
    } 
	else 
	{
        echo "Fehler: Es wurden nicht alle erforderlichen Felder übermittelt.";
    }
} else 
      {
        echo "Fehler: Das Formular wurde nicht gesendet.";
      }

echo '<input type="submit" value="Rechnung">';

?>

