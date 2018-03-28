<?php
	session_start();

	if (!isset($_SESSION["authenticated"])) {
		header('location: login.php');
	}

	try {
		require "config.php";
		require "common.php";

		$connection = new PDO($dsn, $username, $password, $options);

		$sql = "SELECT *
			FROM customer
			WHERE account_num = :accountNum";

		$accountNum = $_SESSION['accountNum'];

		$statement = $connection->prepare($sql);
		$statement->bindParam(':accountNum', $accountNum, PDO::PARAM_STR);
		$statement->execute();

		$result = $statement->fetch();
	}

	catch(PDOException $error) {
		echo $sql . "<br>" . $error->getMessage();
	}


	if (isset($_POST['submit'])) {

		$sql = "UPDATE customer SET fname=:fname, lname=:lname, email=:email, a_street=:a_street, a_city=:a_city, a_postal_code=:a_postal_code, phone_number=:phone_number, password=:password, cc_number=:cc_number, cc_expiry=:cc_expiry, cc_cvc=:cc_cvc WHERE account_num=:accountNum";

		$email = $_POST['email'];
		$fname = $_POST['firstName'];
		$lname = $_POST['lastName'];
		$a_street = $_POST['street'];
		$a_city = $_POST['city'];
		$a_postal_code = $_POST['pc'];
		$phone_number = $_POST['phoneNumber'];
		$password = $_POST['password'];
		$cc_number = $_POST['creditCardNumber'];
		$cc_expiry = $_POST['creditCardExpiry'];
		$cc_cvc = $_POST['creditCardCVC'];

		$accountNum = $_SESSION['accountNum'];

		$smt = $connection->prepare($sql);
		$smt->bindParam(':email', $email, PDO::PARAM_STR);
		$smt->bindParam(':fname', $fname, PDO::PARAM_STR);
		$smt->bindParam(':lname', $lname, PDO::PARAM_STR);
		$smt->bindParam(':a_street', $a_street, PDO::PARAM_STR);
		$smt->bindParam(':a_city', $a_city, PDO::PARAM_STR);
		$smt->bindParam(':a_postal_code', $a_postal_code, PDO::PARAM_STR);
		$smt->bindParam(':phone_number', $phone_number, PDO::PARAM_STR);
		$smt->bindParam(':password', $password, PDO::PARAM_STR);
		$smt->bindParam(':cc_number', $cc_number, PDO::PARAM_STR);
		$smt->bindParam(':cc_expiry', $cc_expiry, PDO::PARAM_STR);
		$smt->bindParam(':cc_cvc', $cc_cvc, PDO::PARAM_STR);
		$smt->bindParam(':accountNum', $accountNum, PDO::PARAM_STR);
		$smt->execute();

		if (isset($_POST['submit']) && $smt) {
			header("location: index.php");
		} else {
			$error = "For some reason we could not update your account!";
		}

		$connection = null;
	}
?>

<?php include 'templates/header.php' ?>

<?php include 'templates/navbar.php' ?>

<div class="container">
	<div class="col-xs-12 col-sm-8 offset-sm-2 col-md-6 offset-md-3">

		<?php if ($error) { ?>
			<div class="alert alert-danger" role="alert">
				<?php echo $error ?>
			</div>
		<?php } ?>

		<br />
		<h2>Update Your Account</h2><br />
		<form action="profile.php" method="post">
			<div class="form-group">
				<label for="firstName">First Name</label>
				<input type="text" name="firstName" id="firstName" class="form-control" value="<?php echo $result[1];?>">
			</div>
			<div class="form-group">
				<label for="lastName">Last Name</label>
				<input type="text" name="lastName" id="lastName" class="form-control" value="<?php echo $result[2];?>">
			</div>
			<div class="form-group">
				<label for="email">Email</label>
				<input type="email" name="email" id="email" class="form-control" value="<?php echo $result[7];?>">
			</div>
			<div class="form-group">
				<label for="street">Street</label>
				<input type="text" name="street" id="street" class="form-control" value="<?php echo $result[3];?>">
			</div>
			<div class="form-group">
				<label for="city">City</label>
				<input type="text" name="city" id="city" class="form-control" value="<?php echo $result[4];?>">
			</div>
			<div class="form-group">
				<label for="pc">Postal Code</label>
				<input type="text" name="pc" id="pc" class="form-control" value="<?php echo $result[5];?>">
			</div>
			<div class="form-group">
				<label for="phoneNumber">Phone Number</label>
				<input type="text" name="phoneNumber" id="phoneNumber" class="form-control" value="<?php echo $result[7];?>">
			</div>
			<div class="form-group">
				<label for="creditCardNumber">Credit Card Number</label>
				<input type="text" name="creditCardNumber" id="creditCardNumber" class="form-control" value="<?php echo $result[8];?>">
			</div>
			<div class="form-group">
				<label for="creditCardExpiry">Credit Card Expiry (MMYY)</label>
				<input type="text" name="creditCardExpiry" id="creditCardExpiry" class="form-control" value="<?php echo $result[9];?>">
			</div>
			<div class="form-group">
				<label for="creditCardCVC">Credit Card CVC</label>
				<input type="text" name="creditCardCVC" id="creditCardCVC" class="form-control" value="<?php echo $result[10];?>">
			</div>
			<div class="form-group">
				<label for="password">Password</label>
				<input type="password" name="password" id="password" class="form-control">
			</div>
			<input class="btn btn-primary" type="submit" name="submit" value="Update">
		</form>
		<br />
	</div>
	<br />
</div>

<?php include 'teamples/footer.php' ?>
