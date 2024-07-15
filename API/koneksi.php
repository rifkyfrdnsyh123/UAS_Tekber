<?php
header("Access-Control-Allow-Origin:*");
$conn=mysqli_connect('localhost','root','','akademik');
$kueri="select * from mahasiswa";
$hasil=mysqli_query($conn,$kueri);
$mhs=[];
while ($row=mysqli_fetch_array($hasil)){
$mhs[]=$row;
}
echo json_encode($mhs);
?>