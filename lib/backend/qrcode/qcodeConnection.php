<?php
header("Content-Type:application/json");
define('HOST','localhost');
define('USER','id20236112_edoardo');
define('PASS','Pass24!edo423');
define('DB','id20236112_testdb');

$con = mysqli_connect(HOST,USER,PASS,DB);

//$sql = "select * from tab_autori";

//Query di unione autori opere museo
$sql="SELECT tab_autori.uid,tab_autori.nome,tab_autori.descrizione_autori,tab_opere.qcode,tab_autori.codice,tab_opere.museo_fk,tab_opere.titolo,tab_opere.descrizione_opere,tab_opere.anno,tab_opere.img_link,tab_opere.video_link FROM tab_autori INNER JOIN tab_opere ON tab_opere.codice_fk=tab_autori.codice JOIN tab_musei ON tab_opere.museo_fk=tab_musei.nome";

$res = mysqli_query($con,$sql);

$result = array();

while($row = mysqli_fetch_array($res,MYSQLI_ASSOC)){
array_push($result,
array('uid'=>$row['uid'],
'nome'=>$row['nome'],
'descrizione_autori'=>$row['descrizione_autori'],
'qcode'=>$row['qcode'],
'codice'=>$row['codice'],
'museo_fk'=>$row['museo_fk'],
'titolo'=>$row['titolo'],
'descrizione_opere'=>$row['descrizione_opere'],
'anno'=>$row['anno'],
'img_link'=>$row['img_link'],
'video_link'=>$row['video_link'],
));
}

/*
while($row = mysqli_fetch_array($res,MYSQLI_ASSOC)){
array_push($result,
array('uid'=>$row['uid'],
'codice'=>$row['codice'],
'nome'=>$row['nome'],
'img'=>$row['img'],
));
}
*/
echo json_encode($result,);
mysqli_close($con);

?>
