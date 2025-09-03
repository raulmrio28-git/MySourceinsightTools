/*
** ===========================================================================
**
** File: 
**     FWH_ProjectUtilities.em
**
** Description: 
**     SI project utilities
** 
** History: 
**
** when          who             what, where, why
** ----------    ------------    --------------------------------
** 2025/09/03    konakona        Created.
**
** ===========================================================================
*/

/*
** ===========================================================================
**
** Function:        
**     ProjectGetName
**
** Description: 
**     Get curr project name
** 
** Input: 
**     none
** 
** Output: 
**     Last item of currproj path
** 
** Return value: 
**     See output
** 
** Side effects:
**     None
**
** ===========================================================================
*/

macro ProjectGetName()
{
	return StringGetLastPathItem(GetProjName(GetCurrentProj()))
}

/*
** ===========================================================================
**
** Function:        
**     ProjectGetValue
**
** Description: 
**     Get value of project in INI
** 
** Input: 
**     Project name, value
** 
** Output: 
**     Data of project info value
** 
** Return value: 
**     t
** 
** Side effects:
**     Create a temp buffer
**
** ===========================================================================
*/

macro ProjectGetValue(projectname,val)
{
	tmp = IsIniSectionExist("User_Projects.ini", projectname, 0)
	if (tmp == 0)
	{
		UtilitiesShowMessage("PROJECT_NOT_EXISTING", projectname, 1)	
		return ""
	}

	t = GetIniSectionValue("User_Projects.ini", projectname, val, 0)
	return t
}

/*
** ===========================================================================
**
** Function:        
**     ProjectGetType
**
** Description: 
**     Get type of project
** 
** Input: 
**     Project name
** 
** Output: 
**     Type of project
** 
** Return value: 
**     temp
** 
** Side effects:
**     Create a temp buffer
**
** ===========================================================================
*/

macro ProjectGetType(projectname)
{
	temp = ProjectGetValue(projectname, "Type")
	if (temp == "")
		return "None"
	return temp
}

/*
** ===========================================================================
**
** Function:        
**     ProjectGetPath
**
** Description: 
**     Get path of project
** 
** Input: 
**     Project path
** 
** Output: 
**     Path of project
** 
** Return value: 
**     temp
** 
** Side effects:
**     Create a temp buffer
**
** ===========================================================================
*/

macro ProjectGetPath(projectname)
{
	temp = ProjectGetValue(projectname, "Path") 
	return temp
}

