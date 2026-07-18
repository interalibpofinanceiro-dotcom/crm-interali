@echo off
title Instalar atalho do CRM Interali
echo Instalando o atalho do CRM Interali na sua Area de Trabalho...
echo.
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0instalar-atalho.ps1"
