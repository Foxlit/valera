@chcp 1251

cd /d ""E:\Update1cUT\Vanessa\allure-source\""
del /Q *.*

"C:\Program Files\1cv8\8.3.22.1704\bin\1cv8c" /N"eremin" /P"Tb4m8443df" /TestManager /Execute "E:\Update1cUT\Vanessa\vanessa-automation\vanessa-automation.epf" /IBConnectionString "Srvr=""SRV-1C-DEV"";Ref=""trade11_test"";" /C"StartFeaturePlayer;QuietInstallVanessaExt;VAParams=E:\Update1cUT\Vanessa\vanessa-automation\SmokeTests\VAParams.json"

cd /d ""E:\Update1cUT\Vanessa\""

exit