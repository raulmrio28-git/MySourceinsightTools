/*
** ===========================================================================
**
** File:        
**     FWH_FileUtilities.em
**
** Description: 
**     SI file utilities
** 
** History: 
**
** when          who             what, where, why
** ----------    ------------    --------------------------------
** 2025-09-02    konakona        Move to fileutilities.em
** 2025-01-10    konakona        Fix month to string error
** 2024-11-10    konakona        Add new macro (InsEditReasonCommentMkf)
** 2024-11-09    konakona        Add new macro (InsEditReasonComment)
** 2024-11-07    konakona        Created.
**
** ===========================================================================
*/

/*
** ===========================================================================
**
** Function:        
**     InsFileHeader
**
** Description: 
**     Inserts file header
** 
** Input: 
**     Your name, description
** 
** Output: 
**     File header
** 
** Return value: 
**     none
** 
** Side effects:
**     File overwritten
**
** ===========================================================================
*/

macro InsFileHeader()
{

	 // Get current time
	 szTime = GetSysTime(1)
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

	 hBuf = GetCurrentBuf()
	 szpathName = GetBufName(hBuf)
	 szfileName = GetFileName(szpathName)
	 szMyName = Ask("Enter your name...:")
	 szDescription = Ask("Enter the description of file:")

	 nlength = StrLen(szMyName)
	 if (nLength > 12)
	 	szFixMyName = strtrunc(szMyName, 12)
	 else
	 	while(StrLen(szMyName) < 12)
	 		szMyName = szMyName # " "
	 	szFixMyName = szMyName
	 	

	 hbuf = GetCurrentBuf()
	 // begin assembling the title string
	 InsBufLine(hbuf, 0, "/*")
	 InsBufLine(hbuf, 1, "** ===========================================================================")
	 InsBufLine(hbuf, 2, "**")
	 InsBufLine(hbuf, 3, "** File: ")
	 InsBufLine(hbuf, 4, "**     @szfileName@")
	 InsBufLine(hbuf, 5, "**")
	 InsBufLine(hbuf, 6, "** Description: ")
	 InsBufLine(hbuf, 7, "**     @szDescription@")
	 InsBufLine(hbuf, 8, "** ")
	 InsBufLine(hbuf, 9, "** History: ")
	 InsBufLine(hbuf, 10, "**")
	 InsBufLine(hbuf, 11, "** when          who             what, where, why")
	 InsBufLine(hbuf, 12, "** ----------    ------------    --------------------------------")
	 InsBufLine(hbuf, 13, "** @Year@/@szMonth@/@szDay@    @szFixMyName@    Created.")
	 InsBufLine(hbuf, 14, "**")
	 InsBufLine(hbuf, 15, "** ===========================================================================")
	 InsBufLine(hbuf, 16, "*/")
	 InsBufLine(hbuf, 17, "")
	 
}

/*
** ===========================================================================
**
** Function:        
**     InsFunHeader
**
** Description: 
**     Inserts function header
** 
** Input: 
**     Description, input, output, return, side effects
** 
** Output: 
**     Function header
** 
** Return value: 
**     none
** 
** Side effects:
**     File overwritten
**
** ===========================================================================
*/

