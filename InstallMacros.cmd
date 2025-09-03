@ECHO OFF
REM for chinese language, set codepage,,,,,,,
chcp 65001
ECHO ------------------Language select:-------------------
ECHO English (1)
ECHO 中文 (2)
ECHO -----------------------------------------------------
set /p "tmp_language=Language: "

if %tmp_language% == 1 SETX SI_LANGUAGE "EN"
if %tmp_language% == 2 SETX SI_LANGUAGE "CN"

REM ------------------config SI folder-------------------
ECHO ------------------config SI folder-------------------
SETX SI_USER_ROOT_PATH "%cd%"
REM -----------------------------------------------------

ECHO finish config.......
pause