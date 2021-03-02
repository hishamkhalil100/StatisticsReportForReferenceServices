using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_OrignizationAndSorting : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
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
                    Response.Redirect("PhotocopyAdd.aspx");
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
     
        txtBinding.Value = string.Empty;
        txtExclude.Value = string.Empty;
        txtReindex.Value = string.Empty;
        txtRelabel.Value = string.Empty;

    }
    private int?[] insert()
    {
        int? result = null;
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
        int? numOfReindex = ToNullableInt(txtReindex.Value.ToString());
        int? numOfRebinding = ToNullableInt(txtBinding.Value.ToString());
        int? numOfLabel = ToNullableInt(txtRelabel.Value.ToString());
        int? numOfExclude = ToNullableInt(txtExclude.Value.ToString());


        var q = new StatisticsReportForReferenceServicesDataContext().SortingAndOrgnizeAdd(Request.Cookies["UserWebsiteId"].Value.ToString(), startDate,
              numOfReindex, numOfLabel, numOfRebinding,
              numOfExclude,
            ref result).Single<SortingAndOrgnizeAddResult>();
        int?[] arr = { result, q.ID };
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

        int? numOfReindex = ToNullableInt(txtReindex.Value.ToString());
        int? numOfRebinding = ToNullableInt(txtBinding.Value.ToString());
        int? numOfLabel = ToNullableInt(txtRelabel.Value.ToString());
        int? numOfExclude = ToNullableInt(txtExclude.Value.ToString());

       
        new StatisticsReportForReferenceServicesDataContext().SortingAndOrgnizeEdit(
            int.Parse(Request["num"].ToString()), Request.Cookies["UserWebsiteId"].Value.ToString(),
            startDate, numOfReindex, numOfLabel, numOfRebinding, numOfExclude, ref result);
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
        var qu = srfs.UsersSearch(Request.Cookies["UserWebsiteId"].Value.ToString()).Single<UsersSearchResult>();
        DateHG cal = new DateHG();
        if (qu.User_Role.Equals("admin"))
        {
            var q = srfs.PhotocopySearch(int.Parse(Request["num"].ToString()), null, null, null, null, null, null).Single<PhotocopySearchResult>();
            txtUserName.Value = q.Vistor_Name.ToString();
            txtMobile.Value = q.MobileNo.ToString();
            txtUserCode.Value = q.Vistor_ID.ToString();
            txtNoOfBooks.Value = q.NoBooks.ToString();
            txtNoOfPages.Value = q.NoPages.ToString();
            //rblGender.SelectedValue = q.Customer_Gender.ToString();


            popupDatepicker.Value = cal.GregToHijri(q.Receive_Date.ToString());
            //popupDatepickerEnd.Value = cal.GregToHijri(q.Finsh_date.ToString());
      

        }
        else
        {
            var q = srfs.PhotocopySearchWithUsers(int.Parse(Request["num"].ToString()), Request.Cookies["UserWebsiteId"].Value.ToString(), null, null, null, null, null).Single<PhotocopySearchWithUsersResult>();
          
            int? numOfReindex = ToNullableInt(txtReindex.Value.ToString());
            int? numOfRebinding = ToNullableInt(txtBinding.Value.ToString());
            int? numOfLabel = ToNullableInt(txtRelabel.Value.ToString());
            int? numOfExclude = ToNullableInt(txtExclude.Value.ToString());

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