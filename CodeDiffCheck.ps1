$fontColorRed = "<font color='red'>"
$fontColorGreen = "<font color='green'>"
$fontColor = $fontColorRed
$fontEnd = "</font>"



# Define send-mail function.
function Send-SMTPmail($to, $from, $subject, $smtpserver, $body, $attach) {
	$mailer = new-object Net.Mail.SMTPclient($smtpserver)
	$msg = new-object Net.Mail.MailMessage($from,$to,$subject,$body)
    if ($attach) {
    $att = new-object Net.Mail.Attachment($attach)
    }
    if ($att) {
    $msg.Attachments.Add($att)
    }
	$msg.IsBodyHTML = $true
	$mailer.send($msg)
    if ($att) {
    $att.Dispose()
    }
}
 

# Locate in BE2 9.3 dev workspace folder. 
 cd 'C:\TFS\CodeDiff\9.2DEV\Firmware\SMIB'
 # Get the latest source code. 
& 'C:\Program Files\Microsoft Visual Studio 10.0\Common7\IDE\TF.exe' `
  get '$/IGT_0803/development/dev_adv/EGS/ABS/source/Firmware/SMIB' 
 
# Locate in BE2 9.3 CR workspace folder. 
cd 'C:\TFS\CodeDiff\9.2CR\Firmware\SMIB'
# Get the latest source code. 
& 'C:\Program Files\Microsoft Visual Studio 10.0\Common7\IDE\TF.exe' `
  get '$/IGT_0803/development/dev_adv_CR/EGS/ABS/source/Firmware/SMIB' 

# BE2 9.2 rel devA
cd 'C:\TFS\92_rel_devA\SMIB'
# Get the latest source code. 
& 'C:\Program Files\Microsoft Visual Studio 10.0\Common7\IDE\TF.exe' `
  get '$/IGT_0803/release/EGS9.2/rel_devA/EGS/ABS/source/Firmware/SMIB' 
  
# BE2 9.2 sp0 HF
cd 'C:\TFS\92_SP0_HF\SMIB'
# Get the latest source code. 
& 'C:\Program Files\Microsoft Visual Studio 10.0\Common7\IDE\TF.exe' `
  get '$/IGT_0803/release/EGS9.2/SP0/HF/EGS/ABS/source/Firmware/SMIB'
  
# BE2 9.2 sp0 RTM
cd 'C:\TFS\92_SP0_RTM\SMIB'
# Get the latest source code.  
& 'C:\Program Files\Microsoft Visual Studio 10.0\Common7\IDE\TF.exe' `
  get '$/IGT_0803/release/EGS9.2/SP0/RTM/EGS/ABS/source/Firmware/SMIB'  
  
# BE2 9.2 rel_main
cd 'C:\TFS\92_rel_main\SMIB'
# Get the latest source code.  
& 'C:\Program Files\Microsoft Visual Studio 10.0\Common7\IDE\TF.exe' `
  get '$/IGT_0803/release/EGS9.2/rel_main/EGS/ABS/source/Firmware/SMIB'   

