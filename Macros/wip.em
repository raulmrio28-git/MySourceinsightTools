macro wip()
{
	//20250903 1637 - errors
	//Done testing --------------
	//........uncomment this to test only file not exist case, comment to do key and value........
	//IsIniSectionExist("aaaa.ini", "Test", 1) //file not exist
	IsIniSectionExist("abc.ini", "SaikiKusuo", 1) //key not exist
	IsIniValueExist("abc.ini", "MoreTest", "234", 1) //value not exist
	//Done testing --------------

	//20250903 1716 - ini get section value	
	//Done testing --------------
	msg(GetIniSectionValue("abc.ini", "MoreTest", "123", 1) //value=ctnt
	msg(GetIniSectionValue("abc.ini", "MoreTest", "ghi", 1) //value = ctnt
	msg(GetIniSectionValue("abc.ini", "MoreTest", "mno", 1) //value= ctnt
	msg(GetIniSectionValue("abc.ini", "MoreTest", "tuv", 1) //value =ctnt
	//Done testing --------------

	//20250903 1743 - project errors
	//Done testing --------------
	ProjectGetValue("NarutoUzumaki", "asdfghjkl") //project not exists
	msg(ProjectGetType("Base")) //project type
	msg(ProjectGetPath("Base")) //project path
	//Done testing --------------

	//20250903 1826 - string last path item.......
	msg(StringGetLastPathItem("Test\\abcdef")) //no slash at end
	msg(StringGetLastPathItem("Test\\abcdefghi\\")) //slash at end
	//20250903 1839 - testing f1
	
}