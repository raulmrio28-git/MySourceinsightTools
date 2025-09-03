/*
** ===========================================================================
**
** File: 
**     FWH_ErrorUtilities.em
**
** Description: 
**     SI errormsg utilities
** 
** History: 
**
** when          who             what, where, why
** ----------    ------------    --------------------------------
** 2025/09/03    konakona        Created.
**
** ===========================================================================
*/


macro UtilitiesShowMessage(error, details, show)
{
	//This part is moved from INI file, no matter what we do we should show an error
	//from one of these from INI parsing...
	FILE_NOT_EXISTS_EN = "File does not exist"
	KEY_NOT_EXISTS_EN = "Key does not exist"
	VALUE_NOT_EXISTS_EN = "Value does not exist"

	FILE_NOT_EXISTS_CN = "文件不存在"
	KEY_NOT_EXISTS_CN = "键不存在"
	VALUE_NOT_EXISTS_CN = "价值不存在"
	
	language = GetEnv("SI_LANGUAGE")

	if (language == "")
	{
		msg("No language setup! Please run InstallMacros.cmd before using macro!" # CharFromKey(13) # "无需语言设置！使用宏前请运行InstallMacros.cmd！")
		stop
	}

	if (error == "FILE_NOT_EXISTS")
	{
		if (show == 1)
		{
			if (language == "EN")
			{
				msg("@FILE_NOT_EXISTS_EN@: @details@")
			}
			else if (language == "CN")
			{
				msg("@FILE_NOT_EXISTS_CN@: @details@")
			}
		}
	}
	else if (error == "KEY_NOT_EXISTS")
	{
		if (show == 1)
		{
			if (language == "EN")
			{
				msg("@KEY_NOT_EXISTS_EN@: @details@")
			}
			else if (language == "CN")
			{
				msg("@KEY_NOT_EXISTS_CN@: @details@")
			}
		}
	}
	else if (error == "VALUE_NOT_EXISTS")
	{
		if (show == 1)
		{
			if (language == "EN")
			{
				msg("@VALUE_NOT_EXISTS_EN@: @details@")
			}
			else if (language == "CN")
			{
				msg("@VALUE_NOT_EXISTS_CN@: @details@")
			}
		}
	}
	else
	{
		if (show == 1)
		{
			err = GetIniSectionValue("Strings_@language@.ini", "Strings", error, show)
			msg("@err@: @details@")
		}
	}
}