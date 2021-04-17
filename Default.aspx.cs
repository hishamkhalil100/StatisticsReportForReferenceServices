using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class _Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
     
        if (Request["logout"] == "true")
        {
            HttpCookie UserWebsiteId = new HttpCookie("UserWebsiteId");
            UserWebsiteId.Expires = DateTime.Now.AddDays(-1);
            Response.Cookies.Add(UserWebsiteId);
        }



    }
    protected void btnLogin_Click(object sender, EventArgs e)
    {
        try
        {
            string Msg = string.Empty;
            string UserRoleId = string.Empty;
            string UserId = txtUserName.Text;
            string qUserId = null;
            string qGroups= null;
            int count = 0;
            bool isValid = ActiveDirectoryManagment.validateUser(txtUserName.Text, txtPassword.Text);
            HttpCookie userWebsiteId = new HttpCookie("UserWebsiteId");
            HttpCookie securityType = new HttpCookie("SecurityType");
             var q = new StatisticsReportForReferenceServicesDataContext().IsValidUser(txtUserName.Text).ToList();
            if (q != null && isValid)
            {
                foreach (var item in q)
                {
                    if (!item.User_Is_Locked)
                    {
                       
                        qUserId= item.User_ID.ToString();

                        // if it is leader or Manager
                        qGroups+= item.GroupID.ToString()+"|";

                    }
                    else
                    {
                        DivMsg.Visible = true;
                        break;
                    }
                }
                if (chkRemberMe.Checked)
                {
                    userWebsiteId.Expires = DateTime.Now.AddDays(30);
                    securityType.Expires = DateTime.Now.AddDays(30);
                }
                else
                {
                    userWebsiteId.Expires = DateTime.Now.AddDays(1);
                    securityType.Expires = DateTime.Now.AddDays(1);
                }

                userWebsiteId.Value = new CookieSecurityProvider().Protect(qUserId);
                securityType.Value = new CookieSecurityProvider().Protect(qGroups);
                userWebsiteId.Secure = true;
                
                Response.Cookies.Add(userWebsiteId);
                Response.Cookies.Add(securityType);
                if (Request.QueryString["page"] == null)
                    Response.Redirect("/admin/ItemsAdd.aspx");
                else
                    Response.Redirect(Request.QueryString["page"].ToString());
            }

            else
            {
                DivMsg.Visible = true;
            }
        }
        catch (Exception ex)
        {
            DivMsg.Visible = true;
            DivMsg.InnerHtml = ex.Message;
        }
    }
}