macro InsFunHeader()
{
	 // Get a handle to the current file buffer and the name
	 // and location of the current symbol where the cursor is.
	 hbuf = GetCurrentBuf()
	 szFunc = GetCurSymbol()
	 ln = GetSymbolLine(szFunc)

	 szDescription = Ask("Enter the description of function:")
	 szInp = Ask("Enter the input:")
	 szOutp = Ask("Enter the output:")
	 szRet = Ask("Enter the return value:")
	 szSide = Ask("Enter the size effects:")

	 // begin assembling the title string
	 sz = "/*"
	 InsBufLine(hbuf, ln, sz)
	 InsBufLine(hbuf, ln + 1, "** ===========================================================================")
	 InsBufLine(hbuf, ln + 2, "**")
	 InsBufLine(hbuf, ln + 3, "** Function:        ")
	 InsBufLine(hbuf, ln + 4, "**     @szFunc@")
	 InsBufLine(hbuf, ln + 5, "**")
	 InsBufLine(hbuf, ln + 6, "** Description: ")
	 InsBufLine(hbuf, ln + 7, "**     @szDescription@")
	 InsBufLine(hbuf, ln + 8, "** ")
	 InsBufLine(hbuf, ln + 9, "** Input: ")
	 InsBufLine(hbuf, ln + 10, "**     @szInp@")
	 InsBufLine(hbuf, ln + 11, "** ")
	 InsBufLine(hbuf, ln + 12, "** Output: ")
	 InsBufLine(hbuf, ln + 13, "**     @szOutp@")
	 InsBufLine(hbuf, ln + 14, "** ")
	 InsBufLine(hbuf, ln + 15, "** Return value: ")
	 InsBufLine(hbuf, ln + 16, "**     @szRet@")
	 InsBufLine(hbuf, ln + 17, "** ")
	 InsBufLine(hbuf, ln + 18, "** Side effects:")
	 InsBufLine(hbuf, ln + 19, "**     @szSide@")
	 InsBufLine(hbuf, ln + 20, "**")
	 InsBufLine(hbuf, ln + 21, "** ===========================================================================")
	 InsBufLine(hbuf, ln + 22, "*/")
	 InsBufLine(hbuf, ln + 23, "")
}

/*
** ===========================================================================
**
** Function:        
**     CutWord
**
** Description: 
**     Cuts words to a specific length
** 
** Input: 
**     nCurLine - current line, szInf - string
** 
** Output: 
**     Cut words by LENGTH characters max
** 
** Return value: 
**     none
** 
** Side effects:
**     missing bits
**
** ===========================================================================
*/

macro CutWord(ncurLine, szInf)
{
	 LENGTH = 63
	 nlength = StrLen(szInf)
	 i = 0 /* loop control */
	 begin = 0 /* first character's index of current line */
	 pre = 0 /* preceding word's index */
	 hbuf = GetCurrentBuf()
	// nline = GetBufLnCur()
	 while (i < nlength)
	 {
	/* remove by t357
	  nrow = 0
	  sz = ""
	  while (nrow < 80)
	  {
	   if (nlength < 0)
	    break
	   sz = Cat(sz, szInf[nrow])
	   nrow = nrow + 1
	   nlength = nlength - 1
	  }
	  InsBufLine(hbuf, nline, sz)
	  szInf = szInf[nrow]
	 }
	*/
        c = szInf[i]
        if (" " == @c@ && (i - b < LENGTH))
        {
            pre = i
        }
        else if (" " == @c@)
        {
            szOutput = ""
            k = begin /* loop control */
            while (k < pre)
            {
                szOutput = Cat(szOutput, szInf[k])
                k = k + 1
            }
            InsBufLine(hbuf, ncurLine, sz)
            ncurLine = ncurLine + 1
            begin = pre
        }
        i = i + 1
    }
    if (h != i - 1)
    {
        szOutput = ""
        k = begin /* loop control */
        while (k < pre)
        {
            szOutput = Cat(szOutput, szInf[k])
            k = k + 1
        }
        InsBufLine(hbuf, ncurLine, sz)
        ncurLine = ncurLine + 1
    }
}

/*
** ===========================================================================
**
** Function:        
**     GetFileName
**
** Description: 
**     Gets current file name
** 
** Input: 
**     pathName - full path
** 
** Output: 
**     File name
** 
** Return value: 
**     name
** 
** Side effects:
**     none
**
** ===========================================================================
*/

macro GetFileName(pathName)
{
	 nlength = strlen(pathName)
	 i = nlength - 1
	 name = ""
	 while (i + 1)
	 {
	  ch = pathName[i]
	  if ("\\" == "@ch@" || "/" == "@ch@")
	   break
	  i = i - 1
	 }
	 i = i + 1
	 while (i < nlength)
	 {
	  name = cat(name, pathName[i])
	  i = i + 1
	 }

	 return name
}

