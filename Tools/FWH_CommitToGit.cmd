@ECHO OFF
REM
REM ===========================================================================
REM
REM File: 
REM     FWH_CommitToGit.cmd
REM
REM Description: 
REM     Commit to git (can add file or not)
REM 
REM History: 
REM
REM when          who             what, where, why
REM ----------    ------------    --------------------------------
REM 2025/09/03    konakona        Created.
REM
REM ===========================================================================
REM

ECHO %1 %2 %3

pause

cd /d %1

pause

if %3==1 git add .

pause

git commit -m %2

pause