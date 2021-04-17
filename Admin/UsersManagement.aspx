<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.master" AutoEventWireup="true" CodeFile="UsersManagement.aspx.cs" Inherits="Admin_UsersManagement" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style type="text/css">
        .rblStyle label {
            float: right;
            margin-right: 15px;
        }
        .rblStyle div {
            float: right;
         
        }
        .textTable th {
            text-align: center;
        }

        .textTable td {
            text-align: center;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:ScriptManager runat="server"></asp:ScriptManager>

    <div class="space7"></div>
    <!-- BEGIN PAGE CONTENT-->
    <div id="page" class="dashboard">

        <div class="row-fluid">
            <div class="span12">
                <!-- BEGIN RECENT ORDERS PORTLET-->
                <div class="widget">
                    <div class="widget-title">
                        <h4><i class="icon-tags"></i>اضافة موظف جديد</h4>
                        <span class="tools">
                            <a href="javascript:;" class="icon-chevron-down"></a>
                            <a href="javascript:;" class="icon-remove"></a>
                        </span>
                    </div>
                    <div class="widget-body">

                        <div id="divNotifi" runat="server" visible="false">
                            <button class="close" type="button" data-dismiss="alert">×</button>
                            <h4 class="alert-heading">
                                <asp:Label ID="lblDivNotifiTitle" runat="server"></asp:Label></h4>
                            <p id="pDivNotifiDesc" runat="server">
                            </p>
                        </div>
                        <div class="form-horizontal">
                            <div class="control-group">
                                <label class="control-label">الإدارة*</label>
                                <asp:DropDownList ID="ddlDepartments" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlDepartments_SelectedIndexChanged" CssClass="input-large m-wrap"></asp:DropDownList>
                                <asp:RequiredFieldValidator ID="rfvddlDepartmenst" runat="server" ValidationGroup="AddGroup" SetFocusOnError="true" ControlToValidate="ddlDepartments" ErrorMessage="من فضلك اختر الإدارة"></asp:RequiredFieldValidator>
                            </div>
                            <div class="control-group">
                                <label class="control-label">الموظف*</label>
                                <asp:DropDownList ID="ddlUsers" runat="server" CssClass="input-large m-wrap input-error tooltips"></asp:DropDownList>
                                <asp:RequiredFieldValidator ID="rfvddlUsers" runat="server" ValidationGroup="AddGroup" SetFocusOnError="true" ControlToValidate="ddlUsers" ErrorMessage="من فضلك اختر الموظف"></asp:RequiredFieldValidator>
                            </div>
                            <div class="control-group">
                                <label class="control-label">اسم الموظف*</label>
                                <asp:TextBox ID="txtUserName" runat="server" CssClass="input-large"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvtxtUserName" runat="server" ValidationGroup="AddGroup" SetFocusOnError="true" ControlToValidate="txtUserName" ErrorMessage="من فضلك ادخل اسم الموظف"></asp:RequiredFieldValidator>
                            </div>
                            <div class="control-group">
                                <label class="control-label">إدارة الموظف الفعلية*</label>
                                <asp:DropDownList ID="ddlRealDep" runat="server" AutoPostBack="true"  CssClass="input-large m-wrap"></asp:DropDownList>
                                <asp:RequiredFieldValidator ID="rfvddlRealDep" runat="server" ValidationGroup="AddGroup" SetFocusOnError="true" ControlToValidate="ddlRealDep" ErrorMessage="من فضلك اختر إدارة الموظف الفعلية"></asp:RequiredFieldValidator>
                            </div>
                            <div class="control-group">
                                <label class="control-label">نوع الصلاحية*</label>
                                <asp:CheckBoxList ID="rblRole" runat="server" RepeatDirection="Vertical"  Enabled="true" CssClass="rblStyle">
                                </asp:CheckBoxList>
                            </div>
                            <div class="form-actions">
                                <asp:Button ID="btnReset" runat="server" Text="تفريغ الحقول" CssClass="btn btn-info" OnClick="btnReset_Click" />
                                <asp:Button ID="btnAdd" runat="server" Text="حفظ" CssClass="btn btn-warning" OnClick="btnSave_Click" ValidationGroup="AddGroup" />
                            </div>
                            <div class="space7"></div>
                        </div>
                    </div>
                </div>
                <!-- END RECENT ORDERS PORTLET-->
            </div>
        </div>
        <!-- END PAGE CONTENT-->
        <div class="row-fluid">
            <div class="span12">
                <!-- BEGIN SAMPLE TABLE widget-->
                <div class="widget">
                    <div class="widget-title">
                        <h4><i class="icon-cogs"></i>الموظفين</h4>
                        <span class="tools">
                            <a class="icon-chevron-down" href="javascript:;"></a>
                            <a class="icon-remove" href="javascript:;"></a>
                        </span>
                    </div>
                    <div class="widget-body">
                        <table class="table table-striped table-bordered table-advance table-hover textTable">
                            <thead>
                                <tr>
                                    <th><i class="icon-briefcase"></i>&nbsp; اسم الموظف</th>
                                    <th><i class="icon-cogs"></i>&nbsp; الخيارات</th>
                                </tr>
                            </thead>
                            <asp:DataList ID="dlUsers" runat="server" OnItemCommand="dlUsers_ItemCommand" OnItemDataBound="dlUsers_ItemDataBound" Width="100%" RepeatLayout="Flow" RepeatDirection="Horizontal">
                                <ItemTemplate>
                                    <tbody>
                                        <tr>
                                            <td class="highlight">
                                                <div class="success"></div>
                                                <asp:Label ID="lblUserName" runat="server" Text='<%# Eval("User_Name")%>' />
                                            </td>
                                            <td>
                                                <asp:Label ID="lblID" runat="server" Text='<%# Eval("User_ID")%>' Visible="false" />
                                                <asp:LinkButton ID="lnkbtnEdit" runat="server" CssClass="btn mini purple" CommandArgument='<%# DataBinder.Eval(Container.DataItem,"User_ID") %>' CommandName="edititem"><i class="fa fa-pencil icon-white"></i> &nbsp; تعديل</asp:LinkButton>
                                                <asp:LinkButton ID="lnkbtnState" runat="server" CommandArgument='<%# DataBinder.Eval(Container.DataItem,"User_ID") %>' CommandName="stateitem">
                                                    <i class="fa fa-eye"></i>&nbsp;
                                                    <asp:Label ID="lblUserState" runat="server"></asp:Label>
                                                </asp:LinkButton>
                                            </td>
                                        </tr>
                                    </tbody>
                                </ItemTemplate>
                            </asp:DataList>
                        </table>
                    </div>
                </div>
                <!-- END SAMPLE TABLE widget-->
            </div>
        </div>
    </div>
</asp:Content>

