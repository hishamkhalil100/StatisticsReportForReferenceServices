using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_Admin : System.Web.UI.MasterPage
{
    private string _userId;
    private string _userGroups;
    protected void Page_Load(object sender, EventArgs e)
    {


        if (!IsPostBack)
        {

            if (Request.Cookies["UserWebsiteId"] == null)
                Response.Redirect("~/Default.aspx?page=" + Request.RawUrl);
            RestPagesDisplay();

            var q = new StatisticsReportForReferenceServicesDataContext().GetGroupsByUserID(new CookieSecurityProvider().Unprotect(Request.Cookies["UserWebsiteId"].Value.ToString())).ToList<GetGroupsByUserIDResult>();
            foreach (var item in q)
            {
                spnUserName.InnerText = item.User_Name;
                RolePagesDisplay(item.Group_ID);
            }
        }
    }

    private void RolePagesDisplay(int groupId)
    {
        switch (groupId)
        {
            case (int)Helper.GroupsEnum.ItemsAdmin:
                liItemsAdd.Visible = true;
                liItemsSearch.Visible = true;
                liUsersManagement.Visible = true;
                liStatistics.Visible = true;
                break;
            case (int)Helper.GroupsEnum.Items:
                liItemsAdd.Visible = true;
                liItemsSearch.Visible = true;
                break;
            case (int)Helper.GroupsEnum.GeneralCollection:
                liGeneralCollectionAdd.Visible = true;
                break;
            case (int)Helper.GroupsEnum.GeneralCollectionAdmin:
                liGeneralCollectionAdd.Visible = true;
                liUsersManagement.Visible = true;
                liGeneralCollectionStat.Visible = true;
                break;
            case (int)Helper.GroupsEnum.Photocopy:
                liPhotocopyAdd.Visible = true;
                break;
            case (int)Helper.GroupsEnum.PhotocopyAdmin:
                liPhotocopyAdd.Visible = true;
                liUsersManagement.Visible = true;
                liPhotocopyStat.Visible = true;
                break;
            case (int)Helper.GroupsEnum.SortingAndOrganize:
                liOrignizationAndSorting.Visible = true;
                break;
            case (int)Helper.GroupsEnum.SortingAndOrganizeAdmin:
                liOrignizationAndSorting.Visible = true;
                liUsersManagement.Visible = true;
                liOrignizationAndSortingStat.Visible = true;
                break;
            case (int)Helper.GroupsEnum.BooksReceived:
                liBooksFromIndexAdd.Visible = true;
                break;
            case (int)Helper.GroupsEnum.BooksReceivedAdmin:
                liBooksFromIndexAdd.Visible = true;
                liUsersManagement.Visible = true;
                liBooksFromIndexStat.Visible = true;
                break;
            case (int)Helper.GroupsEnum.Admin:
                liItemsAdd.Visible = true;
                liItemsSearch.Visible = true;
                liUsersManagement.Visible = true;
                liStatistics.Visible = true;
                liGeneralCollectionAdd.Visible = true;
                liPhotocopyAdd.Visible = true;
                liOrignizationAndSorting.Visible = true;
                liPhotocopyStat.Visible = true;
                liGeneralCollectionStat.Visible = true;
                liBooksFromIndexStat.Visible = true;
                liOrignizationAndSortingStat.Visible = true;

                break;
        }



    }



    private void RestPagesDisplay()
    {
        liItemsAdd.Visible = false;
        liItemsSearch.Visible = false;
        liUsersManagement.Visible = false;
        liStatistics.Visible = false;
        liGeneralCollectionAdd.Visible = false;
        liOrignizationAndSorting.Visible = false;
        liPhotocopyAdd.Visible = false;
        liBooksFromIndexStat.Visible = false;
        liGeneralCollectionStat.Visible = false;
        liOrignizationAndSortingStat.Visible = false;
        liPhotocopyStat.Visible = false;

    }

}
