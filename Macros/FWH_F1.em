macro fwh_si_f1()
{
	project_type = ProjectGetType(ProjectGetName())
	key = GetKey()
	//msg("key from kb: @key@")
	if (project_type == "Base")
	{
		if (key == 49)
			BaseWriteReason()
		if (key == 48)
		{
			key2 = GetKey()
			if (key2 == 121 || key2 == 89) //commit with add files
				BaseCommitToGitAdd()	
			else if (key2 == 110 || key2 == 78)
				BaseCommitToGitNoAdd()
		}
	}
}
