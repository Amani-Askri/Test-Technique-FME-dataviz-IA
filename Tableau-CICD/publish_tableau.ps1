# -------------------------------
# publish_tableau.ps1
# Script PowerShell pour publier un dashboard Tableau
# -------------------------------

# Connexion via variables d'environnement (GitHub Secrets)
$ServerUrl = $env:TABLEAU_SERVER
$SiteId    = $env:TABLEAU_SITE
$Username  = $env:TABLEAU_USER
$Password  = $env:TABLEAU_PASSWORD

# Chemin relatif du workbook (fonctionne en local et en CI)
$LocalWorkbookPath = "Dashbord.twbx"
$ProjectName = "TestTechnique"
$WorkbookName = "Dashbord_FME_IA"

# Validation des variables
if (-not $ServerUrl -or -not $Username -or -not $Password) {
    Write-Error "Variables d'environnement manquantes (TABLEAU_SERVER, TABLEAU_USER, TABLEAU_PASSWORD)."
    exit 1
}

# -------------------------------
# 1. Connexion a Tableau Server
# -------------------------------
Write-Host "Connexion a Tableau Server..."
tabcmd login -s $ServerUrl -t $SiteId -u $Username -p $Password

if ($LASTEXITCODE -ne 0) {
    Write-Error "Erreur de connexion. Verifie le serveur ou le mot de passe."
    exit 1
}

# -------------------------------
# 2. Publication du workbook
# -------------------------------
Write-Host "Publication du workbook..."
tabcmd publish $LocalWorkbookPath --project $ProjectName --name $WorkbookName --overwrite

if ($LASTEXITCODE -ne 0) {
    Write-Error "Erreur lors de la publication. Verifie le chemin du fichier et le projet."
    exit 1
}

Write-Host "Workbook publie avec succes : $WorkbookName dans le projet $ProjectName."

# -------------------------------
# 3. Deconnexion
# -------------------------------
Write-Host "Deconnexion du serveur..."
tabcmd logout

Write-Host "Script termine."
