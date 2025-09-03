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
	tmp = IsIniSectionExist("User_Projects.ini", projectname, 0)
	if (tmp == 0)
	{
		UtilitiesShowMessage("PROJECT_NOT_EXISTING", projectname, 1)	
		return ""
	}

	t = GetIniSectionValue("User_Projects.ini", projectname, val, 0)
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

