<!DOCTYPE html>
<html>
<head>
  <title>Speisekarte</title>
  <meta charset="UTF-8" />
  <!--  das braucht man, um uml zu tippen   -->
</head>
<body>
  <h1>Speisekarte</h1>
  
   <form action="bestellandodb02.php" method="POST">
        <?php
		
// Datenbankverbindung herstellen 
        $mysqli = new mysqli ("localhost", "root", "", "bestellando");
        
		if($mysqli->connect_error)
            {
	           echo "Datenbankfehler</br>"; 
               exit;	
            }
			// Gerichte aus der Datenbank tabelle "gerichte" abrufen
        $ergebnis = $mysqli ->query ("SELECT * FROM gerichte");
		
        echo '<table>';
         
   // liest aus der Datenbank und trägt in tabelle ein 
  while (  $zeile = $ergebnis->fetch_array())
  {
     echo "<tr>";
	 echo "<td>".$zeile['Gericht_ID']."</td>";
	 echo "<td>".$zeile['Gericht_Name']."</td>";
	 echo "<td>".$zeile['Gericht_Preis']."</td>";
	 //echo "<td>".$zeile['KategorieNr']."</td>";
	 echo '<td><input type="number" name="gerichte[' . $zeile['Gericht_ID'] . ']" min="0" max="16" value="0" ></td>';
            echo '</tr>';
  }
  echo "</table";
		// Eintragen Kellner Nr
		echo '</br>';
		echo "Geben Sie ihre Nummer ein</br>";
		echo '<input type="text" name="Kellner_ID" size="3" value="1">  ';
        //Eintragen Tisch Nr
		echo '</br>';
		echo "Geben Sie Tisch Nummer ein</br>";
		echo '<input type="text" name="Tisch_ID" size="3" value="1">  ';
		
        // Datenbankverbindung schließen
        $mysqli->close();
        ?>
        <!--Datum anzeigen-->
		</br></br>
		<input type="text" name="bestelldatum" value="<?php echo date('Y-m-d'); ?>">
        </br></br>
        
        <input type="submit" value="Bestellen">
		
    </form>
  
  </body>
  </html>