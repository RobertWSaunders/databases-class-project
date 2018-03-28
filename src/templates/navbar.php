<?php
	session_start();
?>

<nav class="navbar navbar-light navbar-expand-md">
	<div class="container-fluid">
		<a class="navbar-brand" href="index.php">Online Movie Ticketing System</a>
		<div class="collapse navbar-collapse">
			<ul class="nav navbar-nav ml-auto">
				<?php
					if(isset($_SESSION["authenticated"]) && $_SESSION["authenticated"] == true){
						if (isset($_SESSION['isAdmin']) && $_SESSION['isAdmin'] == 1) {
							echo '<li class="nav-item" role="presentation"><a class="nav-link" href="admin.php">Admin</a></li>';
						}
						echo '<li class="nav-item" role="presentation"><a class="nav-link" href="profile.php">Profile</a></li>';
						echo '<li class="nav-item" role="presentation"><a class="nav-link" href="logout.php">Logout</a></li>';
					} else {
						echo '<li class="nav-item" role="presentation"><a class="nav-link" href="login.php">Login</a></li>';
						echo '<li class="nav-item" role="presentation"><a class="nav-link" href="register.php">Register</a></li>';
					}
				?>
			</ul>
		</div>
	</div>
</nav>
