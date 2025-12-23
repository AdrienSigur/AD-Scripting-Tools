[CmdletBinding()] # <--- La ligne magique qui transforme le script en Cmdlet
param(
    # Premier paramètre : Obligatoire.
    # Si le user ne le met pas, PowerShell lui demandera tout seul !
    [Parameter(Mandatory=$true, HelpMessage="Veuillez entrer le nom de l'utilisateur")]
    [string]$NomUtilisateur,

    # Deuxième paramètre : Optionnel, avec une valeur par défaut
    [string]$Action = "Lister",

    # Troisième paramètre : Un "switch" (vrai/faux, comme -Force)
    [switch]$Force
)

# --- Ton code commence ici ---

Write-Host "Traitement de l'utilisateur : $NomUtilisateur" -ForegroundColor Cyan

if ($Force) {
    Write-Host "Mode FORCE activé !" -ForegroundColor Red
}

Write-Host "Action choisie : $Action"