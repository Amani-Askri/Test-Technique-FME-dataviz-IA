# -------------------------------
# publish_tableau.ps1
# Script PowerShell pour publier un dashboard Tableau
# -------------------------------

$ServerUrl = "https://prod-ch-a.online.tableau.com"
$SiteId    = "amaniaskri-f1a25b63ec"
$Username  = "amani.askri@iteam-univ.tn"
$Password  = "Amani.1998"

# Chemin relatif du workbook (fonctionne en local et en CI)
$LocalWorkbookPath = "Dashbord.twbx"
$ProjectName = "TestTechnique"
$WorkbookName = "Dashbord_FME_IA"


# -------------------------------
# 1. Connexion a Tableau Server
# -------------------------------
Write-Host "Connexion a Tableau Server..."
tabcmd login -s $ServerUrl -t $SiteId -u $Username -p $Password 2>&1 | Write-Host

if ($LASTEXITCODE -ne 0) {
    Write-Error "Erreur de connexion (exit code: $LASTEXITCODE)."
    exit 1
}

# -------------------------------
# 2. Publication du workbook
# -------------------------------
Write-Host "Publication du workbook..."
tabcmd publish $LocalWorkbookPath --project $ProjectName --name $WorkbookName --overwrite 2>&1 | Write-Host

if ($LASTEXITCODE -ne 0) {
    Write-Error "Erreur lors de la publication (exit code: $LASTEXITCODE)."
    exit 1
}

Write-Host "Workbook publie avec succes : $WorkbookName dans le projet $ProjectName."

# -------------------------------
# 3. Deconnexion
# -------------------------------
Write-Host "Deconnexion du serveur..."
tabcmd logout

Write-Host "Script termine."
