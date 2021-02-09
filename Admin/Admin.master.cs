using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_Admin : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.Cookies["UserWebsiteId"] == null)
            Response.Redirect("~/Default.aspx?page=" + Request.RawUrl);

        if (!IsPostBack)
        {
            var q = new StatisticsReportForReferenceServicesDataContext().UsersSearch(Request.Cookies["UserWebsiteId"].Value.ToString()).ToList<UsersSearchResult>();
            foreach (var item in q)
            {
                spnUserName.InnerText = item.User_Name;
                if (item.User_Role.Equals("admin"))
                {
                    liItemsAdd.Visible = true;
                    liItemsSearch.Visible = true;
                    liUsersManagement.Visible = true;
                    liStatistics.Visible = true;
                }
                else if (item.User_Role.Equals("user"))
                {
                    liItemsAdd.Visible = true;
                    liItemsSearch.Visible = true;
                    liUsersManagement.Visible =false;
                    liStatistics.Visible = false;
                }
                if ( Request.RawUrl.Contains("Statistics.aspx") || Request.RawUrl.Contains("UsersManagement.aspx"))
                {
                    if (item.User_Role.Equals("user"))
                    {
                        Response.Redirect("~/Default.aspx?page=" + Request.RawUrl);
                    }
                }
            }
        }
    }
}
