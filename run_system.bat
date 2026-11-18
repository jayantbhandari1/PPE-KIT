@echo off
title AI PPE Compliance Monitoring System - Production Launcher
color 0A

echo ======================================================================
echo    AI-Based PPE Kit Compliance Monitoring System (Company Setup)
echo ======================================================================
echo.

echo [1/3] Checking Python ^& Node.js environment...
where python >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERROR] Python is not installed or not in PATH!
    pause
    exit /b
)

where node >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERROR] Node.js is not installed or not in PATH!
    pause
    exit /b
)

echo [2/3] Starting Python Flask AI Backend Server (Port 5000)...
if exist "%~dp0backend\venv\Scripts\python.exe" (
    start "PPE Backend (Python Flask + YOLO)" cmd /k "cd /d %~dp0backend && venv\Scripts\python.exe app.py"
) else (
    start "PPE Backend (Python Flask + YOLO)" cmd /k "cd /d %~dp0backend && python app.py"
)

echo [3/3] Starting React Frontend Dashboard (Port 5173)...
start "PPE Frontend (React Dashboard)" cmd /k "cd /d %~dp0frontend && npm run dev -- --host"

echo.
echo ======================================================================
echo [SUCCESS] Both Services Launched!
echo.
echo  - Local Dashboard:      http://localhost:5173
echo  - Backend API:          http://localhost:5000
echo.
echo Default Role-Based Logins:
echo  - Super Admin:      admin@ppe.com      / Admin@123      (-^> /admin/dashboard)
echo  - Zone Supervisor:  supervisor@ppe.com / Supervisor@123 (-^> /supervisor/dashboard)
echo  - Chem Supervisor:  pooja@ppe.com      / Supervisor@123 (-^> /supervisor/dashboard)
echo ======================================================================
echo.
timeout /t 5 /nobreak >nul 2>&1 || ping -n 6 127.0.0.1 >nul
start http://localhost:5173
