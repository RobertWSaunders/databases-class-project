<?php
	session_start();

	if (!isset($_SESSION["authenticated"])) {
		header('location: login.php');
	}

	if (isset($_POST['submit'])) {
		header('location: movie.php');
	}
?>

<?php include 'templates/header.php' ?>

<?php include 'templates/navbar.php' ?>

<div class="container">
	<div class="col-xs-12 col-sm-8 offset-sm-2 col-md-6 offset-md-3" style="margin-top: 40px; text-align: center;">

		<h2>Search Movies</h2>
		<p>The future has arrived, search for your movie now!</p>
		<br />

		<?php

			try {
				require "config.php";
				require "common.php";

				$connection = new PDO($dsn, $username, $password, $options);

				$sql = "SELECT *
					FROM theatre_complex";

				$statement = $connection->prepare($sql);
				$statement->execute();

				$result = $statement->fetchAll();
			}

			catch(PDOException $error) {
				echo $sql . "<br>" . $error->getMessage();
			}

			echo '
					<form action="movies.php" id="movie_complex">
						<div class="input-group mb-3">
							<select class="custom-select" id="complex_select" name="complex_select" style="width: 250px;">
							<option selected value="-1">Choose Theatre Complex...</option>';
							foreach ($result as $row) {
								echo '<option value="'.$row[0].'">'.$row[1].'</option>';
							}
							echo '
							</select>
							<div class="input-group-append">
								<button class="btn btn-primary" type="button submit">See Movies</button>
							</div>
						</div>
					</form>
				</div>
				';

				if (isset($_GET['complex_select']) && $_GET['complex_select'] != -1) {
					$complexId = $_GET['complex_select'];

					$sql2 = "SELECT * FROM movie
						INNER JOIN showing ON showing.movie_id = movie.id
						INNER JOIN theatre ON theatre.id = showing.theatre_id
						INNER JOIN theatre_complex ON theatre_complex.id = theatre.theatre_complex_id
						WHERE theatre_complex.id=:complexId";

					$smt = $connection->prepare($sql2);
					$smt->bindParam(':complexId', $complexId, PDO::PARAM_STR);
					$smt->execute();

					$res = $smt->fetchAll();

					if(!$res || $smt->rowCount() == 0) {
						echo '<div class="alert alert-danger" role="alert">No movies currently playing at this theatre complex!</div>';
					} else {
						foreach ($res as $row) {
							echo'
								<div class="media" style="margin-top: 40px; margin-top: 40px; margin-bottom: 40px;">
									<div class="media-left">
										<a href="#">
											<img class="media-object" src="'.$row[8].'" alt="">
										</a>
									</div>
									<div class="media-body" style="margin-left: 10px;">
										<h4 class="media-heading">'.$row[1].'</h4>
										<b>Rating: </b>'.$row[3].'
										<br />
										<b>Director: </b>'.$row[5].'
										<br />
										<b>Producer: </b>'.$row[6].'
										<br />
										<b>Run Time: </b>'.$row[2].'
										<br />
										<br />
										<p>
											'.$row[4].'
										</p>
										<form action="movies.php" method="post">
											<button type="submit" class="btn btn-primary" value="showtimes">View Showtimes</button>
											<button type="submit" class="btn btn-primary" value="showtimes">Review</button>
										</form>
									</div>
								</div>
								';
						}
					}
				} elseif ($_GET['complex_select'] == -1) {
					echo '<div class="alert alert-danger" role="alert">Please select a valid theatre complex!</div>';
				}
		?>
</div>
