<?php 
/*	$DB_HOST='localhost';
	$DB_USER='u335917972_kacinvest';
	$DB_PASS='kacinvest';
	$DB_NAME='u335917972_kacinvest';

	
	$con = new Mysqli(DB_HOST, DB_USER, DB_PASS, DB_NAME) or die(Mysqli_errno());
	mysqli_set_charset($con,"utf8");*/

// isi nama host, username mysql, dan password mysql anda
$host = mysql_connect("localhost","u335917972_kacinvest","kacinvest");

if($host){
	echo "koneksi host berhasil.<br/>";
}else{
	echo "koneksi gagal.<br/>";
}
 
// isikan dengan nama database yang akan di hubungkan
$db = mysql_select_db("u335917972_kacinvest");
 
 if($db){
	echo "koneksi db berhasil.<br/>";
}else{
	echo "koneksi gagal.<br/>";
}

 ?>
