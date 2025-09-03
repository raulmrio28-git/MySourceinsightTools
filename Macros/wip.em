macro wip()
{
	//20250903 1637 - errors
	//........uncomment this to test only file not exist case, comment to do key and value........
	//IsIniSectionExist("aaaa.ini", "Test") //file not exist
	IsIniSectionExist("abc.ini", "SaikiKusuo") //key not exist
	IsIniValueExist("abc.ini", "MoreTest", "234") //value not exist
}