using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

public partial class Admin_GeneralCollectionAdd : System.Web.UI.Page
{
     string userID;
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
                     Helper.GroupsEnum.Admin, Helper.GroupsEnum.GeneralCollectionAdmin,
                     Helper.GroupsEnum.GeneralCollection
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
            HtmlGenericControl ControlID = (HtmlGenericControl)Master.FindControl("liGeneralCollectionAdd");
            ControlID.Attributes["class"] = "has-sub active";    

            if (!string.IsNullOrEmpty(Request["num"]))
            {
                try
                {
                    GetData();
                }
                catch (Exception ex)
                {
                    Helper.LogError(ex.Message, ex.StackTrace);
                    Response.Redirect("/Admin/Error.aspx");
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
                    Response.Redirect("GeneralCollectionAdd.aspx");
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
                Reset();
            }
        }
        else
        {
            int?[] result = { 0, 0 };
            try
            {
                result = Insert();
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
                Reset();
            }
        }
    }



    private void Reset()
    {
        txtUserName.Value = string.Empty;
        txtMobile.Value = string.Empty;
        popupDatepicker.Value = string.Empty;
        //popupDatepickerEnd.Value = string.Empty;
        hfVistorID.Value = string.Empty;
        lblGender.Text = "ذكر";
        ddlCounter.SelectedValue = "0";
        txtNoOfBooks.Value = string.Empty;
        
    }
    private int?[] Insert()
    {
        int? result = null;
        int? itemID = null;

        DateHG cal = new DateHG();
        DateTime startDate = DateTime.ParseExact(cal.HijriToGreg(invertDate(popupDatepicker.Value.ToString())), "yyyy/MM/dd", cal.enCul.DateTimeFormat, DateTimeStyles.AllowWhiteSpaces);
        //DateTime? endDate;
        //if (!string.IsNullOrEmpty(popupDatepickerEnd.Value))
        //{
        //    endDate = DateTime.ParseExact(cal.HijriToGreg(invertDate(popupDatepickerEnd.Value.ToString())), "yyyy/MM/dd", cal.enCul.DateTimeFormat, DateTimeStyles.AllowWhiteSpaces);
        //}
        //else
        //{
        //    endDate = null;
        //}
        int? numOfbooks = ToNullableInt(txtNoOfBooks.Value.ToString());
        int? counterNo = ToNullableInt(ddlCounter.SelectedValue.ToString());


        var q = new StatisticsReportForReferenceServicesDataContext().GeneralCollectionAdd(userID, int.Parse(hfVistorID.Value.ToString()),
            hfName.Value.ToString(), int.Parse(hfGender.Value.ToString()),counterNo,
            startDate, numOfbooks, hfMobile.Value.ToString(),
            ref result).Single<GeneralCollectionAddResult>();
        int?[] arr = { result, q.ID};
        return arr;
    }
    private int? edit()
    {
        int? result = null;
        int gender = 1;
        DateHG cal = new DateHG();
        DateTime startDate = DateTime.ParseExact(cal.HijriToGreg(invertDate(popupDatepicker.Value.ToString())), "yyyy/MM/dd", cal.enCul.DateTimeFormat, DateTimeStyles.AllowWhiteSpaces);
        //DateTime? endDate;
        //if (!string.IsNullOrEmpty(popupDatepickerEnd.Value))
        //{
        //     endDate = DateTime.ParseExact(cal.HijriToGreg(invertDate(popupDatepickerEnd.Value.ToString())), "yyyy/MM/dd", cal.enCul.DateTimeFormat, DateTimeStyles.AllowWhiteSpaces);
        //}else
        //{
        //    endDate = null;
        //}

        int? numOfbooks = ToNullableInt(txtNoOfBooks.Value.ToString());
        int? counterNo = ToNullableInt(ddlCounter.SelectedValue.ToString());
        if (hfGender.Value.Equals("1"))
        {
            gender = 1;

        }
        else
        {
            gender = 0;
        }
        new StatisticsReportForReferenceServicesDataContext().GeneralCollectionEdit(int.Parse(Request["num"].ToString()), userID, int.Parse(hfVistorID.Value.ToString()) ,hfName.Value.ToString(), gender,counterNo,  startDate, numOfbooks, hfMobile.Value.ToString(), ref result);
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
            var q = srfs.GeneralCollectionSearch(int.Parse(Request["num"].ToString()), null, null, null, null, null,null, null).Single<GeneralCollectionSearchResult>();
            txtUserName.Value = q.Vistor_Name.ToString();
            txtMobile.Value = q.MobileNo.ToString();
            ddlCounter.SelectedValue = q.Counter_ID.ToString();
            txtUserCode.Value = q.Vistor_ID.ToString();
            txtNoOfBooks.Value = q.NoBooks.ToString();
            //rblGender.SelectedValue = q.Customer_Gender.ToString();

            if (q.Gender == 1)
            {
                lblGender.Text = "ذكر";
                hfGender.Value = "1";

            }
            else
            {
                lblGender.Text = "انثى";
                hfGender.Value = "0";
            }
            txtSearch.Value = q.Vistor_ID.ToString();
           
            popupDatepicker.Value = cal.GregToHijri(q.Receive_Date.ToString());
            //popupDatepickerEnd.Value = cal.GregToHijri(q.Finsh_date.ToString());
            hfVistorID.Value = q.Vistor_ID.ToString();
            hfName.Value = q.Vistor_Name;
            hfMobile.Value = q.MobileNo;

        }
        else
        {
            var q = srfs.GeneralCollectionSearchWithUsers(int.Parse(Request["num"].ToString()), userID, null, null, null, null,null,null).Single<GeneralCollectionSearchWithUsersResult>();
            txtUserName.Value = q.Vistor_Name.ToString();
            txtMobile.Value = q.MobileNo.ToString();
            ddlCounter.SelectedValue = q.Counter_ID.ToString();
            txtUserCode.Value = q.Vistor_ID.ToString();
            txtNoOfBooks.Value = q.NoBooks.ToString();

            if (q.Gender == 1)
            {
                lblGender.Text = "ذكر";

            }
            else
            {
                lblGender.Text = "انثى";
            }
            //rblGender.SelectedValue = q.Customer_Gender.ToString();
           
            popupDatepicker.Value = cal.GregToHijri(q.Receive_Date.ToString());
            //popupDatepickerEnd.Value = cal.GregToHijri(q.Finsh_date.ToString());
            hfName.Value = q.Vistor_Name;
            hfMobile.Value = q.MobileNo;
        }
    }

    public int? ToNullableInt(string s)
    {
        int i;
        if (int.TryParse(s, out i)) return i;
        return null;
    }
}