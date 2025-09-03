/*
** ===========================================================================
**
** File: 
**     FWH_ConfigUtilities.em
**
** Description: 
**     SI config utilities
** 
** History: 
**
** when          who             what, where, why
** ----------    ------------    --------------------------------
** 2025/09/02    konakona        Created.
**
** ===========================================================================
*/

macro GetRoot()
{
	global root

	root = GetEnv("SI_USER_ROOT_PATH")

	if (root == "")
	{
		msg("No rootpath! Please run InstallMacros.cmd before using macro!" # CharFromKey(13) # "没有根路径！请在使用宏前运行InstallMacros.cmd！")
		return "NOROOT"
	}

	return root
}

macro GetTempFolder()	{return GetRoot() # "\\Temp"}
macro GetConfigFolder()		{return GetRoot() # "\\Config"}
macro GetConfigUserFolder()		{return GetRoot() # "\\Config\\User"} 
