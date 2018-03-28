
<?php
	session_start();

	if (!isset($_SESSION["authenticated"])) {
		header('location: login.php');
	}

	if (isset($_SESSION["isAdmin"]) && $_SESSION['isAdmin'] == 0) {
		header('location: index.php');
	}

	if (isset($_POST['submit'])) {
		if ($result && $statement->rowCount() > 0) { ?>
			<h2>Results</h2>
			<table>
				<thead>
					<tr>
						<th>#</th>
						<th>First Name</th>
						<th>Last Name</th>
						<th>Email Address</th>
						<th>Age</th>
						<th>Location</th>
						<th>Date</th>
					</tr>
				</thead>
				<tbody>
		<?php
			foreach ($result as $row)
			{ ?>
				<tr>
					<td><?php echo escape($row["id"]); ?></td>
					<td><?php echo escape($row["firstname"]); ?></td>
					<td><?php echo escape($row["lastname"]); ?></td>
					<td><?php echo escape($row["email"]); ?></td>
					<td><?php echo escape($row["age"]); ?></td>
					<td><?php echo escape($row["location"]); ?></td>
					<td><?php echo escape($row["date"]); ?> </td>
				</tr>
			<?php
			} ?>
			</tbody>
		</table>
		<?php
		}
		else
		{ ?>
			<blockquote>No results found for <?php echo escape($_POST['location']); ?>.</blockquote>
		<?php
		}
	}
?>
