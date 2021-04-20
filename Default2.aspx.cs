using System;
using System.Collections.Generic;
using System.DirectoryServices;
using System.DirectoryServices.AccountManagement;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

// has the IADsLargeInteger class

public partial class Default2 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //DateHG d = new DateHG();
        //DateTime date = DateTime.Parse(d.GDateNow());
        ////DateTime date = DateTime.ParseExact(d.HijriToGreg("1437/05/21", "yyyy/MM/dd"), "yyyy/MM/dd", null);
        //string s = date.ToString("yyyy/MM/dd hh:mm:ss");

        //Response.Write(s);
        // Bind to the group.
        //string DomainPath = "LDAP://DC=kfnl,DC=gov,DC=sa";
        //DirectoryEntry searchRoot = new DirectoryEntry(DomainPath);
        //DirectorySearcher search = new DirectorySearcher(searchRoot,"(objectCategory=group)");
        //foreach (SearchResult res in search.FindAll())
        //{
        //    Response.Write(res.Path +"<br/>");
        //}

        // //Commit the changes to the group.
        ////  group.CommitChanges();

        Response.Write(validateUser("dlibrary", "P@ssw0rd@DL123").ToString() );
      //  ActiveDirectoryManagment ac = new ActiveDirectoryManagment();
       // ac.GetADUsersByGroup("CN=REFERENCE SERVICES,OU=REFERENCE SRVCS,OU=G.D.U.S,OU=KFNL,DC=kfnl,DC=gov,DC=sa");
        //getUser();
        //validateUser("", "");
    }
    public static bool validateUser(string userName, string password)
    {
        PrincipalContext pc = new PrincipalContext(ContextType.Domain, "kfnl.gov.sa");
        // validate the credentials
        bool isValid = pc.ValidateCredentials(userName, password);
        return isValid;
    }
    public void getUser()
    {
        //string DomainPath = "LDAP://DC=kfnl,DC=gov,DC=sa";
        //DirectoryEntry searchRoot = new DirectoryEntry(DomainPath);
        //DirectorySearcher search = new DirectorySearcher(searchRoot, "(objectCategory=user)");
        //foreach (SearchResult res in search.FindAll())
        //{
        //    Response.Write(res.Path + "<br/>");

        //}
        //using (var context = new PrincipalContext(ContextType.Domain, "kfnl.gov.sa"))
        //{
        //    using (var searcher = new PrincipalSearcher(new UserPrincipal(context)))
        //    {
        //        foreach (var result in searcher.FindAll())
        //        {
        //            DirectoryEntry de = result.GetUnderlyingObject() as DirectoryEntry;
        //            Response.Write("First Name: " + de.Properties["givenName"].Value+"<br/>");
        //            Response.Write("Last Name : " + de.Properties["sn"].Value + "<br/>");
        //            Response.Write("SAM account name   : " + de.Properties["lastLogon"].Value + "<br/>");
        //          //  Response.Write("User principal name: " + de.Properties["userPrincipalName"].Value + "<br/>");

        //        }
        //    }
        //}
        // Get all the users for that domain
        using (var context = new PrincipalContext(ContextType.Domain, "kfnl.gov.sa"))
        {
            using (var searcher = new PrincipalSearcher(new UserPrincipal(context)))
            {
                foreach (var result in searcher.FindAll())
                {
                    var auth = result as AuthenticablePrincipal;
                    if (auth != null)
                    {
                        Response.Write("Name: " + auth.Name + "<br/>");
                        Response.Write("Last Logon Time: " + auth.LastLogon + "<br/>");
                        Response.Write("DistinguishedName: " + result.DistinguishedName);
                        Response.Write("<br/>");
                    }
                }
            }
        }
    }
}

