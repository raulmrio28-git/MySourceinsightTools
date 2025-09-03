macro fwh_si_f1()
{
	project_type = ProjectGetType(ProjectGetName())
	key = GetKey()
	//msg("key from kb: @key@")
	if (project_type == "Base")
	{
		if (key == 49)
			BaseWriteReason()
	}
}
