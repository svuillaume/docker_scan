<?php
//Insecure: Hardcoded secrets in source code
$password = "P@ssw0rd123!";
$api_secret = "demo_51H8SecretKeyInPlainText";

// Simulate usage
echo "<h1>Welcome to Insecure PHP App</h1>";
echo "<p>Your password is: <strong>$password</strong></p>";
echo "<p>Your API secret is: <strong>$api_secret</strong></p>";

// Optional: simulate a secret in a GET param for demo
if (isset($_GET['show_token']) && $_GET['show_token'] === 'yes') {
    echo "<p>Token: <strong>ghp_abc123FakeGitHubToken</strong></p>";
}
?>
