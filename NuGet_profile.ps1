$HelperModuleName = 'NuGetHelpers'

if((Get-Module -name $HelperModuleName)) 
{
	Remove-Module $HelperModuleName
}

if(Get-Module -ListAvailable | Where-Object { $_.name -eq $HelperModuleName }) 
{ 
	Import-Module NuGetHelpers
}