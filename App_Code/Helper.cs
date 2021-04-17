using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.InteropServices;
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
    public enum GroupsEnum : int
    {
        GeneralCollection = 1,
        GeneralCollectionAdmin = 2,
        Photocopy = 3,
        PhotocopyAdmin = 4,
        SortingAndOrganize = 5,
        SortingAndOrganizeAdmin = 6,
        BooksReceived = 7,
        BooksReceivedAdmin = 8,
        Items = 9,
        ItemsAdmin = 10,
        Admin = 11,
    }

    public static bool IsAuthorize(string userGroups , Helper.GroupsEnum [] allowedGroups)
    {
        string[] arr = userGroups.Split('|');
        arr = arr.Take(arr.Count() - 1).ToArray();
        int[] uGroups = Array.ConvertAll(arr, s => int.Parse(s));
        foreach (var allowGroup in allowedGroups  )
        {
            foreach (var uGroup in uGroups)
            {
                if ((int) allowGroup == uGroup)
                    return true;
            }
        }

        return false;
    }

    public static void LogError(string Message, string StackTrace)
    {
        new StatisticsReportForReferenceServicesDataContext().LogErrorAdd(Message, StackTrace);
    }

    public class Groups
    {
        public int Id { get; set; }
        public string Url { get; set; }
        public string Description { get; set; } 

    }
}