/*
** ===========================================================================
**
** File: 
**     FWH_BaseUtilities.em
**
** Description: 
**     SI base project files utilities
** 
** History: 
**
** when          who             what, where, why
** ----------    ------------    --------------------------------
** 2025/09/03    konakona        Created.
**
** ===========================================================================
*/

macro BaseWriteReason()
{
	sz = Ask("Enter reason:")
	if (sz != "")
	{
		szTime = GetSysTime(1)
		Hours = szTime.Hour
		Minutes = szTime.Minute
		Day = szTime.Day
		Month = szTime.Month
		Year = szTime.Year
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
		hwnd = GetCurrentWnd()
		lnFirst = GetWndSelLnFirst(hwnd)
		lnLast = GetWndSelLnLast(hwnd)
		hbuf = GetCurrentBuf()
		// get line the selection (insertion point) is on
		szLine = GetBufLine(hbuf, lnFirst - 1);
		chTab = CharFromAscii(9)
		// prepare a new indented blank line to be inserted.
		// keep white space on left and add a tab to indent.
		// this preserves the indentation level.
		i = 0 /* loop control */
		ich = ""
		while (szLine[i] == " " || szLine[i] == chTab)
		{
			ich = Cat(ich, szLine[i])
			i = i + 1
		}

		InsBufLine(hbuf, lnFirst, "@ich@//@Year@@szMonth@@szDay@ @szHours@@szMinutes@ - @sz@")
	}
}

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

	ShellExecute("open", GetToolsFolder() # "\\FWH_CommitToGit.cmd", ProjectGetPath(ProjectGetName()) # " " # "\"" # sz # "\" @add@", "", 0) 
}

macro BaseCommitToGitAdd()
{
	BaseCommitToGit(1)
}

macro BaseCommitToGitNoAdd()
{
	BaseCommitToGit(0)
}

