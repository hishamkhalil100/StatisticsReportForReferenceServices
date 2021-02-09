﻿using System;
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
            bool isValid = ActiveDirectoryManagment.validateUser(txtUserName.Text, txtPassword.Text);
            var q = new StatisticsReportForReferenceServicesDataContext().IsValidUser(txtUserName.Text).Single();

            if (q != null && isValid && !q.User_Is_Locked)
            {
                HttpCookie UserWebsiteId = new HttpCookie("UserWebsiteId");
                UserWebsiteId.Value = UserId;
                Response.Cookies.Add(UserWebsiteId);

                HttpCookie SecurityType = new HttpCookie("SecurityType");// if it is leader or Manager
                SecurityType.Value = q.User_Role;
                Response.Cookies.Add(SecurityType);
                if (chkRemberMe.Checked)
                {
                    UserWebsiteId.Expires = DateTime.Now.AddDays(30);
                    SecurityType.Expires = DateTime.Now.AddDays(30);
                }
                else
                {
                    UserWebsiteId.Expires = DateTime.Now.AddDays(1);
                    SecurityType.Expires = DateTime.Now.AddDays(1);
                }


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
        }
    }
}