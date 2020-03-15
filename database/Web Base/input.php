<!DOCTYPE html>
<html>
<head>
	<title>CRUD PHP dan MySQLi</title>
</head>
<body>

	<h2>CRUD DATA MAHASISWA</h2>
	<br/>
	<a href="index.php">KEMBALI</a>
	<br/>
	<br/>
	<h3>TAMBAH DATA MAHASISWA</h3>
	<form method="post" action="input_action.php">
		<table>
			<tr>			
				<td>Username</td>
				<td><input type="text" name="username"></td>
			</tr>
			<tr>			
				<td>First Name</td>
				<td><input type="text" name="firstname"></td>
			</tr>
			<tr>			
				<td>Last Name</td>
				<td><input type="text" name="lastname"></td>
			</tr>
			<tr>			
				<td>Born Date</td>
				<td><input type="text" name="borndate"></td>
			</tr>
			<tr>			
				<td>email</td>
				<td><input type="text" name="email"></td>
			</tr>
			<tr>			
				<td>phone number</td>
				<td><input type="text" name="phonenumber"></td>
			</tr>
			<tr>			
				<td>address</td>
				<td><input type="text" name="address"></td>
			</tr>
			<tr>
				<td>bank</td>
				<td><input type="number" name="bankaccountnumber"></td>
			</tr>
			<tr>
				<td></td>
				<td><input type="submit" value="SIMPAN"></td>
			</tr>		
		</table>
	</form>
</body>
</html>