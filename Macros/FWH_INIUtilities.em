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
		UtilitiesShowMessage("FILE_NOT_EXISTS", file)
		return ""
	}

	return fn
}


macro IsIniSectionExist(file, name)
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
		CloseBuf(hbuf)
		return 0x80000000 + line //0x80000000 -> exist in file
	}
	SaveBufAs(hbuf, GetTempFolder() # "\\~temp_INIValues")
	CloseBuf(hbuf)
	UtilitiesShowMessage("KEY_NOT_EXISTS", "@file@:@name@")
	return 0
}

macro GetIniSectionAllValues(file, names)
{
	tmp = IsIniSectionExist(file, names)
	buff = NewBuf("~temp_INIValues")
	if (tmp >= 0x80000000)
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
	SaveBufAs(hbuf, GetTempFolder() # "\\~temp_INIValues")
	CloseBuf(hbuf)
	return buff
}

macro IsIniValueExist(file, names, namev)
{
	ret = ""
	if (IsIniSectionExist(file, names) >= 0x80000000)
	{
		sect_vals = GetIniSectionAllValues(file, names)
		str = "^@namev@\\s*="
		srch = SearchInBuf(sect_vals, str, 0,0, TRUE, TRUE, FALSE)
		if (srch != "")
			ret = GetBufLine(sect_vals,srch.lnFirst)
		SaveBufAs(sect_vals, GetTempFolder() # "\\~temp_INIValues")
		CloseBuf(sect_vals)
	}
	if (ret == "")
		UtilitiesShowMessage("VALUE_NOT_EXISTS", "@file@:@names@->@namev@")
	return ret
}

macro GetIniSectionValue(file, names, namev)
{
	ret = ""
	if (IsIniSectionExist(file, names) >= 0x80000000)
	{
		tmp = IsIniValueExist(file, names, namev)
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

