/*
** ===========================================================================
**
** File: 
**     FWH_HelpUtilities.em
**
** Description: 
**     SI help utilities
** 
** History: 
**
** when          who             what, where, why
** ----------    ------------    --------------------------------
** 2025/09/04    konakona        Created.
**
** ===========================================================================
*/

/*
** ===========================================================================
**
** Function:        
**     GetHelp
**
** Description: 
**     Get help of specific key
** 
** Input: 
**     Name of key
** 
** Output: 
**     Help contents
** 
** Return value: 
**     none
** 
** Side effects:
**     Temp ini buffer modified/created
**
** ===========================================================================
*/

macro GetHelp(name)
{
	line = 0
	while(true)
	{
		line1 = line+1
		a = GetIniSectionValue("Help_@name@.ini", name, "HelpMsg" # line1, 0)
		if (a=="")
			break
		msg(StringConvertFromEscape(a))
		line = line+1
	}
}
