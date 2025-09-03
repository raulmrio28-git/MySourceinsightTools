/*
** ===========================================================================
**
** File: 
**     FWH_INIUtilities.em
**
** Description: 
**     SI INI utilities 
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
**     GetIniPath
**
** Description: 
**     Get INI path from base root
** 
** Input: 
**     Filename
** 
** Output: 
**     CONFIG_FOLDER/USERCONFIG_FOLDER\file
** 
** Return value: 
**     fn
** 
** Side effects:
**     None
**
** ===========================================================================
*/

macro GetIniPath(file)
{
	fn = GetConfigFolder() # "\\" # file
	
	err = FileExists(fn)

	if (err == 0) //is file in user folder?
	{
		fn = GetConfigUserFolder() # "\\" # file
		err = FileExists(fn)
	}

	if (err == 0) //still not exist?
	{
		UtilitiesShowMessage("FILE_NOT_EXISTS", file, 1)
		return ""
	}

	return fn
}

/*
** ===========================================================================
**
** Function:        
**     IsIniSectionExist
**
** Description: 
**     Check if section/key exists in INI
** 
** Input: 
**     Filename, name of section, show error
** 
** Output: 
**     (1<<31)+line if exist, 0 if not
** 
** Return value: 
**     See output
** 
** Side effects:
**     Create a temp buffer
**
** ===========================================================================
*/

macro IsIniSectionExist(file, name, showerror)
{
	section_str = "[" # name # "]"

	fn = GetIniPath(file)
	
	hbuf = OpenCache(fn)

	sr = SearchInBuf(hbuf, section_str, 0,0, TRUE, FALSE, TRUE)
	
	if (sr != "")
	{
		line=0

		section_str_get = GetBufLine(hbuf,line)
		while (section_str_get != section_str)
		{
			line = line+ 1
			section_str_get = GetBufLine(hbuf,line)
		}
		SaveBufAs(hbuf, GetTempFolder() # "\\~temp_INIValues")
		SetBufDirty(hbuf, 0)
		CloseBuf(hbuf)
		return 0x80000000 + line //0x80000000 -> exist in file
	}
	SaveBufAs(hbuf, GetTempFolder() # "\\~temp_INIValues")
	SetBufDirty(hbuf, 0)
	CloseBuf(hbuf)
	UtilitiesShowMessage("KEY_NOT_EXISTS", "@file@:@name@", showerror)
	return 0
}

/*
** ===========================================================================
**
** Function:        
**     GetIniSectionAllValues
**
** Description: 
**     Get all values of ini section/key
** 
** Input: 
**     Filename, name of section/key, show error
** 
** Output: 
**     Sections as hbuf
** 
** Return value: 
**     buff
** 
** Side effects:
**     Create a temp buffer
**
** ===========================================================================
*/

macro GetIniSectionAllValues(file, names, showerror)
{
	tmp = IsIniSectionExist(file, names, showerror)
	buff = NewBuf("~temp_INIValues")
	if (tmp >= 0x80000000 && tmp != 0)
	{
		line = tmp-0x80000000
		fn = GetIniPath(file)
		hbuf = OpenCache(fn)
		maxlines = GetBufLineCount (hbuf)
		section_str_get = GetBufLine(hbuf,line)
		while (true)
		{
			line = line + 1
			if (maxlines == line)
				break
			section_str_get = GetBufLine(hbuf,line)
			if (section_str_get[0] == "[" || section_str_get[0] == "") //use doublequotes, not singlequotes here!!!!!!!!!!
				break
			AppendBufLine (buff,section_str_get)
		}
	}
	if (tmp != 0)
	{
		SaveBufAs(hbuf, GetTempFolder() # "\\~temp_INIValues")
		SetBufDirty(hbuf, 0)
		CloseBuf(hbuf)
	}
	return buff
}

/*
** ===========================================================================
**
** Function:        
**     IsIniValueExist
**
** Description: 
**     Check if value of INI section/key exists
** 
** Input: 
**     Filename, name of section/key, name of value, show error
** 
** Output: 
**     String with value content
** 
** Return value: 
**     ret
** 
** Side effects:
**     Create a temp buffer
**
** ===========================================================================
*/

macro IsIniValueExist(file, names, namev, showerror)
{
	ret = ""
	if (IsIniSectionExist(file, names, showerror) >= 0x80000000)
	{
		sect_vals = GetIniSectionAllValues(file, names, showerror)
		str = "^@namev@\\s*="
		srch = SearchInBuf(sect_vals, str, 0,0, TRUE, TRUE, FALSE)
		if (srch != "")
			ret = GetBufLine(sect_vals,srch.lnFirst)
		SaveBufAs(sect_vals, GetTempFolder() # "\\~temp_INIValues")
		SetBufDirty(sect_vals, 0)
		CloseBuf(sect_vals)
	}
	if (ret == "")
		UtilitiesShowMessage("VALUE_NOT_EXISTS", "@file@:@names@->@namev@")
	return ret
}

/*
** ===========================================================================
**
** Function:        
**     GetIniSectionValue
**
** Description: 
**     Get data of value of INI section/key
** 
** Input: 
**     Filename, name of section/key, name of value, show error
** 
** Output: 
**     String with content of value
** 
** Return value: 
**     ret
** 
** Side effects:
**     Create a temp buffer
**
** ===========================================================================
*/


macro GetIniSectionValue(file, names, namev, showerror)
{
	ret = ""
	if (IsIniSectionExist(file, names, showerror) >= 0x80000000)
	{
		tmp = IsIniValueExist(file, names, namev, shoewrror)
		if (tmp != "")
		{
			p = 0
			while (tmp[p] != "=")
				p = p + 1
			p = p + 1
			while (tmp[p] == " ")
				p = p + 1
			ret = strmid(tmp, p, strlen(tmp))
		}
	}
	return ret
}

