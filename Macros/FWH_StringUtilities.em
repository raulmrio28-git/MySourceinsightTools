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

macro StringConvertFromEscape(str)
{
	new_str = ""

	len = strlen(str)
	curr = 0

	while(curr<len)
	{
		if (str[curr] == "\\")
		{
			curr = curr+1
			if (curr >= len)
				return new_str
			if (str[curr] == "n")
				new_str = new_str # CharFromKey(13)
			else if (str[curr] == "t")
				new_str = new_str # CharFromKey(9)
			else if (str[curr] == "\\")
				new_str = new_str # "\\"
		}
		else
			new_str = new_str # str[curr]
		curr = curr+1
	}

	return new_str
}