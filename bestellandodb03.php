<?php
// Überprüfen, ob das Formular gesendet wurde
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    // Überprüfen, ob die erforderlichen Felder vorhanden sind
    if (isset($_POST["Kellner_ID"]) && isset($_POST["Tisch_ID"]) && isset($_POST["bestelldatum"])
		 && isset($_POST["Bestellung_ID"])) {
        $kellnerID = $_POST["Kellner_ID"];
        $tischID = $_POST["Tisch_ID"];
        $bestelldatum = $_POST["bestelldatum"];
        
		$bestellungsID = $_POST["Bestellung_ID"];
						
        // Datenbankverbindung herstellen
        $mysqli = new mysqli("localhost", "root", "", "bestellando");
        if ($mysqli->connect_error) 
		{
            die("Datenbankverbindung fehlgeschlagen: " . $mysqli->connect_error);
        }


        // SQL-Befehl zur Erstellung der Rechnung
        $sql = "SELECT Gericht_Name, Gericht_Preis, Gerichte_Anzahl, Gericht_Preis * Gerichte_Anzahl AS Beitrag
                FROM gerichte, bestellung_deteile
                WHERE Gericht_ID = Geri_ID AND Best_ID = $bestellungsID
                UNION ALL
                SELECT 'Zwischensumme', ' ', ' ', SUM(Gericht_Preis * Gerichte_Anzahl)
                FROM gerichte, bestellung_deteile
                WHERE Gericht_ID = Geri_ID AND Best_ID = $bestellungsID";

        // Ausführen des SQL-Befehls und Ausgabe der Rechnung
        $result = $mysqli->query($sql);
        if ($result->num_rows > 0) 
		{
            echo "<h3>Rechnung für Kellner $kellnerID, Tisch $tischID:</h3>";
            echo "<h3>Bestelldatum: $bestelldatum</h3>";
			echo "<h3>Bestellung: $bestellungsID</h3>";
            echo "<table>";
            echo "<tr><th>Gericht_Name</th><th>Gericht_Preis</th><th>Gerichte_Anzahl</th> <th>Beitrag €</th></tr>";
            while ($row = $result->fetch_assoc()) {
                echo "<tr>";
                echo "<td>" . $row["Gericht_Name"] . "</td>";
                echo "<td>" . $row["Gericht_Preis"] . "</td>";
                //echo "<td> </td>";
                echo "<td>" . $row["Gerichte_Anzahl"] . "</td>";
                //echo "<td>=</td>";
                echo "<td>" . $row["Beitrag"] . "</td>";
                echo "</tr>";
            }
            echo "</table>";
        } 
		else 
		    {
            echo "Keine Daten gefunden.";
            }

        // Datenbankverbindung schließen
        $mysqli->close();
    } 
	else 
	{
        echo "Fehler: Es wurden nicht alle erforderlichen Felder übermittelt.";
    }
} 
    else 
	{
    echo "Fehler: Das Formular wurde nicht gesendet.";
	}
?>