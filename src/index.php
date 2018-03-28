<?php 	include 'templates/header.php' ?>

<div class="container-fluid">
	<?php include 'templates/navbar.php' ?>

	<?php
		if(isset($_SESSION["authenticated"]) && $_SESSION["authenticated"] == true) { ?>
			<?php include 'home.php' ?>
		<?php } else { ?>
			<?php include 'welcome.php' ?>
	<?php } ?>

</div>

<?php include 'templates/footer.php' ?>
