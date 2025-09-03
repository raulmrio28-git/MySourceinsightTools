macro fwh_si_f2()
{
	pname = ProjectGetName()
	ppath = ProjectGetPath(pname)

	if (ppath != "")
		ShellExecute("explore", ppath, "", "", 1)
}
