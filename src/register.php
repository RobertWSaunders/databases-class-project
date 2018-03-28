<?php
	session_start();

	if (isset($_POST['submit'])) {
		require 'config.php';
		require 'common.php';

		try {
			$connection = new PDO($dsn, $username, $password, $options);
		}

		catch(PDOException $error) {
			echo $sql . "<br>" . $error->getMessage();
		}

		$new_user = array(
			"fname" => $_POST['firstName'],
			"lname" => $_POST['lastName'],
			"email" => $_POST['email'],
			"a_street" => $_POST['street'],
			"a_city" => $_POST['city'],
			"a_postal_code" => $_POST['pc'],
			"phone_number" => $_POST['phoneNumber'],
			"password" => $_POST['password'],
			"cc_number" => $_POST['creditCardNumber'],
			"cc_expiry" => $_POST['creditCardExpiry'],
			"cc_cvc" => $_POST['creditCardCVC'],
		);

		$sql = sprintf(
			"INSERT INTO %s (%s) values (%s)",
			"customer",
			implode(", ", array_keys($new_user)),
			":" . implode(", :", array_keys($new_user))
		);

		$statement = $connection->prepare($sql);
		$statement->execute($new_user);

		$sql = "SELECT *
			FROM customer
			WHERE email = :email";

		$email = $_POST['email'];

		$smt = $connection->prepare($sql);
		$smt->bindParam(':email', $email, PDO::PARAM_STR);
		$smt->execute();

		$result = $smt->fetch();

		if (isset($_POST['submit']) && $statement) {
			$_SESSION['authenticated'] = true;
			$_SESSION['isAdmin'] = $result[7];
			$_SESSION['accountNum'] = $result[0];
			header("location: index.php");
		} else {
			$error = "For some reason we could not create your account!";
		}

		$connection = null;
	}
?>

<?php include 'templates/header.php' ?>

<div class="container">
	<div class="col-xs-12 col-sm-8 offset-sm-2 col-md-6 offset-md-3">

		<?php if ($error) { ?>
			<div class="alert alert-danger" role="alert">
				<?php echo $error ?>
			</div>
		<?php } ?>
		<br />
		<h2>Register Your Account</h2><br />
		<form action="register.php" method="post">
			<div class="form-group">
				<label for="firstName">First Name</label>
				<input type="text" name="firstName" id="firstName" class="form-control">
			</div>
			<div class="form-group">
				<label for="lastName">Last Name</label>
				<input type="text" name="lastName" id="lastName" class="form-control">
			</div>
			<div class="form-group">
				<label for="email">Email</label>
				<input type="email" name="email" id="email" class="form-control">
			</div>
			<div class="form-group">
				<label for="street">Street</label>
				<input type="text" name="street" id="street" class="form-control">
			</div>
			<div class="form-group">
				<label for="city">City</label>
				<input type="text" name="city" id="city" class="form-control">
			</div>
			<div class="form-group">
				<label for="pc">Postal Code</label>
				<input type="text" name="pc" id="pc" class="form-control">
			</div>
			<div class="form-group">
				<label for="phoneNumber">Phone Number</label>
				<input type="text" name="phoneNumber" id="phoneNumber" class="form-control">
			</div>
			<div class="form-group">
				<label for="creditCardNumber">Credit Card Number</label>
				<input type="text" name="creditCardNumber" id="creditCardNumber" class="form-control">
			</div>
			<div class="form-group">
				<label for="creditCardExpiry">Credit Card Expiry (MMYY)</label>
				<input type="text" name="creditCardExpiry" id="creditCardExpiry" class="form-control">
			</div>
			<div class="form-group">
				<label for="creditCardCVC">Credit Card CVC</label>
				<input type="text" name="creditCardCVC" id="creditCardCVC" class="form-control">
			</div>
			<div class="form-group">
				<label for="password">Password</label>
				<input type="password" name="password" id="password" class="form-control">
			</div>
			<input class="btn btn-primary" type="submit" name="submit" value="Register">
		</form>
		<br />
		<a href="login.php">Login</a> | <a href="index.php">Home</a>

	</div>
	<br />
</div>

<?php include 'templates/footer.php' ?>
