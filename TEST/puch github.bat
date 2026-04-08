@echo off
chcp 65001 >nul
setlocal EnableDelayedExpansion

rem ============================================================
rem  Mise a jour GitHub : INVOOFFICE/ONOUARI
rem ============================================================

set "REPO_DIR=C:\Users\M2B PRO\Desktop\GITHUB\BLAST\CV"
set "REMOTE_URL=https://github.com/INVOOFFICE/ONOUARI.git"
set "BRANCH=main"

cd /d "%REPO_DIR%" || (
  echo [ERREUR] Dossier introuvable : %REPO_DIR%
  pause
  exit /b 1
)

where git >nul 2>&1
if errorlevel 1 (
  echo [ERREUR] Git n'est pas installe.
  pause
  exit /b 1
)

if not exist ".git" (
  echo [INFO] Initialisation du depot...
  git init
  git branch -M %BRANCH%
  git remote add origin "%REMOTE_URL%"
)

echo.
echo --- Statut ---
git status -sb
echo.

set /p COMMIT_MSG=Message commit (Enter = auto) :
if "!COMMIT_MSG!"=="" set "COMMIT_MSG=Update %date%"

git add -A

git diff --cached --quiet
if errorlevel 1 (
  git commit -m "!COMMIT_MSG!"
) else (
  echo [INFO] Rien a commit.
)

echo.
echo --- Synchronisation ---

git fetch origin

echo [INFO] Tentative de rebase...
git pull --rebase origin %BRANCH%

if errorlevel 1 (
  echo.
  echo [ATTENTION] Conflit detecte !
  echo Corrige les fichiers puis appuie sur une touche...
  pause

  git add .
  git rebase --continue

  if errorlevel 1 (
    echo [ERREUR] Rebase non termine.
    pause
    exit /b 1
  )
)

echo.
echo --- Push ---
git push -u origin %BRANCH%

if errorlevel 1 (
  echo.
  echo [ATTENTION] Push refuse -> tentative FORCE SAFE...

  git push --force-with-lease origin %BRANCH%

  if errorlevel 1 (
    echo [ERREUR] Push impossible.
    pause
    exit /b 1
  )
)

echo.
echo [OK] Depot synchronise avec succes 🚀
pause
endlocal