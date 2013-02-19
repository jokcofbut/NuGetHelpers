function Force-Update-Package([string]$Id, [string]$Version, [Switch]$IncludePrerelease, [string]$Source, [string]$ProjectName)
{
	if($ProjectName)
	{
		$projects = $projects = Get-Project $ProjectName
	}
	else
	{
		$projects = Get-Project -All
	}
	
	if($Version)
	{
		$newPackage = Get-Package $Id -ListAvailable -AllVersions -IncludePrerelease -Source $Source | Where-Object { $_.Id -eq $Id -and $_.Version -eq $Version }
		$packageNotFoundError = ('A package with Id "' + $Id + '" with version number "' + $Version + '" was not found in repository "' + $Source + '"')
	}
	else
	{
		$newPackage = Get-Package $Id -ListAvailable -AllVersions -IncludePrerelease -Source $Source | Where-Object { $_.Id -eq $Id}
		$packageNotFoundError = ('A package with Id "' + $Id + '" was not found in repository "' + $Source + '"')
	}
	
	if(!$newPackage)
	{
		Throw $packageNotFoundError
	}
	
	foreach($project in $projects)
	{
  		$package = Get-Package -ProjectName $project.ProjectName -ErrorAction SilentlyContinue | Where-Object { $_.Id -eq $Id }
		if($package -ne $null)
		{
			write-host '---'
			write-host ('Uninstalling from {0}' -f $project.ProjectName)
			Uninstall-Package $Id -ProjectName $project.ProjectName -Force 
			
			write-host ('Installing to {0}' -f $project.ProjectName)
			
			if($Version)
			{
				Install-Package $Id -ProjectName $project.ProjectName -Version $Version -IncludePrerelease:$IncludePrerelease -Source $Source
			}
			else
			{
				Install-Package $Id -ProjectName $project.ProjectName -IncludePrerelease:$IncludePrerelease -Source $Source
			}
			
			write-host '---'
		}
	}
}

Export-ModuleMember Force-Update-Package