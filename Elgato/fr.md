**Éteindre une lumière Elgato Keylight à la fermeture de votre PC**

Pour ceux qui ont une Elgato Keylight et qui oublient de l'éteindre par le Control Center avant d'éteindre leur PC, j'ai trouvé une méthode pour que la lumière s'éteigne au shutdown de l'ordinateur.

Il est nécessaire d'utiliser les Group Policy de Windows afin d'ajouter un script de shutdown.

**Création du script**

Vous devez créer un script PowerShell à un endroit sur votre disque et nommez-le du nom que vous voulez, mais vous devez avoir l'extension `ps1`.

Par exemple: `c:\scripts\elgato.ps1`

> L'endroit recommandé est `C:\Windows\System32\GroupPolicy\Machine\Scripts\Shutdown`, mais cet emplacement nécessite des accès administrateurs.

Créer le fichier votre éditeur favori et copiez le script suivant dans le fichier.

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

L'adresse IP doit correspondre à l'adresse de votre lumière Elgato. Elle est disponible dans le *Control Center*.

**Assignation du script**

> :warning: L'ajout d'un script au shutdown du PC nécessite un *group policy*. Cet outil permet de configurer des options puissantes sur votre PC. De mauvaises manipulations pourraient rendre Windows instable.


1. Lancez le *Local Group Policy Editor* en cherchant pour `Group Policy` dans le menu démarrer.
2. Naviguez sur le noeud *Computer Configuration \ Windows Settings \ Scripts (Startup/Shutdown)*.
3. Double-cliquez sur l'item Shutdown
4. Allez sur l'onglet *PowerShell Scripts*.
5. Appuyez sur le bouton *Add* et ensuite sur *Browse*.
6. Naviguez à l'emplacement du script que vous avez créé précédemment, choisissez le fichier et faite *Open*.
7. Faites *OK* et fermez le *Local Group Policy Editor*.