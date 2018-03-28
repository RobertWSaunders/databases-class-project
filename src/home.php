<?php
	session_start();

	if (!isset($_SESSION["authenticated"])) {
		header('location: login.php');
	} else {
		header('location: movies.php');
	}
?>
