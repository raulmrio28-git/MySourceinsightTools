macro fwh_si_f1()
{
	project_type = ProjectGetType(ProjectGetName())
	key = GetKey()
	//msg("key from kb: @key@")
	if (project_type == "Base")
	{
		if (key == 49) //1
			BaseWriteReason()
		else if (key == 50) //2
			ShellExecute("explore", GetMacrosFolder(), "", "", 1)
		else if (key == 51) //3
			ShellExecute("explore", GetConfigFolder(), "", "", 1)
		else if (key == 52) //4
			ShellExecute("explore", GetNotesFolder(), "", "", 1)
		else if (key == 53) //5
			ShellExecute("explore", GetNotesFolder() # "\\Personal", "", "", 1)
		else if (key == 54) //6
		{
			key2 = GetKey()
			SetBufSelText(GetCurrentBuf(), "@key2@")
		}		
	}
}
