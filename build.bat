rd /Q/S .gitpublic
xcopy /HEI public\\.git .gitpublic
call hexo clean
call hexo g
xcopy /HEI .gitpublic public\\.git
rd /Q/S .gitpublic
pause