IF NOT EXIST %USERPROFILE%\Documents\WindowsPowerShell\Modules\NuGetHelpers\ MD %USERPROFILE%\Documents\WindowsPowerShell\Modules\NuGetHelpers\
copy .\NuGetHelpers.psm1 %USERPROFILE%\Documents\WindowsPowerShell\Modules\NuGetHelpers\
copy .\NuGet_profile.ps1 %USERPROFILE%\Documents\WindowsPowerShell\