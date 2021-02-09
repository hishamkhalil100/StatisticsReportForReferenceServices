using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for Helper
/// </summary>
public class Helper
{
	public Helper()
	{
		//
		// TODO: Add constructor logic here
		//
	}
    public static void LogError(string Message, string StackTrace)
    {
        new StatisticsReportForReferenceServicesDataContext().LogErrorAdd(Message, StackTrace);
    }
}