# BE2 9.2 rel_devB
cd 'C:\TFS\92_rel_devB\SMIB'
# Get the latest source code.  
& 'C:\Program Files\Microsoft Visual Studio 10.0\Common7\IDE\TF.exe' `
  get '$/IGT_0803/release/EGS9.2/rel_devB/EGS/ABS/source/Firmware/SMIB' 
  
# BE2 9.3 main
cd 'C:\TFS\9.2main\ABS\source\Firmware\SMIB'  
# Get the latest source code.  
& 'C:\Program Files\Microsoft Visual Studio 10.0\Common7\IDE\TF.exe' `
  get '$/IGT_0803/main/EGS/ABS/source/Firmware/SMIB'   
  
  
  
    
 # Start to compare the diffrent folders, and out put the result file.
 $diffContent93dev_cr = & 'C:\Wayllen\Tools\GNU\diff.exe' -Bwqu C:\TFS\CodeDiff\9.2CR\Firmware\SMIB C:\TFS\CodeDiff\9.2DEV\Firmware\SMIB |`
  %{ if($_ -notlike "*Common subdirectories*"){$_} } |  ForEach-Object {if($_){$_.Insert($_.Length,"<br />")}}#| Out-File "C:\report.txt"
  if(!$diffContent93dev_cr){$diffContent93dev_cr = "Nothing Found!"}
  
 $diffContent92devA_sp0 = & 'C:\Wayllen\Tools\GNU\diff.exe' -Bwqu C:\TFS\92_rel_devA\SMIB C:\TFS\92_SP0_HF\SMIB |`
  %{ if($_ -notlike "*Common subdirectories*"){$_} } |  ForEach-Object {if($_){$_.Insert($_.Length,"<br />")}}#| Out-File "C:\report.txt"
  if(!$diffContent92devA_sp0){$diffContent92devA_sp0 = "Nothing Found!"}
  
 $diffContent92SP0_RTM = & 'C:\Wayllen\Tools\GNU\diff.exe' -Bwqu C:\TFS\92_SP0_HF\SMIB C:\TFS\92_SP0_RTM\SMIB |`
  %{ if($_ -notlike "*Common subdirectories*"){$_} } |  ForEach-Object {if($_){$_.Insert($_.Length,"<br />")}}#| Out-File "C:\report.txt"
  if(!$diffContent92SP0_RTM){$diffContent92SP0_RTM = "Nothing Found!"}
  
 $diffContent92relmain_devB = & 'C:\Wayllen\Tools\GNU\diff.exe' -Bwqu C:\TFS\92_rel_main\SMIB C:\TFS\92_rel_devB\SMIB |`
  %{ if($_ -notlike "*Common subdirectories*"){$_} } |  ForEach-Object {if($_){$_.Insert($_.Length,"<br />")}}#| Out-File "C:\report.txt" 
  if(!$diffContent92relmain_devB){$diffContent92relmain_devB = "Nothing Found!"}
  
 $diffContent92relmain_devA = & 'C:\Wayllen\Tools\GNU\diff.exe' -Bwqu C:\TFS\92_rel_main\SMIB C:\TFS\92_rel_devA\SMIB |`
  %{ if($_ -notlike "*Common subdirectories*"){$_} } |  ForEach-Object {if($_){$_.Insert($_.Length,"<br />")}}#| Out-File "C:\report.txt"  
  if(!$diffContent92relmain_devA){$diffContent92relmain_devA = "Nothing Found!"}
  
 $diffContent92relmain_93main = & 'C:\Wayllen\Tools\GNU\diff.exe' -Bwqu C:\TFS\92_rel_main\SMIB C:\TFS\9.2main\ABS\source\Firmware\SMIB |`
  %{ if($_ -notlike "*Common subdirectories*"){$_} } |  ForEach-Object {if($_){$_.Insert($_.Length,"<br />")}} #| Out-File "C:\report.txt" 
  if(!$diffContent92relmain_93main){$diffContent92relmain_93main = "Nothing Found!"} 


#(Get-Content "C:\report.txt") | ForEach-Object {$_.Insert($_.Length,"<br />")} | Set-Content "C:\report.txt"

 # Marked nothing found if there is no any changes.
<# 
 if (!$diffContent){
    $diffContent = "Nothing Found! :)"
    $fontColor = $fontColorGreen
 }
 else{
     $diffContent = $diffContent | ForEach-Object {if($_){$_.Insert($_.Length,"<br />")}}
 }
#> 
 
 <#
 & 'C:\Program Files\Microsoft Visual Studio 10.0\Common7\IDE\TF.exe' `
 folderdiff 'C:\TFS\CodeDiff\9.2DEV\Firmware\SMIB' 'C:\TFS\CodeDiff\9.2CR\Firmware\SMIB' | Out-File 'c:\9.2dev-cr-be2.txt'
 #>
 
 
# & 'C:\Program Files\Microsoft Visual Studio 10.0\Common7\IDE\diffmerge.exe' /ignoreeol /ignorespace /noprompt C:\TFS\CodeDiff\9.2CR\Firmware\SMIB\particip.c C:\TFS\CodeDiff\9.2DEV\Firmware\SMIB\particip.c

# Check the report file to find out if exist any difference.  
<#
$be2DiffFound = "Same!"
Get-Content c:\9.2dev-cr-be2.txt | foreach{`
    if(($_ -like "*.h*") -or ($_ -like "*.c*")) {$be2DiffFound = "Diff Found, please check report!"}
    }
 #>

