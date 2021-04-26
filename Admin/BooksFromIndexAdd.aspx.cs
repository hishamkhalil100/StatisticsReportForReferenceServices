using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

public partial class Admin_BooksFromIndexAdd : System.Web.UI.Page
{
    private string userID;
    protected override void OnPreLoad(EventArgs e)
    {
        base.OnPreLoad(e);
        try
        {
            var protectedText = Request.Cookies[name: "UserWebsiteId"].Value;
            if (protectedText != null)
            {
                userID = new CookieSecurityProvider().Unprotect(
                    protectedText: protectedText);
                Helper.GroupsEnum[] allowedGroups =
                {
                    Helper.GroupsEnum.Admin, Helper.GroupsEnum.BooksReceivedAdmin,
                    Helper.GroupsEnum.BooksReceived
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
        }
        catch (Exception)
        {
            Response.Redirect(url: "/Default.aspx");
        }


    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            HtmlGenericControl ControlID = (HtmlGenericControl)Master.FindControl("liBooksFromIndexAdd");
            ControlID.Attributes["class"] = "has-sub active";
         
            if (!string.IsNullOrEmpty(value: Request[key: "num"]))
            {
                try
                {
                    GetData();
                }
                catch (Exception ex)
                {
                    Helper.LogError(Message: ex.Message, StackTrace: ex.StackTrace);
                    Response.Redirect(url: "/Admin/Error.aspx");
                }
            }
        }
    }


    protected void btnSave_Click(object sender, EventArgs e)
    {
        if (!string.IsNullOrEmpty(Request["num"]))
        {
            int? result = null;
            try
            {
                result = edit();
            }
            catch (Exception ex)
            {
                Helper.LogError(ex.Message, ex.StackTrace);
                result = -2;
            }
            finally
            {
                if (result == 1)
                {
                    Response.Redirect("BooksFromIndexAdd.aspx");
                    divNotifi.Visible = true;
                    divNotifi.Attributes.Add("class", "alert alert-block alert-success fade in");
                    lblDivNotifiTitle.Text = "تم !";
                    pDivNotifiDesc.InnerText = "تم تعديل العنصر " + Request["num"].ToString() + " بنجاح";
                }
                else if (result == -2)
                {
                    divNotifi.Visible = true;
                    divNotifi.Attributes.Add("class", "alert alert-block alert-error fade in");
                    lblDivNotifiTitle.Text = "خطأ !";
                    pDivNotifiDesc.InnerText = "عذرا اتصل بمسؤول النظام";
                }
                reset();
            }
        }
        else
        {
            int?[] result = { 0, 0 };
            try
            {
                result = insert();
            }
            catch (Exception ex)
            {
                Helper.LogError(ex.Message, ex.StackTrace);
                result[0] = -2;
            }
            finally
            {
                if (result[0] == 1)
                {
                    divNotifi.Visible = true;
                    divNotifi.Attributes.Add("class", "alert alert-block alert-success fade in");
                    lblDivNotifiTitle.Text = "تم !";
                    pDivNotifiDesc.InnerText = "تم اضافة العنصر " + result[1] + " بنجاح";
                }
                else if (result[0] == -2)
                {
                    divNotifi.Visible = true;
                    divNotifi.Attributes.Add("class", "alert alert-block alert-error fade in");
                    lblDivNotifiTitle.Text = "خطأ !";
                    pDivNotifiDesc.InnerText = "عذرا اتصل بمسؤول النظام";
                }
                reset();
            }
        }
    }



    private void reset()
    {

        popupDatepicker.Value = string.Empty;
        //popupDatepickerEnd.Value = string.Empty;

        txtTitles.Value = string.Empty;
        txtCopies.Value = string.Empty;
      
    }
    private int?[] insert()
    {
        int? result = null;
        DateHG cal = new DateHG();
        DateTime startDate = DateTime.ParseExact(cal.HijriToGreg(invertDate(popupDatepicker.Value.ToString())),
            "yyyy/MM/dd", cal.enCul.DateTimeFormat, DateTimeStyles.AllowWhiteSpaces);
        //DateTime? endDate;
        //if (!string.IsNullOrEmpty(popupDatepickerEnd.Value))
        //{
        //    endDate = DateTime.ParseExact(cal.HijriToGreg(invertDate(popupDatepickerEnd.Value.ToString())), "yyyy/MM/dd", cal.enCul.DateTimeFormat, DateTimeStyles.AllowWhiteSpaces);
        //}
        //else
        //{
        //    endDate = null;
        //}
        int? numOfCopies = ToNullableInt(txtCopies.Value.ToString());
        int? numOfTitles = ToNullableInt(txtTitles.Value.ToString());
     


        var q = new StatisticsReportForReferenceServicesDataContext().BooksReceivedAdd(
            userID, startDate,
            numOfCopies, numOfTitles, ref result).Single<BooksReceivedAddResult>();
        int?[] arr = { result, q.ID };
        return arr;
    }
    private int? edit()
    {
        int? result = null;
        int gender = 1;
        DateHG cal = new DateHG();
        DateTime startDate = DateTime.ParseExact(cal.HijriToGreg(invertDate(popupDatepicker.Value.ToString())),
            "yyyy/MM/dd", cal.enCul.DateTimeFormat, DateTimeStyles.AllowWhiteSpaces);
        //DateTime? endDate;
        //if (!string.IsNullOrEmpty(popupDatepickerEnd.Value))
        //{
        //     endDate = DateTime.ParseExact(cal.HijriToGreg(invertDate(popupDatepickerEnd.Value.ToString())), "yyyy/MM/dd", cal.enCul.DateTimeFormat, DateTimeStyles.AllowWhiteSpaces);
        //}else
        //{
        //    endDate = null;
        //}

        int? numOfCopies = ToNullableInt(txtCopies.Value.ToString());
        int? numOfTitles = ToNullableInt(txtTitles.Value.ToString());


        new StatisticsReportForReferenceServicesDataContext().BooksReceivedEdit(
            int.Parse(Request["num"].ToString()),userID,
            startDate, numOfCopies, numOfCopies, ref result);
        return result;
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
        return invDate.Replace(" ", "");
    }

    private void GetData()
    {

        StatisticsReportForReferenceServicesDataContext srfs = new StatisticsReportForReferenceServicesDataContext();
        var qu = srfs.UsersSearch(userID).Single<UsersSearchResult>();
        DateHG cal = new DateHG();
        if (qu.User_Role.Equals("admin"))
        {
            var q = srfs.BooksReceivedSerach(int.Parse(Request["num"].ToString()), null, null)
                .Single<BooksReceivedSerachResult>();
            popupDatepicker.Value = new DateHG().GregToHijri(q.Receive_Date.ToString());
            txtTitles.Value = q.NoTitle.ToString();
            txtCopies.Value = q.NoCopy.ToString();
           

            //rblGender.SelectedValue = q.Customer_Gender.ToString();


            // popupDatepicker.Value = cal.GregToHijri(q.Receive_Date.ToString());

            //popupDatepickerEnd.Value = cal.GregToHijri(q.Finsh_date.ToString());


        }
        else
        {
            var q = srfs
                .BooksReceivedSerachWithusers(int.Parse(Request["num"].ToString()),
                    userID, null)
                .Single<BooksReceivedSerachWithusersResult>();

            txtTitles.Value = q.NoTitle.ToString();
            txtCopies.Value = q.NoCopy.ToString();
           
            popupDatepicker.Value = cal.GregToHijri(q.Receive_Date.ToString());

        }
    }

    public int? ToNullableInt(string s)
    {
        int i;
        if (int.TryParse(s, out i)) return i;
        return null;
    }
}