/*
** ===========================================================================
**
** Function:        
**     ReturnTrueOrFalse
**
** Description: 
**     Write T/F return message
** 
** Input: 
**     none
** 
** Output: 
**     return True or False
** 
** Return value: 
**     none
** 
** Side effects:
**     written return
**
** ===========================================================================
*/

macro ReturnTrueOrFalse()
{
	 szReturns = "True if successful or False if errors."
	 hbuf = GetCurrentBuf()
	 ln = GetBufLnCur(hbuf)
	 szCurLine = GetBufLine(hbuf, ln)
	 DelBufLine(hbuf, ln)
	 InsBufLine(hbuf, ln, "@szCurLine@@szReturns@")
	 SetBufIns(hbuf, ln, StrLen(szReturns) + StrLen(szCurLine) + 3)
}

/*
** ===========================================================================
**
** Function:        
**     InsHeaderDef
**
** Description: 
**     Inserts header definition of name
** 
** Input: 
**     none
** 
** Output: 
**     Header form of filename
** 
** Return value: 
**     none
** 
** Side effects:
**     Written filename in header form
**
** ===========================================================================
*/

macro InsHeaderDef()
{
	 hBuf = GetCurrentBuf()
	 szpathName = GetBufName(hBuf)
	 szfileName = GetFileName(szpathName)
	 szfileName = toupper(szfileName)
	 nlength = StrLen(szfileName)
	 i = 0 /* loop control */
	 szdefineName = ""
	 while (i < nlength)
	 {
	  if (szfileName[i] == ".")
	   szdefineName = Cat(szdefineName, "_")
	  else
	   szdefineName = Cat(szdefineName, szfileName[i])
	  i = i + 1
	 }
	 szdefineName = Cat("_", szdefineName)
	 szdefineName = Cat(szdefineName, "_")
	 IfdefineSz(szdefineName)
}


/*
** ===========================================================================
**
** Function:        
**     PrintDate
**
** Description: 
**     Prints date
** 
** Input: 
**     none
** 
** Output: 
**     Date
** 
** Return value: 
**     none
** 
** Side effects:
**     File overwritten
**
** ===========================================================================
*/

macro PrintDate()
{
	 szTime = GetSysTime(1)
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
	 hbuf = GetCurrentBuf()
	 ln = GetBufLnCur(hbuf)
	 szCurLine = GetBufLine(hbuf, ln)
	 DelBufLine(hbuf, ln)
	 InsBufLine(hbuf, ln, "@szCurLine@ @Year@/@szMonth@/@szDay@")
	 SetBufIns(hbuf, ln, StrLen(szCurLine) + 11)
}

/*
** ===========================================================================
**
** Function:        
**     InsifDef
**
** Description: 
**     Writes if statement
** 
** Input: 
**     Condition
** 
** Output: 
**     Statement
** 
** Return value: 
**     none
** 
** Side effects:
**     File overwritten
**
** ===========================================================================
*/

macro InsIfdef()
{
	 sz = Ask("Enter ifdef condition:")
	 if (sz != "")
	 {
	  // IfdefSz(sz);
	  hwnd = GetCurrentWnd()
	  lnFirst = GetWndSelLnFirst(hwnd)
	  lnLast = GetWndSelLnLast(hwnd)
	  hbuf = GetWndBuf(hwnd)
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

	  InsBufLine(hbuf, lnFirst, "@ich@#ifdef @sz@")
	  InsBufLine(hbuf, lnLast + 2, "@ich@#endif  /* @sz@ */")
	 }
}

/*
** ===========================================================================
**
** Function:        
**     InsEditReasonComment
**
** Description: 
**     Writes edit reason comment around selection
** 
** Input: 
**     Author, reason
** 
** Output: 
**     Edit reason comment around selection
** 
** Return value: 
**     none
** 
** Side effects:
**     File overwritten
**
** ===========================================================================
*/

