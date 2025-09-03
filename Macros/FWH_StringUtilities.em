/*
** ===========================================================================
**
** File: 
**     FWH_StringUtilities.em
**
** Description: 
**     SI string utilities
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
**     StringGetLastPathItem
**
** Description: 
**     Get last path item
** 
** Input: 
**     Path
** 
** Output: 
**     Last item
** 
** Return value: 
**     strmid
** 
** Side effects:
**     None
**
** ===========================================================================
*/

macro StringGetLastPathItem(str)
{
	len = strlen(str)
	end_cut = 0

	if (str[len-1] == "\\")
	{
		end_cut = 1
		len = len - 1
	}

	while (str[len-1] != "\\")
		len = len - 1

	return strmid(str, len, strlen(str)-end_cut)
}
