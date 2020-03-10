<?php
$dns = ‘mysql:host=localhost;dbname=u335917972_kacinvest’;
$user = ‘u335917972_kacinvest’;
$password = ‘kacinvest’;
try{
 $db = new PDO ($dns, $user, $pass);
}catch( PDOException $e){
 $error = $e->getMessage();
 echo $error;
}