macro InsEditReasonComment()
{
	 auth = Ask("Enter author:")
	 sz = Ask("Enter reason:")
	 if (sz != "")
	 {
	  szTime = GetSysTime(1)
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
	  hwnd = GetCurrentWnd()
	  lnFirst = GetWndSelLnFirst(hwnd)
	  lnLast = GetWndSelLnLast(hwnd)
	  hbuf = GetCurrentBuf()
	  InsBufLine(hbuf, lnFirst, "//@auth@ @Year@/@szMonth@/@szDay@ @sz@ - start")
	  InsBufLine(hbuf, lnLast + 2,  "//@auth@ @Year@/@szMonth@/@szDay@ @sz@ - end")
	 }
}

/*
** ===========================================================================
**
** Function:        
**     InsEditReasonCommentHash
**
** Description: 
**     Writes edit reason comment around selection in makefile
** 
** Input: 
**     Author, reason
** 
** Output: 
**     Edit reason comment around selection
** 
** Return value: 
**     none
** 
** Side effects:
**     File overwritten
**
** ===========================================================================
*/

macro InsEditReasonCommentHash()
{
	 auth = Ask("Enter author:")
	 sz = Ask("Enter reason:")
	 if (sz != "")
	 {
	  szTime = GetSysTime(1)
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
	  hwnd = GetCurrentWnd()
	  lnFirst = GetWndSelLnFirst(hwnd)
	  lnLast = GetWndSelLnLast(hwnd)
	  hbuf = GetCurrentBuf()
	  InsBufLine(hbuf, lnFirst, "#@auth@ @Year@/@szMonth@/@szDay@ @sz@ - start")
	  InsBufLine(hbuf, lnLast + 2,  "#@auth@ @Year@/@szMonth@/@szDay@ @sz@ - end")
	 }
}

/*
** ===========================================================================
**
** Function:        
**     IfdefineSz
**
** Description: 
**     Writes ifndef-define-endif statement
** 
** Input: 
**     sz - string
** 
** Output: 
**     Statement
** 
** Return value: 
**     none
** 
** Side effects:
**     File overwritten
**
** ===========================================================================
*/

macro IfdefineSz(sz)
{
	 hwnd = GetCurrentWnd()
	 lnFirst = GetWndSelLnFirst(hwnd)
	 lnLast = GetWndSelLnLast(hwnd)

	 hbuf = GetCurrentBuf()
	 InsBufLine(hbuf, lnFirst, "#ifndef @sz@")
	 InsBufLine(hbuf, lnFirst + 1, "#define @sz@")
	 InsBufLine(hbuf, lnFirst + 2, "")
	 InsBufLine(hbuf, lnLast + 4,  "#endif  /* @sz@ */")
}

/*
** ===========================================================================
**
** Function:        
**     AutoExpand
**
** Description: 
**     Expands C statements
** 
** Input: 
**     none
** 
** Output: 
**     Expanded C statement
** 
** Return value: 
**     none
** 
** Side effects:
**     Expanded statement
**
** ===========================================================================
*/

