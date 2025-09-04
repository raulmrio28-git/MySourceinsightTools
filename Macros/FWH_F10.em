/*
** ===========================================================================
**
** File: 
**     FWH_F10.em
**
** Description: 
**     SI F10 key macro (Git)
** 
** History: 
**
** when          who             what, where, why
** ----------    ------------    --------------------------------
** 2025/09/04    konakona        Created.
**
** ===========================================================================
*/

macro fwh_si_f10()
{
	key2 = GetKey()
	if (key2 == 121 || key2 == 89) //commit with add files
		BaseCommitToGitAdd()	
	else if (key2 == 110 || key2 == 78)
		BaseCommitToGitNoAdd()
	else if (key2 == 104 || key2 == 72)
		GetHelp("Git")
}

