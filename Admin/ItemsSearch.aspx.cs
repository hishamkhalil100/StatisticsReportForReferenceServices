using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

public partial class ItemsSearch : System.Web.UI.Page
{
    private string userID;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (IsPostBack)
        {
            HtmlGenericControl ControlID = (HtmlGenericControl)Master.FindControl("liItemsSearch");
            ControlID.Attributes["class"] = "has-sub active";
            var protectedText = Request.Cookies[name: "UserWebsiteId"].Value;
            if (protectedText != null)
            {
                userID = new CookieSecurityProvider().Unprotect(
                    protectedText: protectedText);
                Helper.GroupsEnum[] allowedGroups =
                {
                    Helper.GroupsEnum.Admin, Helper.GroupsEnum.ItemsAdmin
                };
                if (!Helper.IsAuthorize(
                    userGroups: new CookieSecurityProvider().Unprotect(
                        protectedText: Request.Cookies[name: "SecurityType"].Value), allowedGroups: allowedGroups))
                {
                    Response.Redirect(url: "/Default.aspx");
                }
            }
            else
            {
                Response.Redirect(url: "/Default.aspx");
            }
            DataPagerdlItems.PageSize = int.Parse(ddlpgSize.SelectedValue.ToString());
        }
        else
        {
            GetRealDept();
        }

    }
    protected void dlUsers_ItemCommand(object source, ListViewCommandEventArgs e)
    {
        if (e.CommandName.ToString() == "edititem")
        {
            Response.Redirect("/Admin/ItemsAdd.aspx?num=" + e.CommandArgument.ToString());
        }
    }
    protected void dlUsers_ItemDataBound(object sender, ListViewItemEventArgs e)
    {
        DateHG cal = new DateHG();

        string startDate;
        if (DataBinder.Eval(e.Item.DataItem, "Receive_Date") != null)
        {
            startDate = cal.GregToHijri(DataBinder.Eval(e.Item.DataItem, "Receive_Date").ToString());
        }
        else
        {
            startDate = "";
        }
        string endDate;
        if (DataBinder.Eval(e.Item.DataItem, "Finsh_date") != null)
        {
            endDate = cal.GregToHijri(DataBinder.Eval(e.Item.DataItem, "Finsh_date").ToString());
        }
        else
        {
            endDate = "";
        }
        ((Label)e.Item.FindControl("lblReceiveDate")).Text = startDate;
        ((Label)e.Item.FindControl("lblFinshDate")).Text = endDate;

        int Degree = int.Parse(DataBinder.Eval(e.Item.DataItem, "Degree").ToString());
        if (Degree == 0)
        {
            ((Label)e.Item.FindControl("lblDegree")).Text = "دكتوراه";
        }
        else if (Degree == 1)
        {
            ((Label)e.Item.FindControl("lblDegree")).Text = "ماجستير";
        }
        else if (Degree == 2)
        {
            ((Label)e.Item.FindControl("lblDegree")).Text = "جامعي";
        }
        else if (Degree == 3)
        {
            ((Label)e.Item.FindControl("lblDegree")).Text = "اخرى";
        }

        int Send_Method = int.Parse(DataBinder.Eval(e.Item.DataItem, "Send_Method").ToString());
        if (Send_Method == 0)
        {
            ((Label)e.Item.FindControl("lblSendMethod")).Text = "مناولة";
        }
        else if (Send_Method == 1)
        {
            ((Label)e.Item.FindControl("lblSendMethod")).Text = "بريد";
        }
        else if (Send_Method == 2)
        {
            ((Label)e.Item.FindControl("lblSendMethod")).Text = "بريد الكتروني";
        }
        else if (Send_Method == 3)
        {
            ((Label)e.Item.FindControl("lblSendMethod")).Text = "خدمة ذاتية";
        }
        else if (Send_Method == 4)
        {
            ((Label)e.Item.FindControl("lblSendMethod")).Text = "هاتف";
        }
        int Period = int.Parse(DataBinder.Eval(e.Item.DataItem, "Period").ToString());
        if (Period == 0)
        {
            ((Label)e.Item.FindControl("lblPeriod")).Text = "الصباحية";
        }
        else if (Period == 1)
        {
            ((Label)e.Item.FindControl("lblPeriod")).Text = "المسائية";
        }

        int Language = int.Parse(DataBinder.Eval(e.Item.DataItem, "Language").ToString());
        if (Language == 0)
        {
            ((Label)e.Item.FindControl("lblLanguage")).Text = "عربي";
        }
        else if (Language == 1)
        {
            ((Label)e.Item.FindControl("lblLanguage")).Text = "انجليزي";
        }
        int Gender = int.Parse(DataBinder.Eval(e.Item.DataItem, "Customer_Gender").ToString());
        if (Gender == 0)
        {
            ((Label)e.Item.FindControl("lblCustomerGender")).Text = "انثي";
        }
        else if (Gender == 1)
        {
            ((Label)e.Item.FindControl("lblCustomerGender")).Text = "ذكر";
        }
        int SearchType = int.Parse(DataBinder.Eval(e.Item.DataItem, "Search_Type").ToString());
        if (SearchType == 0)
        {
            ((Label)e.Item.FindControl("lblSearchType")).Text = "الفهرس";
        }
        else if (SearchType == 1)
        {
            ((Label)e.Item.FindControl("lblSearchType")).Text = "مصادر المعلومات";
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
        var qu = new StatisticsReportForReferenceServicesDataContext().UsersSearch(userID).Single();

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
        if (qu.User_Role.Equals("admin"))
        {
            var q = new StatisticsReportForReferenceServicesDataContext().ItemsSearchWithUsers(null, null, txtCustomerName.Text.Trim(), null, startDate, endDate, null, null, null, txtUserName.Text.Trim(), null, null, null, null, null, null, null, null, null, null).ToList<ItemsSearchWithUsersResult>();;
            if (!string.IsNullOrEmpty(ddlDepartment.SelectedValue.ToString()))
                q = new StatisticsReportForReferenceServicesDataContext().ItemsSearchWithUsers(null, null, txtCustomerName.Text.Trim(), null, startDate, endDate, null, null, null, txtUserName.Text.Trim(), int.Parse(ddlDepartment.SelectedValue.ToString()), null, null, null, null, null, null, null, null, null).ToList<ItemsSearchWithUsersResult>();

            divNotifi.Visible = true;
            divNotifi.Attributes.Add("class", "alert alert-block alert-success fade in");
            lblDivNotifiTitle.Text = "تم !";
            pDivNotifiDesc.InnerText = " مجموع العناصر التي تم العثور عليها  " + q.Count;

            dlItems.DataSource = q;
            dlItems.DataBind();
        }
        else
        {
            divUserName.Visible = false;
            divpopupDatepicker.Attributes.Add("class", "span4");
            divpopupDatepickerEnd.Attributes.Add("class", "span4");
            divCustomerName.Attributes.Add("class", "span4");


            var q = new StatisticsReportForReferenceServicesDataContext().ItemsSearchWithUsers(null,userID, txtCustomerName.Text.Trim(), null, startDate, endDate, null, null, null, txtUserName.Text.Trim(), null, null, null, null, null, null, null, null, null, null).ToList<ItemsSearchWithUsersResult>();
            dlItems.DataSource = q;
            dlItems.DataBind();
        }
    }
    private void GetRealDept()
    {
        try
        {
            var query = new StatisticsReportForReferenceServicesDataContext().GetRealDepartments().ToList<GetRealDepartmentsResult>();
            ddlDepartment.DataTextField = "Department_Name";
            ddlDepartment.DataValueField = "Department_id";
            ddlDepartment.DataSource = query;

            ddlDepartment.DataBind();
            ListItem l = new ListItem("--إختر الإدارة--","", true);
            l.Selected = true;
            ddlDepartment.Items.Insert(0, l);

        }
        catch (Exception ex)
        {
            Helper.LogError(ex.Message, ex.StackTrace);
          //  Response.Redirect("/Admin/Error.aspx");
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
    protected void DataPagerdlItems_PreRender(object sender, EventArgs e)
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
}