macro AutoExpand()
{
	 // get window, sel, and buffer handles
	 hwnd = GetCurrentWnd()
	 if (hwnd == 0)
	  stop
	 sel = GetWndSel(hwnd)
	 if (sel.ichFirst == 0)
	  stop
	 hbuf = GetWndBuf(hwnd)

	 // get line the selection (insertion point) is on
	 szLine = GetBufLine(hbuf, sel.lnFirst);

	 // parse word just to the left of the insertion point
	 wordinfo = GetWordLeftOfIch(sel.ichFirst, szLine)
	 ln = sel.lnFirst;

	 chTab = CharFromAscii(9)

	 // prepare a new indented blank line to be inserted.
	 // keep white space on left and add a tab to indent.
	 // this preserves the indentation level.
	 ich = 0
	 while (szLine[ich] == ' ' || szLine[ich] == chTab)
	  {
	  ich = ich + 1
	  }

	 szLine = strmid(szLine, 0, ich)
	 sel.lnFirst = sel.lnLast
	 sel.ichFirst = wordinfo.ich
	 sel.ichLim = wordinfo.ich

	 // expand szWord keyword...


	 if (wordinfo.szWord == "if" ||
	  wordinfo.szWord == "while" ||
	  wordinfo.szWord == "elseif")
	  {
	  SetBufSelText(hbuf, " (###)")
	  InsBufLine(hbuf, ln + 1, "@szLine@" # "{");
	  InsBufLine(hbuf, ln + 2, "@szLine@" # chTab);
	  InsBufLine(hbuf, ln + 3, "@szLine@" # "}");
	  }
	 else if (wordinfo.szWord == "for")
	  {
	  SetBufSelText(hbuf, " (###)")
	  InsBufLine(hbuf, ln + 1, "@szLine@" # "{");
	  InsBufLine(hbuf, ln + 2, "@szLine@" # chTab);
	  InsBufLine(hbuf, ln + 3, "@szLine@" # "}");
	  }
	 else if (wordinfo.szWord == "switch")
	  {
	  SetBufSelText(hbuf, " (###)")
	  InsBufLine(hbuf, ln + 1, "@szLine@" # "{")
	  InsBufLine(hbuf, ln + 2, "@szLine@" # "case ")
	  InsBufLine(hbuf, ln + 3, "@szLine@" # chTab)
	  InsBufLine(hbuf, ln + 4, "@szLine@" # chTab # "break;")
	  InsBufLine(hbuf, ln + 5, "@szLine@" # "default:")
	  InsBufLine(hbuf, ln + 6, "@szLine@" # chTab)
	  InsBufLine(hbuf, ln + 7, "@szLine@" # "}")
	  }
	 else if (wordinfo.szWord == "do")
	  {
	  InsBufLine(hbuf, ln + 1, "@szLine@" # "{")
	  InsBufLine(hbuf, ln + 2, "@szLine@" # chTab);
	  InsBufLine(hbuf, ln + 3, "@szLine@" # "} while ();")
	  }
	 else if (wordinfo.szWord == "case")
	  {
	  SetBufSelText(hbuf, " ###")
	  InsBufLine(hbuf, ln + 1, "@szLine@" # chTab)
	  InsBufLine(hbuf, ln + 2, "@szLine@" # chTab # "break;")
	  }
	 else
	  stop

	 SetWndSel(hwnd, sel)
	 LoadSearchPattern("###", true, false, false);
	 Search_Forward
}

/*
** ===========================================================================
**
** Function:        
**     GetWordLeftOfIch
**
** Description: 
**     Describe text to the left of ich
** 
** Input: 
**     ich - char index, sz - string
** 
** Output: 
**     Text word to the left of ich
** 
** Return value: 
**     wordInfo
** 
** Side effects:
**     none
**
** ===========================================================================
*/

macro GetWordLeftOfIch(ich, sz)
{
	 wordinfo = "" // create a "wordinfo" structure

	 chTab = CharFromAscii(9)

	 // scan backwords over white space, if any
	 ich = ich - 1;
	 if (ich >= 0)
	  while (sz[ich] == " " || sz[ich] == chTab)
	   {
	   ich = ich - 1;
	   if (ich < 0)
	    break;
	   }

	 // scan backwords to start of word
	 ichLim = ich + 1;
	 asciiA = AsciiFromChar("A")
	 asciiZ = AsciiFromChar("Z")
	 while (ich >= 0)
	  {
	  ch = toupper(sz[ich])
	  asciiCh = AsciiFromChar(ch)
	  if ((asciiCh < asciiA || asciiCh > asciiZ) && !IsNumber(ch))
	   break // stop at first non-identifier character
	  ich = ich - 1;
	  }

	 ich = ich + 1
	 wordinfo.szWord = strmid(sz, ich, ichLim)
	 wordinfo.ich = ich
	 wordinfo.ichLim = ichLim;

	 return wordinfo
}

macro FileExists(file)
{
	return OpenBuf(file) != hNil
}

macro OpenCache(file)
{	
	global errFile
	hbuf = GetBufHandle(file)
	if (hbuf == hNil)
	{
		hbuf = OpenBuf(file)
		if (hbuf == hNil)
		{
			if(errFile != file)
			{
				msg("file no exist:" # CharFromKey(13) #  file)
				errFile = file
			}
			stop
		}
	}
	return hbuf
}

