/*
** ===========================================================================
**
** File: 
**     FWH_SearchUtilities.em
**
** Description: 
**     SI search utilities
** 
** History: 
**
** when          who             what, where, why
** ----------    ------------    --------------------------------
** 2025/09/02    konakona        Created.
**
** ===========================================================================
*/

/*
** ===========================================================================
**
** Function:        
**     FindString
**
** Description: 
**     Return offset of target string in source string
** 
** Input: 
**     source - source str, target - target str
** 
** Output: 
**     Offset of target string in source string
** 
** Return value: 
**     cnt/"X"
** 
** Side effects:
**     None
**
** ===========================================================================
*/

macro FindString( source, target )
{
	source_len = strlen( source )
	target_len = strlen( target )


	match = 0
	cnt = 0


	while( cnt < source_len )
	{
		while( cnt < source_len )
		{
			if( source[cnt] == target[0] )
				break
			else
				cnt = cnt + 1
		}

		if( cnt == source_len )
		    break;
		
		k = cnt
		j = 0
		while( j < target_len && source[k] == target[j] )
		{
			k = k + 1
			j = j + 1
		}
		
		if (j == target_len)
		{
			match = 1
			break
		}
		
		cnt = cnt + 1
	}

	if( match )
		return cnt
	else
		return "X"
}

/*
** ===========================================================================
**
** Function:        
**     SearchBackward
**
** Description: 
**     Search selection backwards in file
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
**     Go to previous encounter of sel. str. (if available)
**
** ===========================================================================
*/

macro SearchBackward()
{
	var line_count
	var max_len
	var sel
	var isCircle

	isCircle = True
	
	hbuf = GetCurrentBuf()
	hwnd = GetCurrentWnd()
	if (hwnd == 0)
		stop

	sel = GetWndSel(hbuf)
	row = sel.lnFirst
	column = sel.ichFirst
	
	SearchBackwardSel(hbuf, sel)
	
	sel = GetWndSel(hbuf)
	row_new = sel.lnFirst
	column_new = sel.ichFirst
	
	if(row_new == row && column_new == column){
		line_count = GetBufLineCount(hbuf)
		last_line = GetBufLine(hbuf, line_count-1)
		max_len = strlen(last_line)-1
		
		sel.ichFirst = max_len
		sel.ichLim = max_len
		sel.lnFirst = line_count
		sel.lnLast = line_count
		SetWndSel(hwnd, sel)
		
		Search_Backward
	}
}

/*
** ===========================================================================
**
** Function:        
**     SearchBackwardSel
**
** Description: 
**     Search selection backwards in file (subutil of SearchBackward)
** 
** Input: 
**     hbuf - buffer, sel - selection
** 
** Output: 
**     none
** 
** Return value: 
**     none
** 
** Side effects:
**     Load search pattern of cur. sel. (if one line + has selected something)
**
** ===========================================================================
*/

macro SearchBackwardSel(hbuf, sel)
{
	if (sel.ichFirst != sel.ichLim && sel.lnFirst == sel.lnLast)
	{
		cur_line = GetBufLine(hbuf, sel.lnFirst )
		if(sel.ichLim > strlen(cur_line))
		{
			sel.ichLim = strlen(cur_line)
		}
		if(sel.ichFirst == sel.ichLim)
			stop
		cur_sel = strmid(cur_line, sel.ichFirst, sel.ichLim)

		isSolid = FindString(cur_sel, ".")
		if(isSolid != "X")
		{
			LoadSearchPattern("@cur_sel@", false, false, false);
		}
		else
		{
			LoadSearchPattern("@cur_sel@", false, true, false);
		}
		
	}
	Search_Backward
}

/*
** ===========================================================================
**
** Function:        
**     SearchForward
**
** Description: 
**     Search selection forwards in file
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
**     Go to next encounter of sel. str. (if available)
**
** ===========================================================================
*/

macro SearchForward()
{
	var line_count
	var max_len
	var sel
	var isCircle

	isCircle = True
	
	hbuf = GetCurrentBuf()
	hwnd = GetCurrentWnd()
	if (hwnd == 0)
		stop

	sel = GetWndSel(hbuf)
	row = sel.lnFirst
	column = sel.ichFirst
	
	SearchForwardSel(hbuf, sel)
	
	sel = GetWndSel(hbuf)
	row_new = sel.lnFirst
	column_new = sel.ichFirst
	
	if(row_new == row && column_new == column){
		line_count = GetBufLineCount(hbuf)
		last_line = GetBufLine(hbuf, line_count-1)
		max_len = strlen(last_line)-1
		
		sel.ichFirst = 0
		sel.ichLim = 0
		sel.lnFirst = 0
		sel.lnLast = 0
		SetWndSel(hwnd, sel)
		
		Search_Forward
	}
}

/*
** ===========================================================================
**
** Function:        
**     SearchForwardSel
**
** Description: 
**     Search selection forwards in file (subutil of SearchForward)
** 
** Input: 
**     hbuf - buffer, sel - selection
** 
** Output: 
**     none
** 
** Return value: 
**     none
** 
** Side effects:
**     Load search pattern of cur. sel. (if one line + has selected something)
**
** ===========================================================================
*/

macro SearchForwardSel(hbuf, sel)
{
	if (sel.ichFirst != sel.ichLim && sel.lnFirst == sel.lnLast)
	{
		cur_line = GetBufLine(hbuf, sel.lnFirst )
		if(sel.ichLim > strlen(cur_line))
		{
			sel.ichLim = strlen(cur_line)
		}
		if(sel.ichFirst == sel.ichLim)
			stop
		cur_sel = strmid(cur_line, sel.ichFirst, sel.ichLim)

		isSolid = FindString(cur_sel, ".")
		if(isSolid != "X")
		{
			LoadSearchPattern("@cur_sel@", false, false, false);
		}
		else
		{
			LoadSearchPattern("@cur_sel@", false, true, false);
		}
		
	}
	Search_Forward
}

