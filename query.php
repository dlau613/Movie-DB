<html>
<head><title>CS143 Project 1B</title></head>
<body>
<h1>Mini IMDB by Daniel Lau</h1>
<p> Example: SELECT * FROM Actor WHERE id=10; </p>
<form action="" method="GET">

<textarea name="query" cols="60" rows="8">
<?php echo htmlspecialchars($_GET["query"]) ?>
</textarea><br />
<input type="submit" value="Submit" />
</form>


<?php 

$db = new mysqli('localhost','cs143','','TEST');
if ($db->connect_errno > 0) {
	die('Unable to connect to database [' . $db->connect_error . ']');
}
// $query = preg_replace("~\s+~", " ",$_GET["query"]);
// $query = $db->real_escape_string($query);
$query = $_GET["query"];

if (!$rs = $db->query($query)) {
	$errmsg = $db->error;
	print "Query failed: $errmsg <br />";
}

// grab the query and process
$finfo = $rs->fetch_fields();
echo "Total Results: " . $rs->num_rows . "<br>";
?>
<table border="1">
	<tr>
		<?php
			foreach ($finfo as $val) {
				echo "<td><b>".$val->name . "</b></td>";
			}
		?>
	</tr>
	<?php
		while ($row = $rs->fetch_assoc()) {
			echo "<tr>";
				foreach ($finfo as $val) {
					echo "<td>";
					echo $row[$val->name];
					if ($row[$val->name]=="") {
						echo "N/A";
					}
					echo "</td>";
				}

			echo "</tr>";
		}

	?>
</table>
<?php
echo "Total Results: " . $rs->num_rows . "<br>";

$rs->free();
?>





</body>
</html>
