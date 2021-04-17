using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

public partial class Admin_ItemsAdd : System.Web.UI.Page
{
    private string userID;

    protected void Page_Load(object sender, EventArgs e)
    {
       
        if (!IsPostBack)
        {
            HtmlGenericControl ControlID = (HtmlGenericControl)Master.FindControl("liItemsAdd");
            ControlID.Attributes["class"] = "has-sub active";
            var protectedText = Request.Cookies[name: "UserWebsiteId"].Value;
            if (protectedText != null)
            {
                userID = new CookieSecurityProvider().Unprotect(
                    protectedText: protectedText);
                Helper.GroupsEnum[] allowedGroups =
                {
                    Helper.GroupsEnum.Admin, Helper.GroupsEnum.ItemsAdmin,
                    Helper.GroupsEnum.Items
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
                result = Edit();
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
                    Response.Redirect("ItemsAdd.aspx");
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
        rblDegree.SelectedValue = "0";
        rblLang.SelectedValue = "0";
        rblMethod.SelectedValue = "0";
        rblPreiod.SelectedValue = "0";
        rblSearchType.SelectedValue = "0";
        txtNumberOfItems.Value = string.Empty;
        txtNumberOfPages.Value = string.Empty;
        ckItemType.Items[0].Selected = false;
        ckItemType.Items[1].Selected = false;
        ckItemType.Items[2].Selected = false;
        ckItemType.Items[3].Selected = false;
        ckItemType.Items[4].Selected = false;
        ckItemType.Items[5].Selected = false;
    }
    private int?[] Insert()
    {
        int? result = null;
        int? itemID = null;

        DateHG cal = new DateHG();
        DateTime startDate = DateTime.ParseExact(cal.HijriToGreg(InvertDate(popupDatepicker.Value.ToString())), "yyyy/MM/dd", cal.enCul.DateTimeFormat, DateTimeStyles.AllowWhiteSpaces);
        //DateTime? endDate;
        //if (!string.IsNullOrEmpty(popupDatepickerEnd.Value))
        //{
        //    endDate = DateTime.ParseExact(cal.HijriToGreg(invertDate(popupDatepickerEnd.Value.ToString())), "yyyy/MM/dd", cal.enCul.DateTimeFormat, DateTimeStyles.AllowWhiteSpaces);
        //}
        //else
        //{
        //    endDate = null;
        //}
        int? numberOfItems = ToNullableInt(txtNumberOfItems.Value.ToString());
        int? numberOfPages = ToNullableInt(txtNumberOfPages.Value.ToString());



        new StatisticsReportForReferenceServicesDataContext().ItemsAdd(userID, int.Parse(hfVistorID.Value.ToString()),
            hfName.Value.ToString(), int.Parse(hfGender.Value.ToString()),
            startDate, null,
            int.Parse(rblPreiod.SelectedValue.ToString()),
            int.Parse(rblMethod.SelectedValue.ToString()),
            int.Parse(rblLang.SelectedValue.ToString()),
            int.Parse(rblSearchType.SelectedValue.ToString()),
            int.Parse(rblDegree.SelectedValue.ToString()),
            hfMobile.Value.ToString(),
            ckItemType.Items[0].Selected,
            ckItemType.Items[1].Selected,
            ckItemType.Items[2].Selected,
            ckItemType.Items[3].Selected,
            ckItemType.Items[4].Selected,
            ckItemType.Items[5].Selected,
            numberOfItems,
            numberOfPages,
            ref result, ref itemID);
        int?[] arr = { result, itemID };
        return arr;
    }
    private int? Edit()
    {
        int? result = null;
        int gender = 1;
        DateHG cal = new DateHG();
        DateTime startDate = DateTime.ParseExact(cal.HijriToGreg(InvertDate(popupDatepicker.Value.ToString())), "yyyy/MM/dd", cal.enCul.DateTimeFormat, DateTimeStyles.AllowWhiteSpaces);
        //DateTime? endDate;
        //if (!string.IsNullOrEmpty(popupDatepickerEnd.Value))
        //{
        //     endDate = DateTime.ParseExact(cal.HijriToGreg(invertDate(popupDatepickerEnd.Value.ToString())), "yyyy/MM/dd", cal.enCul.DateTimeFormat, DateTimeStyles.AllowWhiteSpaces);
        //}else
        //{
        //    endDate = null;
        //}
        int? numberOfItems = ToNullableInt(txtNumberOfItems.Value.ToString());
        int? numberOfPages = ToNullableInt(txtNumberOfPages.Value.ToString());
        if (lblGender.Text.Equals("ذكر"))
        {
            gender = 1;

        }
        else
        {
            gender = 0;
        }
        new StatisticsReportForReferenceServicesDataContext().ItemsEdit(int.Parse(Request["num"].ToString()), int.Parse(hfVistorID.Value.ToString()), txtUserName.Value.ToString(), gender, startDate, null, int.Parse(rblPreiod.SelectedValue.ToString()), int.Parse(rblMethod.SelectedValue.ToString()), int.Parse(rblLang.SelectedValue.ToString()), int.Parse(rblSearchType.SelectedValue.ToString()), int.Parse(rblDegree.SelectedValue.ToString()), txtMobile.Value.ToString(),
            ckItemType.Items[0].Selected,
            ckItemType.Items[1].Selected,
            ckItemType.Items[2].Selected,
            ckItemType.Items[3].Selected,
            ckItemType.Items[4].Selected,
            ckItemType.Items[5].Selected,
            numberOfItems,
            numberOfPages, ref result);
        return result;
    }
    private string InvertDate(string date)
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
            var q = srfs.ItemsSearchWithUsers(int.Parse(Request["num"].ToString()), null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null).Single<ItemsSearchWithUsersResult>();
            txtUserName.Value = q.Customer_Name.ToString();
            txtMobile.Value = q.Mobile.ToString();
            rblDegree.SelectedValue = q.Degree.ToString();
            //rblGender.SelectedValue = q.Customer_Gender.ToString();

            if (q.Customer_Gender == 1)
            {
                lblGender.Text = "ذكر";

            }
            else
            {
                lblGender.Text = "انثى";
            }
            txtSearch.Value = q.Vistor_ID.ToString();
            rblLang.SelectedValue = q.Language.ToString();
            rblMethod.SelectedValue = q.Send_Method.ToString();
            rblPreiod.SelectedValue = q.Period.ToString();
            rblSearchType.SelectedValue = q.Search_Type.ToString();
            popupDatepicker.Value = cal.GregToHijri(q.Receive_Date.ToString());
            //popupDatepickerEnd.Value = cal.GregToHijri(q.Finsh_date.ToString());
            hfVistorID.Value = q.Vistor_ID.ToString();
            txtNumberOfItems.Value = q.NumOfItems.ToString();
            txtNumberOfPages.Value = q.NumOfPages.ToString();
            ckItemType.Items[0].Selected = q.IsBook;
            ckItemType.Items[1].Selected = q.IsArticle;
            ckItemType.Items[2].Selected = q.IsThesis;
            ckItemType.Items[3].Selected = q.IsDocument;
            ckItemType.Items[4].Selected = q.IsImage;
            ckItemType.Items[5].Selected = q.IsManuscript;

        }
        else
        {
            var q = srfs.ItemsSearchWithUsers(int.Parse(Request["num"].ToString()), userID, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null).Single<ItemsSearchWithUsersResult>();
            txtUserName.Value = q.Customer_Name.ToString();
            txtMobile.Value = q.Mobile.ToString();
            rblDegree.SelectedValue = q.Degree.ToString();

            if (q.Customer_Gender == 1)
            {
                lblGender.Text = "ذكر";

            }
            else
            {
                lblGender.Text = "انثى";
            }
            //rblGender.SelectedValue = q.Customer_Gender.ToString();
            rblLang.SelectedValue = q.Language.ToString();
            rblMethod.SelectedValue = q.Send_Method.ToString();
            rblPreiod.SelectedValue = q.Period.ToString();
            rblSearchType.SelectedValue = q.Search_Type.ToString();
            popupDatepicker.Value = cal.GregToHijri(q.Receive_Date.ToString());
            //popupDatepickerEnd.Value = cal.GregToHijri(q.Finsh_date.ToString());
            txtNumberOfItems.Value = q.NumOfItems.ToString();
            txtNumberOfPages.Value = q.NumOfPages.ToString();
            ckItemType.Items[0].Selected = q.IsBook;
            ckItemType.Items[1].Selected = q.IsArticle;
            ckItemType.Items[2].Selected = q.IsThesis;
            ckItemType.Items[3].Selected = q.IsDocument;
            ckItemType.Items[4].Selected = q.IsImage;
            ckItemType.Items[5].Selected = q.IsManuscript;
        }
    }

    public int? ToNullableInt(string s)
    {
        int i;
        if (int.TryParse(s, out i)) return i;
        return null;
    }
}