<#
 Get-Content c:\9.2dev-cr-be2.txt | foreach{`
    if($_ -like "*Summary*"){`
        $Summary = $_
        #Write-Host " Report summary! $Summary"
    }
} 
#> 

# Prepare the Email setting. 
$EmailTo = "me@163.com, me1@163.com"
$EmailFrom = "ADV-CodeDiffCheck@igt.com"
$SMTPSRV = "ServerIP"
$border = "1"
$bordercolor = "FFCC00"
$style = "background-color:#FFFFCC"
$width = "1000"
$cellpadding = "3"
$cellspacing = "3"

$smib_93_dev_cr = "9.3 Dev branch VS 9.3 CR branch"
$smib_92_devA_SP0 = "9.2 devA VS 9.2 SP0 HF"
$smib_92_SP0_RTM = "9.2 SP0_HF VS 9.2 SP0_RTM"
$smib_92_relmain_devA = "9.2 rel_main VS 9.2 devA"
$smib_92_relmain_devB = "9.2 rel_main VS 9.2 devB"
$smib_92_relmain_93main = "9.2 rel_main VS 9.3 main"

#$attach = "c:\9.2dev-cr-be2.txt"
<#
$body = "9.2 Dev branch VS 9.2 CR branch" + "<br />" +`
        "========================================================================" + "<br />" +`
        "$fontColor" +"$diffContent" + "$fontEnd" + "<br />" +`
        "========================================================================" + "<br />"
#>
$body = "$smib_93_dev_cr" + "<br />" +`
         
"<table border=$border bordercolor=$bordercolor style=$style width=$width cellpadding=$cellpadding cellspacing=$cellspacing>" +`
	"<tr>" +`
		"<td>" + "$fontColor" +"$diffContent93dev_cr" + "$fontEnd" + "</td>" +`
	"</tr>" +`
"</table>" +`
"$smib_92_devA_SP0" + "<br />" +`
         
"<table border=$border bordercolor=$bordercolor style=$style width=$width cellpadding=$cellpadding cellspacing=$cellspacing>" +`
	"<tr>" +`
		"<td>" + "$fontColor" +"$diffContent92devA_sp0" + "$fontEnd" + "</td>" +`
	"</tr>" +`
"</table>" +`
"$smib_92_SP0_RTM" + "<br />" +`
         
"<table border=$border bordercolor=$bordercolor style=$style width=$width cellpadding=$cellpadding cellspacing=$cellspacing>" +`
	"<tr>" +`
		"<td>" + "$fontColor" +"$diffContent92SP0_RTM" + "$fontEnd" + "</td>" +`
	"</tr>" +`
"</table>" +`
"$smib_92_relmain_devA" + "<br />" +`
         
"<table border=$border bordercolor=$bordercolor style=$style width=$width cellpadding=$cellpadding cellspacing=$cellspacing>" +`
	"<tr>" +`
		"<td>" + "$fontColor" +"$diffContent92relmain_devA" + "$fontEnd" + "</td>" +`
	"</tr>" +`
"</table>" +`
"$smib_92_relmain_devB" + "<br />" +`
         
"<table border=$border bordercolor=$bordercolor style=$style width=$width cellpadding=$cellpadding cellspacing=$cellspacing>" +`
	"<tr>" +`
		"<td>" + "$fontColor" +"$diffContent92relmain_devB" + "$fontEnd" + "</td>" +`
	"</tr>" +`
"</table>" +`
"$smib_92_relmain_93main" + "<br />" +`
         
"<table border=$border bordercolor=$bordercolor style=$style width=$width cellpadding=$cellpadding cellspacing=$cellspacing>" +`
	"<tr>" +`
		"<td>" + "$fontColor" +"$diffContent92relmain_93main" + "$fontEnd" + "</td>" +`
	"</tr>" +`
"</table>" 


# Send email.
send-SMTPmail $EmailTo $EmailFrom "BE2 Team CodeDiff Report-$(get-date -f G)" $SMTPSRV $body #$attach

