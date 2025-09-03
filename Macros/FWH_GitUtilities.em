/*
** ===========================================================================
**
** File: 
**     FWH_GitUtilities.em
**
** Description: 
**     SI Git utilities
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
**     BaseCommitToGit
**
** Description: 
**     Commit to git repo
** 
** Input: 
**     Add files
** 
** Output: 
**     none
** 
** Return value: 
**     none
** 
** Side effects:
**     Git commit done to remote repo
**
** ===========================================================================
*/

macro BaseCommitToGit(add)
{
	sz = Ask("Enter reason:")
	reason = ""
	if (sz != "")
	{
		szTime = GetSysTime(1)
		Hours = szTime.Hour
		Minutes = szTime.Minute
		Day = szTime.Day
		Month = szTime.Month 
		if (Day < 10)
			szDay = "0@Day@"
		else
			szDay = Day
		if (Month < 10)
			szMonth = "0@Month@"
		else
			szMonth = Month
		if (Hours < 10)
			szHours = "0@Hours@"
		else
			szHours = Hours
		if (Minutes < 10)
			szMinutes = "0@Minutes@"
		else
			szMinutes = Minutes

		reason = "@szMonth@@szDay@ @szHours@@szMinutes@ @sz@"
	}

	ShellExecute("open", GetToolsFolder() # "\\FWH_CommitToGit.cmd", ProjectGetPath(ProjectGetName()) # " " # "\"" # reason # "\" @add@", "", 1) 
}

/*
** ===========================================================================
**
** Function:        
**     BaseCommitToGitAdd, BaseCommitToGitNoAdd
**
** Description: 
**     Shortcuts to BaseCommitToGit
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
**     Commit to git (add or not) to remote repo
**
** ===========================================================================
*/

macro BaseCommitToGitAdd()
{
	BaseCommitToGit(1)
}

macro BaseCommitToGitNoAdd()
{
	BaseCommitToGit(0)
}