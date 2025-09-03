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

macro ProjectGetValue(projectname,val)
{
	if (IsIniSectionExist("User_Projects.ini", projectname) == 0)
	{
		UtilitiesShowMessage("PROJECT_NOT_EXISTING")	
		stop
	}

	t = GetIniSectionValue("User_Projects.ini", projectname, val)
	return t
}

macro ProjectGetType(projectname)
{
	temp = ProjectGetValue(projectname, "Type")
	if (temp == "")
		return "None"
	return temp
}

macro ProjectGetPath(projectname)
{
	temp = ProjectGetValue(projectname, "Path") 
	return temp
}

