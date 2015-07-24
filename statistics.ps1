$strComputer = "."
write-host "Os name and version is " (get-wmiobject -class "win32_operatingsystem" -namespace "root\CIMV2" -computername $strComputer).caption
$colItems = Get-WmiObject -class "Win32_Processor" -namespace "root/CIMV2" -computername $strComputer 
foreach ($objItem in $colItems) {  
write-host "Architecture: " $objItem.AddressWidth "bit"
    Write-Host "CPU Name: " $objItem.Name 
    Write-Host "CPU Cores: "  $objItem.NumberOfCores
}
$obj = gwmi win32_operatingsystem
write-host "Total memory: " $obj.Totalvisiblememorysize
write-host "Free memorya: " ($obj.totalvisiblememorysize - $obj.freephysicalmemory)
write-host "Number of processes running : " @(get-process).count
write-host "CPU load : " (Get-WmiObject win32_processor).LoadPercentage "%"
$nic =  Get-WMIObject Win32_NetworkAdapterConfiguration | where{$_.IPEnabled -eq "TRUE"}
write-host "IP address : " $nic.ipaddress[0]
write-host "Mac address : " $nic.ipaddress[1]

$Tcpip_NI = Get-WmiObject -class Win32_PerfRawData_Tcpip_NetworkInterface -computername $strcomputer -namespace "root\cimv2" 

foreach ($obj in $tcpip_ni) {
$str = $obj.name
$str = $str -replace "_", "#"

if ($str -ne $nic.description) {
continue
}
write-host "Bytes sent per second " $obj.bytessentpersec
write-host "Bytes received per second " $obj.bytesreceivedpersec
}
 

