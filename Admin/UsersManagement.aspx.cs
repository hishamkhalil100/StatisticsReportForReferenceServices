using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.DirectoryServices;
using System.DirectoryServices.AccountManagement;
public partial class Admin_UsersManagement : System.Web.UI.Page
{
    #region Events
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            GetAllDepartments();
            GetRealDept();
            BindData();
        }
        else
        {
            divNotifi.Visible = false;
            BindData();
        }

    }



    protected void ddlDepartments_SelectedIndexChanged(object sender, EventArgs e)
    {
        GetAllUsersByDepartment();
    }
    protected void btnReset_Click(object sender, EventArgs e)
    {
        Reset();
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        int? result = null;

        //edit case 
        if (ViewState["ID"] != null)
        {
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
                    divNotifi.Visible = true;
                    ViewState["ID"] = null;
                    ddlDepartments.Enabled = true;
                    ddlUsers.Enabled = true;
                    divNotifi.Attributes.Add("class", "alert alert-block alert-success fade in");
                    lblDivNotifiTitle.Text = "تم !";
                    pDivNotifiDesc.InnerText = "تم تعديل الموظف بنجاح";
                }
                else if (result == -2)
                {
                    divNotifi.Visible = true;
                    divNotifi.Attributes.Add("class", "alert alert-block alert-error fade in");
                    lblDivNotifiTitle.Text = "خطأ !";
                    pDivNotifiDesc.InnerText = "عذرا اتصل بمسؤول النظام";
                }
                Reset();
                BindData();
            }
        }
        // add case 
        else
        {
            try
            {
                result = Insert();
            }
            catch (Exception ex)
            {
                Helper.LogError(ex.Message, ex.StackTrace);
                // case of user is aready in the system 
                var query = new StatisticsReportForReferenceServicesDataContext().GetAllUsers().ToList<GetAllUsersResult>();
                result = -2;
                foreach (var item in query)
                {
                    if (ddlUsers.SelectedValue.Equals(item.User_ID))
                    {
                        result = -3;
                        break;
                    }

                }
            }
            finally
            {
                if (result == 1)
                {
                    divNotifi.Visible = true;
                    divNotifi.Attributes.Add("class", "alert alert-block alert-success fade in");
                    lblDivNotifiTitle.Text = "تم !";
                    pDivNotifiDesc.InnerText = "تم اضافة الموظف بنجاح";
                }
                else if (result == -2)
                {
                    divNotifi.Visible = true;
                    divNotifi.Attributes.Add("class", "alert alert-block alert-error fade in");
                    lblDivNotifiTitle.Text = "خطأ !";
                    pDivNotifiDesc.InnerText = "عذرا اتصل بمسؤول النظام";
                }
                else if (result == -3)
                {
                    divNotifi.Visible = true;
                    divNotifi.Attributes.Add("class", "alert alert-block alert-error fade in");
                    lblDivNotifiTitle.Text = "خطأ !";
                    pDivNotifiDesc.InnerText = "عذرا هذا الموظف موجود مسبقا";
                }
                Reset();
                BindData();
            }
        }
    }
    protected void dlUsers_ItemCommand(object source, DataListCommandEventArgs e)
    {
        try
        {

            if (e.CommandName.ToString() == "edititem")
            {
                ViewState["ID"] = e.CommandArgument.ToString();
                getData();
            }

            if (e.CommandName.ToString() == "stateitem")
            {
                new StatisticsReportForReferenceServicesDataContext().User_Is_LockedEdit(e.CommandArgument.ToString());
                divNotifi.Visible = true;
                divNotifi.Attributes.Add("class", "alert alert-block alert-success fade in");
                lblDivNotifiTitle.Text = "تم !";
                pDivNotifiDesc.InnerText = "تم تعديل حالة الموظف بنجاح";
                Reset();
                BindData();

            }
        }
        catch (Exception ex)
        {
            Helper.LogError(ex.Message, ex.StackTrace);
            Response.Redirect("/Admin/Error.aspx");

        }
    }
    protected void dlUsers_ItemDataBound(object sender, DataListItemEventArgs e)
    {
        string id = ((Label)e.Item.FindControl("lblID")).Text;
        var q = new StatisticsReportForReferenceServicesDataContext().UsersSearch(id).Single();
        if (q.User_Is_Locked)
        {
            ((LinkButton)e.Item.FindControl("lnkbtnState")).Attributes.Remove("class");
            ((LinkButton)e.Item.FindControl("lnkbtnState")).Attributes.Add("class", "btn btn-danger");
            ((Label)e.Item.FindControl("lblUserState")).Text = "تفعيل";

        }
        else
        {
            ((LinkButton)e.Item.FindControl("lnkbtnState")).Attributes.Remove("class");
            ((LinkButton)e.Item.FindControl("lnkbtnState")).Attributes.Add("class", "btn btn-success");
            ((Label)e.Item.FindControl("lblUserState")).Text = "تعطيل";
        }
    }
    #endregion
    #region methods
    private void GetAllDepartments()
    {
        try
        {
            var query = new StatisticsReportForReferenceServicesDataContext().GetAllDepartments().ToList<GetAllDepartmentsResult>();
            ddlDepartments.DataTextField = "Department_Name";
            ddlDepartments.DataValueField = "Department_Domain";
            ddlDepartments.DataSource = query;
            ddlDepartments.DataBind();
            GetAllUsersByDepartment();
        }
        catch (Exception ex)
        {
            Helper.LogError(ex.Message, ex.StackTrace);
            Response.Redirect("/Admin/Error.aspx");
        }
    }
    private void GetRealDept()
    {
        try
        {
            var query = new StatisticsReportForReferenceServicesDataContext().GetRealDepartments().ToList<GetRealDepartmentsResult>();
            ddlRealDep.DataTextField = "Department_Name";
            ddlRealDep.DataValueField = "Department_Id";
            ddlRealDep.DataSource = query;
            ddlRealDep.DataBind();
        }
        catch (Exception ex)
        {
            Helper.LogError(ex.Message, ex.StackTrace);
            Response.Redirect("/Admin/Error.aspx");
        }
    }
    private void GetAllUsersByDepartment()
    {
        try
        {
            ddlUsers.DataTextField = "DisplayName";
            ddlUsers.DataValueField = "UserName";
            ddlUsers.DataSource = new ActiveDirectoryManagment().GetADUsersByGroup(ddlDepartments.SelectedValue);
            ddlUsers.DataBind();
        }
        catch (Exception ex)
        {
            Helper.LogError(ex.Message, ex.StackTrace);
            Response.Redirect("/Admin/Error.aspx");
        }
    }
    private int? Insert()
    {

        int? result = null;
        new StatisticsReportForReferenceServicesDataContext().UsersAdd(ddlUsers.SelectedValue.ToString(), txtUserName.Text.ToString(), rblRole.SelectedValue.ToString(), int.Parse(ddlRealDep.SelectedValue.ToString()), ref result);
        return result;
    }
    private int? Edit()
    {
        int? result = null;
        new StatisticsReportForReferenceServicesDataContext().UsersEdit(ViewState["ID"].ToString(), txtUserName.Text.ToString(), rblRole.SelectedValue.ToString(), int.Parse(ddlRealDep.SelectedValue.ToString()), ref result);
        return result;
    }
    private void BindData()
    {
        var Query = new StatisticsReportForReferenceServicesDataContext().GetAllUsers().ToList<GetAllUsersResult>();
        dlUsers.DataSource = Query;
        dlUsers.DataBind();
    }
    private void getData()
    {
        if (ViewState["ID"] != null)
        {
            string ID = ViewState["ID"].ToString();
            var QUERY = new StatisticsReportForReferenceServicesDataContext().UsersSearch(ID).ToList<UsersSearchResult>();
            foreach (var item in QUERY)
            {
                txtUserName.Text = item.User_Name;
                rblRole.SelectedValue = item.User_Role;
                ddlDepartments.SelectedValue = ActiveDirectoryManagment.GetDepartment(ID);
                GetAllUsersByDepartment();
                ddlUsers.SelectedValue = ID;
                ddlRealDep.SelectedValue = item.DepartmentID.ToString();
            }
            ddlDepartments.Enabled = false;
            ddlUsers.Enabled = false;
        }
    }
    private void Reset()
    {
        if (ViewState["ID"] != null)
        {
            getData();
        }
        else
        {
            GetAllDepartments();
            GetAllUsersByDepartment();
            GetRealDept();
            txtUserName.Text = string.Empty;
            rblRole.SelectedIndex = 1;// employee
        }
    }
    #endregion
}
