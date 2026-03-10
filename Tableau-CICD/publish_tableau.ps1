# -------------------------------
# publish_tableau_local.ps1
# Script PowerShell pour publier un dashboard Tableau
# -------------------------------

#  Détails de connexion Tableau
$ServerUrl = "https://prod-ch-a.online.tableau.com"
$SiteId = "amaniaskri-f1a25b63ec"
$Username = "amani.askri@iteam-univ.tn"
$Password = "Amani.1998"

#  Détails du workbook
$LocalWorkbookPath = "C:\Test-Technique-FME-dataviz-IA\Dashbord.twbx"
$ProjectName = "TestTechnique"
$WorkbookName = "Dashbord_FME_IA"

# -------------------------------
# 1 Connexion à Tableau Server
# -------------------------------
Write-Host "Connexion à Tableau Server..."
tabcmd login -s $ServerUrl -t $SiteId -u $Username -p $Password

if ($LASTEXITCODE -ne 0) {
    Write-Error "Erreur de connexion. Vérifie le serveur ou le mot de passe."
    exit 1
}

# -------------------------------
# 2️ Publication du workbook
# -------------------------------
Write-Host "Publication du workbook..."
tabcmd publish $LocalWorkbookPath --project $ProjectName --name $WorkbookName --overwrite

if ($LASTEXITCODE -ne 0) {
    Write-Error "Erreur lors de la publication. Vérifie le chemin du fichier et le projet."
    exit 1
}

Write-Host "✔ Workbook publié avec succès : $WorkbookName dans le projet $ProjectName."

# -------------------------------
# 3️ Déconnexion
# -------------------------------
Write-Host "Déconnexion du serveur..."
tabcmd logout

Write-Host "Script terminé."