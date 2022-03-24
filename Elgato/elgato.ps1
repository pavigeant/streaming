function Stop-ElgatoKeyLight {
    [CmdletBinding(SupportsShouldProcess)]
    param (
        [Parameter(Mandatory, ValueFromPipeline)]
        [ipaddress[]]
        $Address
    )

    begin {
        $body = @{
            numberOfLights = 1
            lights         = @(
                @{
                    on = 0
                }
            )
        }
    }

    process {
        foreach ($a in $Address) {
            $params = @{
                Uri    = "http://$($ip):9123/elgato/lights"
                Method = "Put"
                Body   = $body | ConvertTo-Json
            }
            
            if ($PSCmdlet.ShouldProcess($a, "Turning off light")) {
                Invoke-RestMethod @params
            }
        }
    }
}

"192.168.1.139" | Stop-ElgatoKeyLight -WhatIf