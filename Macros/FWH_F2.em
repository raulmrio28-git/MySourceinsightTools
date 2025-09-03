/*
** ===========================================================================
**
** File: 
**     FWH_F2.em
**
** Description: 
**     F2 key handler (open project main folder)
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
**     fwh_si_f2
**
** Description: 
**     Open project main folder
** 
** Input: 
**     none
** 
** Output: 
**     none
** 
** Return value: 
**     none
** 
** Side effects:
**     Open explorer at project main folder
**
** ===========================================================================
*/

macro fwh_si_f2()
{
	pname = ProjectGetName()
	ppath = ProjectGetPath(pname)

	if (ppath != "")
		ShellExecute("explore", ppath, "", "", 1)
}
