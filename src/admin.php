<?php
	session_start();

	if (!isset($_SESSION["authenticated"])) {
		header('location: login.php');
	}

	if (isset($_SESSION["isAdmin"]) && $_SESSION['isAdmin'] == 0) {
		header('location: index.php');
	}

	if (isset($_POST['submit'])) {
		require 'config.php';
		require 'common.php';

		try {
			$connection = new PDO($dsn, $username, $password, $options);
		}

		catch(PDOException $error) {
			echo $sql . "<br>" . $error->getMessage();
		}

		$new_movie = array(
			"title" => $_POST['title'],
			"run_time" => $_POST['runTime'],
			"rating" => $_POST['rating'],
			"plot_synopsis" => $_POST['plot_synopsis'],
			"director" => $_POST['director'],
			"producer" => $_POST['producer'],
			"image" => 'assets/img/placeholder.png',
			"supplier_id" => $_POST['supplier']
		);

		$sql = sprintf(
			"INSERT INTO %s (%s) values (%s)",
			"movie",
			implode(", ", array_keys($new_movie)),
			":" . implode(", :", array_keys($new_movie))
		);

		$statement = $connection->prepare($sql);
		$statement->execute($new_movie);
		$id = $connection->lastInsertId();

		$new_showing = array(
			"seats_avail" => $_POST['seats'],
			"start_time" => $_POST['start_time'],
			"start_date" => $_POST['start_date'],
			"movie_id" => $id,
			"theatre_id" => $_POST['theatre'],
		);

		$sql2 = sprintf(
			"INSERT INTO %s (%s) values (%s)",
			"showing",
			implode(", ", array_keys($new_showing)),
			":" . implode(", :", array_keys($new_showing))
		);

		$smt = $connection->prepare($sql2);
		$smt->execute($new_showing);

		$connection = null;
	}
?>

<?php include 'templates/header.php' ?>

<?php include 'templates/navbar.php' ?>

<div class="container">
	<div class="col-xs-12 col-sm-8 offset-sm-2 col-md-6 offset-md-3">

		<?php if (isset($_POST['submit']) && $statement) { ?>
			<div class="alert alert-success" role="alert">The movie, <?php echo $_POST['title']; ?>, was successfully added!</div>
		<?php } ?>

		<br />
		<h2>Add Movie</h2><br />
		<form action="admin.php" method="post">
			<div class="form-group">
				<label for="title">Title</label>
				<input type="text" name="title" id="title" class="form-control">
			</div>
			<div class="form-group">
				<label for="runTime">Run Time</label>
				<input type="text" name="runTime" id="runTime" class="form-control">
			</div>
			<div class="form-group">
				<label for="rating">Rating</label>
				<input type="text" name="rating" id="rating" class="form-control">
			</div>
			<div class="form-group">
				<label for="plot_synopsis">Plot Synopsis</label>
				<input type="text" name="plot_synopsis" id="plot_synopsis" class="form-control">
			</div>
			<div class="form-group">
				<label for="director">Director</label>
				<input type="text" name="director" id="director" class="form-control">
			</div>
			<div class="form-group">
				<label for="producer">Producer</label>
				<input type="text" name="producer" id="producer" class="form-control">
			</div>
			<div class="form-group">
				<label for="start_time">Start Time</label>
				<input type="text" name="start_time" id="start_time" class="form-control">
			</div>
			<div class="form-group">
				<label for="start_date">Start Date</label>
				<input type="text" name="start_date" id="start_date" class="form-control">
			</div>
			<div class="form-group">
				<label for="seats">Seats Available</label>
				<input type="text" name="seats" id="seats" class="form-control">
			</div>
			<div class="form-group">
				<label for="theatre">Theatre ID</label>
				<input type="text" name="theatre" id="theatre" class="form-control">
			</div>
			<div class="form-group">
				<label for="supplier">Supplier ID</label>
				<input type="text" name="supplier" id="supplier" class="form-control">
			</div>
			<input class="btn btn-primary" type="submit" name="submit" value="Add Movie">
		</form>
		<br />
	</div>
	<br />
</div>

<?php include 'templates/footer.php' ?>
