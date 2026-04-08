@echo off
title Serveur BLAST - DEP
color 0A

echo ========================================
echo    BLAST DEP - Serveur HTTP Port 8080
echo ========================================
echo.

cd /d "C:\Users\M2B PRO\Desktop\GITHUB\BLAST\CV"

echo Dossier : %cd%
echo.
echo Demarrage du serveur sur http://localhost:8080
echo Appuyez sur CTRL+C pour arreter le serveur.
echo.

python -m http.server 8080

pause