<?php

function OpenDB()
{
  
 

  $conn = oci_connect("HR", "1", 'localhost/orcl');
  if (!$conn){
    $e = oci_error();
    trigger_error(htmlentities($e['message'], ENT_QUOTES), E_USER_ERROR);
  }
  
  $stid = oci_parse($conn, 'SELECT * FROM LIBROS');
  oci_execute($stid);
  
  echo "<table border='1'>\n";
  while ($row = oci_fetch_array($stid, OCI_ASSOC+OCI_RETURN_NULLS)) {
      echo "<tr>\n";
      foreach ($row as $item) {
          echo "    <td>" . ($item !== null ? htmlentities($item, ENT_QUOTES) : "&nbsp;") . "</td>\n";
      }
      echo "</tr>\n";
  }
  echo "</table>\n";
  
  
}

?>