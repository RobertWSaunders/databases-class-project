<?php
	session_start();

	if (isset($_POST['submit'])) {

		try {
			require "config.php";
			require "common.php";

			$connection = new PDO($dsn, $username, $password, $options);

			$sql = "SELECT *
				FROM customer
				WHERE email=:email AND password=:password";

			$email = $_POST['email'];
			$password = $_POST['password'];

			$statement = $connection->prepare($sql);
			$statement->bindParam(':email', $email, PDO::PARAM_STR);
			$statement->bindParam(':password', $password, PDO::PARAM_STR);
			$statement->execute();

			$result = $statement->fetch();

			if($result && $statement->rowCount() == 1) {
				$_SESSION['authenticated'] = true;
				$_SESSION['isAdmin'] = $result[12];
				$_SESSION['accountNum'] = $result[0];
				header("location: index.php");
			} else {
				$error = "Invalid credentials! Please try again.";
			}
		}

		catch(PDOException $error) {
			echo $sql . "<br>" . $error->getMessage();
		}
	}
?>

<?php include 'templates/header.php' ?>

<div class="container-fluid">
	<div class ="row">
		<div class="login-wrap col-xs-12 col-sm-8 offset-sm-2 col-md-6 offset-md-3 ">

			<?php if ($error) { ?>
				<br />
				<div class="alert alert-danger" role="alert">
					<?php echo $error ?>
				</div>
			<?php } ?>
			<br />
			<h2>Login</h2><br />
			<form action="login.php" method="post">
				<div class="form-group">
					<label for="email">Email</label>
					<input type="text" name="email" id="email" class="form-control" placeholder="Email Address">
				</div>
				<div class="form-group">
					<label for="password">Password</label>
					<input type="password" name="password" id="password" class="form-control" placeholder="Password">
				</div>
				<input class="btn btn-primary" type="submit" name="submit" value="Login">
			</form>
			<br />
			<a href="register.php">Register</a> | <a href="index.php">Home</a>
		</div>
	</div>
</div>

<?php include 'templates/footer.php' ?>
