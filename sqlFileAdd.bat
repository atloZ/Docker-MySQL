@echo off
::cd .\db\sqlFile\
for /F %%a in ('dir .\db\sqlFile\ /b/a:-d') do set lastdir=%%a
for /f "tokens=1 delims=." %%b in ("%lastdir%") Do (
        set lastdir=%%b
)
echo %lastdir%

docker exec -it mysql-container sh -c "mysql -uroot -proot -e 'CREATE DATABASE IF NOT EXISTS %lastdir%;'"
docker exec -it mysql-container sh -c "mysql -uroot -proot %lastdir%<sqlFile/%lastdir%.sql"
move .\db\sqlFile\%lastdir%* .\db\sqlFile\used\
pause