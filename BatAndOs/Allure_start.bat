@chcp 1251

cd /d ""E:\Update1cUT\Vanessa\""
call allure generate --clean .\allure-source
start """" call allure open .\allure-report -p 52888

exit