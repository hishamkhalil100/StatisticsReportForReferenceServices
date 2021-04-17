using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

public partial class Admin_BooksFromIndexStat : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            HtmlGenericControl ControlID = (HtmlGenericControl)Master.FindControl("liBooksFromIndexStat");
            ControlID.Attributes["class"] = "has-sub active";
            Helper.GroupsEnum[] allowedGroups =
                {Helper.GroupsEnum.Admin, Helper.GroupsEnum.BooksReceivedAdmin};
            if (Request.Cookies["SecurityType"] != null && !Helper.IsAuthorize(new CookieSecurityProvider().Unprotect(Request.Cookies["SecurityType"].Value), allowedGroups))
            {
                Response.Redirect("/Default.aspx");
            }
            try
            {
                bindData();
            }
            catch (Exception ex)
            {
                Helper.LogError(ex.Message, ex.StackTrace);
                Response.Redirect("/Admin/Error.aspx");
            }

        }

    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        try
        {
            bindData();
        }
        catch (Exception ex)
        {
            Helper.LogError(ex.Message, ex.StackTrace);
            Response.Redirect("/Admin/Error.aspx");
        }
    }
    private void bindData()
    {
        bindRowOne();
    }
    private void bindRowOne()
    {
        int totalBooks = 0;
        int totalVitistors = 0;

        DateHG cal = new DateHG();
        DateTime? startDate;
        DateTime? endDate;
        if (!string.IsNullOrEmpty(popupDatepicker.Value))
        {
            startDate = DateTime.ParseExact(cal.HijriToGreg(invertDate(popupDatepicker.Value.ToString())), "yyyy/MM/dd", cal.enCul.DateTimeFormat, DateTimeStyles.AllowWhiteSpaces);
        }
        else
        {
            startDate = null;
        }
        if (!string.IsNullOrEmpty(popupDatepickerEnd.Value))
        {
            endDate = DateTime.ParseExact(cal.HijriToGreg(invertDate(popupDatepickerEnd.Value.ToString())), "yyyy/MM/dd", cal.enCul.DateTimeFormat, DateTimeStyles.AllowWhiteSpaces);
        }
        else
        {
            endDate = null;
        }

        var q = new StatisticsReportForReferenceServicesDataContext().BooksReceivedStat(startDate, endDate).ToArray<BooksReceivedStatResult>();
        foreach (var item in q)
        {
            lblNoCopies.Text = string.IsNullOrEmpty(item.Count_Copies.ToString()) ? "0" : item.Count_Copies.ToString();
            lblNoTitles.Text = string.IsNullOrEmpty(item.Count_Titles.ToString()) ? "0" : item.Count_Titles.ToString();
         
        }

    }

    private string invertDate(string date)
    {
        string[] arr = date.Split('/');
        string invDate = string.Empty;
        for (int i = arr.Length - 1; i >= 0; i--)
        {
            if (i == 0)
                invDate += arr[i];
            else
                invDate += arr[i] + "/";

        }
        return invDate;
    }
}