**Turn off your Elgato Keylight when shutting down your PC**

For those who have an Elgato Keylight and who keep forgetting to turn it off before shutting down the PC, here is a solution

It is mandatory to use the Windows Group Policies in order to add a shutdown script.

**Script creation**

You must create a PowerShell Script somewhere on your disks, give it a name of your choice, but you need the extension `ps1`.

For example: `c:\scripts\elgato.ps1`

> The recommended location is `C:\Windows\System32\GroupPolicy\Machine\Scripts\Shutdown`, but it requires administrative access.

Create the file with your favorite editor and paste the following script.

```powershell
$ip = "192.168.xxx.xxx"

$body = @{
    numberOfLights = 1
    lights         = @(
        @{
            on = 0
        }
    )
}

$params = @{
    Uri    = "http://$($ip):9123/elgato/lights"
    Method = "Put"
    Body   = $body | ConvertTo-Json
}

Invoke-RestMethod @params
```

The IP address must be equals to the address of your Elgato KeyLight. You can see it in the *Control Center*.

**Assigning the script**

> :warning: Adding a shutdown script requires changing a *group policy*. This powerful tool allows you to configure your PC. Invalid changes could corrupt your Windows installation.

1. Launch the *Local Group Policy Editor* by searching for `Group Policy` in the start menu.
2. Navigate to the node *Computer Configuration \ Windows Settings \ Scripts (Startup/Shutdown)*.
3. Double-click on Shutdown Shutdown
4. Go to the *PowerShell Scripts* tab.
5. Click on *Add* and then click on *Browse*.
6. Navigate to the location of your previously created script, select it and click on *Open*.
7. Click *OK* and close the *Local Group Policy Editor*.