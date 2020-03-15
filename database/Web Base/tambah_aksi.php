<?php 
// koneksi database
include 'connection.php';

// menangkap data yang di kirim dari form
$username = $_POST['username'];
$firstname = $_POST['firstname'];
$lastname = $_POST['lastname'];
$borndate = $_POST['borndate'];
$email = $_POST['email'];
$phonenumber = $_POST['phonenumber'];
$address = $_POST['address'];
$bank = $_POST['bankaccountnumber'];

// menginput data ke database
mysqli_query($con,"INSERT INTO 'AccountProfile' (`username`, `firstName`, `lastName`, `bornDate`, `email`, `phoneNumber`, `address`, `bankAccountNumber`) VALUES ('$username', '$firstname', '$lastname', '$borndate', '$email', '$phonenumber', '$address', '$bank')");
//mysqli_query($con,"insert into mahasiswa values('','$nama','$nim','$alamat')");

// mengalihkan halaman kembali ke index.php
header("location:index.php");

?>