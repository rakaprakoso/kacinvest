<!DOCTYPE html>
<html>

<head>
	<title>CRUD PHP dan MySQLi</title>
</head>

<body>

	<h2>KACINVEST</h2>
	<br />
	<a href="index.php">KEMBALI</a>
	<br />
	<br />
	<h3>EDIT DATA AKUN</h3>

	<?php
	require_once 'Connection.php'; 
	$id = $_GET['username'];
	$query = " SELECT * FROM AccountProfile ";

    $result = mysqli_query($con,$query);

	//include 'connection.php';
	//$id = $_GET['username'];
	//$data = mysqli_query($con,"select * from AccountProfile where username='$id'");
	while($d = mysqli_fetch_array($result)){
		?>
	<form method="post" action="update.php">
		<table>
			<tr>
				<td>Nama</td>
				<td>
					<input type="hidden" name="id" value="<?php echo $d['username']; ?>">
					<input type="text" name="nama" value="<?php echo $d['firstName']; ?>">
				</td>
			</tr>
			<tr>
				<td>NIM</td>
				<td><input type="text" name="nim" value="<?php echo $d['email']; ?>"></td>
			</tr>
			<tr>
				<td>Alamat</td>
				<td><input type="text" name="alamat" value="<?php echo $d['bankAccountNumber']; ?>"></td>
			</tr>
			<tr>
				<td></td>
				<td><input type="submit" value="SIMPAN"></td>
			</tr>
		</table>
	</form>
	<?php 
	}
	?>

</body>

</html>