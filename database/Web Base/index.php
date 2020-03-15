
<html>
<head>
	<title>KACINVEST</title>
	<link rel="stylesheet" type="text/css" href="style.css">
</head>
<body>
	<div class="judul">		
		<h1>KACINVEST</h1>
	</div>
	<br/>

	<?php 
	if(isset($_GET['pesan'])){
		$pesan = $_GET['pesan'];
		if($pesan == "input"){
			echo "Data berhasil di input.";
		}else if($pesan == "update"){
			echo "Data berhasil di update.";
		}else if($pesan == "hapus"){
			echo "Data berhasil di hapus.";
		}
	}
	?>
	<br/>
	<a class="tombol" href="input.php">+ Tambah Akun Baru</a>

	<h3>Data user</h3>
	<table border="1" class="table">
		<tr>
			<th>No</th>
			<th>username</th>
			<th>referral code</th>
			<th>bank account number</th>
			<th>Opsi</th>		
		</tr>
		<?php 
		require_once 'Connection.php'; 
        $query = " SELECT * FROM AccountProfile ";

        $result = mysqli_query($con,$query);

		//$query_mysqli = mysqli_query("SELECT * FROM 'AccountProfile'")or die(mysql_error());
		$nomor = 1;
		while($data = mysqli_fetch_array($result)){
		?>
		<tr>
			<td><?php echo $nomor++; ?></td>
			<td><?php echo $data['username']; ?></td>
			<td><?php echo $data['referralCode']; ?></td>
			<td><?php echo $data['bankAccountNumber']; ?></td>
			<td>
				<a class="edit" href="edit.php?username=<?php echo $data['username']; ?>">Edit</a> |
				<a class="hapus" href="hapus.php?username=<?php echo $data['username']; ?>">Hapus</a>					
			</td>
		</tr>
        <?php }?>
        
    </table>
    
    	<a class="tombol" href="input.php">+ Transaksi Baru</a>

	<h3>USER BALANCE</h3>
	<table border="1" class="table">
		<tr>
			<th>No</th>
			<th>username</th>
			<th>Stock ID</th>
            <th>Balance</th>
            <th>NAB Unit</th>
			<th>Opsi</th>		
		</tr>
		<?php 
		require_once 'Connection.php'; 
        $query = " SELECT * FROM AccountBalance ";

        $result = mysqli_query($con,$query);

		//$query_mysqli = mysqli_query("SELECT * FROM 'AccountProfile'")or die(mysql_error());
		$nomor = 1;
		while($data = mysqli_fetch_array($result)){
		?>
		<tr>
			<td><?php echo $nomor++; ?></td>
			<td><?php echo $data['username']; ?></td>
			<td><?php echo $data['stockID']; ?></td>
            <td><?php echo $data['balanceStart']; ?></td>
            <td><?php echo $data['stockNABunit']; ?></td>
			<td>
				<a class="edit" href="edit.php?username=<?php echo $data['username']; ?>">Edit</a> |
				<a class="hapus" href="hapus.php?username=<?php echo $data['username']; ?>">Hapus</a>					
			</td>
		</tr>
        <?php }?>
        
    </table>
    
</body>
</html>