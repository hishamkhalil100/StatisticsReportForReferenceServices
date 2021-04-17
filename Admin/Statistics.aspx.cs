using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

public partial class Admin_Statistics : System.Web.UI.Page
{

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            HtmlGenericControl ControlID = (HtmlGenericControl)Master.FindControl("liStatistics");
            ControlID.Attributes["class"] = "has-sub active";
            Helper.GroupsEnum[] allowedGroups =
                {Helper.GroupsEnum.Admin, Helper.GroupsEnum.ItemsAdmin};
            if (Request.Cookies["SecurityType"] != null && !Helper.IsAuthorize(new CookieSecurityProvider().Unprotect(Request.Cookies["SecurityType"].Value), allowedGroups))
            {
                Response.Redirect("/Default.aspx");
            }
            try
            {
                GetRealDept();
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
        bindRowTwo();
        bindRowThree();
    }
    private void bindRowOne()
    {
        int total = 0;
        int male = 0;
        int female = 0;
        int ar = 0;
        int eng = 0;
        int monawla = 0;
        int mail = 0;
        int email = 0;
        int phone = 0;
        int fax = 0;
        int am = 0;
        int pm = 0;
        int index = 0;
        int infoDb = 0;
        int Phd = 0;
        int master = 0;
        int Bac = 0;
        int Othor = 0;
        int book = 0;
        int article = 0;
        int thesis = 0;
        int document = 0;
        int image = 0;
        int manuscript = 0;
        int numOfItems = 0;
        int numOfPages = 0;
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

        var q = new StatisticsReportForReferenceServicesDataContext().StatisticsSearch(startDate, endDate, txtUserName.Text.Trim(), 1, null).ToArray<StatisticsSearchResult>();
        if (!string.IsNullOrEmpty(ddlDepartment.SelectedValue.ToString()))
            q = new StatisticsReportForReferenceServicesDataContext().StatisticsSearch(startDate, endDate, txtUserName.Text.Trim(), 1, int.Parse(ddlDepartment.SelectedValue.ToString())).ToArray<StatisticsSearchResult>();
        foreach (var item in q)
        {
            total++;
            if (item.Send_Method == 0)
            {
                monawla++;
            }
            else if (item.Send_Method == 1)
            {
                mail++;
            }
            else if (item.Send_Method == 2)
            {
                email++;
            }
            else if (item.Send_Method == 3)
            {
                fax++;
            }
            else if (item.Send_Method == 4)
            {
                phone++;
            }
            if (item.Period == 0)
            {
                am++;
            }
            else if (item.Period == 1)
            {
                pm++;
            }

            if (item.Language == 0)
            {
                ar++;
            }
            else if (item.Language == 1)
            {
                eng++;
            }
            if (item.Customer_Gender == 0)
            {
                female++;
            }
            else if (item.Customer_Gender == 1)
            {
                male++;
            }
            if (item.Search_Type == 0)
            {
                index++;
            }
            else if (item.Search_Type == 1)
            {
                infoDb++;
            }

            if (item.Degree == 0)
            {
                Phd++;
            }
            else if (item.Degree == 1)
            {
                master++;
            }
            else if (item.Degree == 2)
            {
                Bac++;
            }
            else if (item.Degree == 3)
            {
                Othor++;
            }

            if (item.IsBook)
                book++;
            if (item.IsArticle)
                article++;
            if (item.IsThesis)
                thesis++;
            if (item.IsDocument)
                document++;
            if (item.IsImage)
                image++;
            if (item.IsManuscript)
                manuscript++;
            int tempNumOfPages = int.TryParse(item.NumOfPages.ToString() , out tempNumOfPages) ? tempNumOfPages : 0;
            int tempNumOfItems = int.TryParse(item.NumOfItems.ToString(), out tempNumOfItems) ? tempNumOfItems : 0;
            numOfPages += tempNumOfPages;
            numOfItems += tempNumOfItems;
        }
        lblTotal.Text = total.ToString();
        lblAr.Text = ar.ToString();
        lblEng.Text = eng.ToString();
        lblMonawla.Text = monawla.ToString();
        lblMail.Text = mail.ToString();
        lblEmail.Text = email.ToString();
        lblFax.Text = fax.ToString();
        lblPhone.Text = phone.ToString();
        lblAM.Text = am.ToString();
        lblPM.Text = pm.ToString();
        lblIndex.Text = index.ToString();
        lblInfoDB.Text = infoDb.ToString();
        lblPhd.Text = Phd.ToString();
        lblmaster.Text = master.ToString();
        lblBac.Text = Bac.ToString();
        lblOthor.Text = Othor.ToString();
        lblBooks.Text = book.ToString();
        lblArticle.Text = article.ToString();
        lblThesis.Text = thesis.ToString();
        lblDocuments.Text = document.ToString();
        lblImages.Text = image.ToString();
        lblManuscripts.Text = manuscript.ToString();
        lblNumOfPages.Text = numOfPages.ToString();
        lblNumOfItems.Text = numOfItems.ToString();
       
    }
    private void bindRowTwo()
    {
        int total = 0;
        int male = 0;
        int female = 0;
        int ar = 0;
        int eng = 0;
        int monawla = 0;
        int mail = 0;
        int email = 0;
        int phone = 0;
        int fax = 0;
        int am = 0;
        int pm = 0;
        int index = 0;
        int infoDb = 0;
        int Phd = 0;
        int master = 0;
        int Bac = 0;
        int Othor = 0;
        int book = 0;
        int article = 0;
        int thesis = 0;
        int document = 0;
        int image = 0;
        int manuscript = 0;
        int numOfItems = 0;
        int numOfPages = 0;
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

        var q = new StatisticsReportForReferenceServicesDataContext().StatisticsSearch(startDate, endDate, txtUserName.Text.Trim(), 0, null).ToArray<StatisticsSearchResult>();
        if (!string.IsNullOrEmpty(ddlDepartment.SelectedValue.ToString()))
            q = new StatisticsReportForReferenceServicesDataContext().StatisticsSearch(startDate, endDate, txtUserName.Text.Trim(), 0, int.Parse(ddlDepartment.SelectedValue.ToString())).ToArray<StatisticsSearchResult>();
        foreach (var item in q)
        {
            total++;
            if (item.Send_Method == 0)
            {
                monawla++;
            }
            else if (item.Send_Method == 1)
            {
                mail++;
            }
            else if (item.Send_Method == 2)
            {
                email++;
            }
            else if (item.Send_Method == 3)
            {
                fax++;
            }
            else if (item.Send_Method == 4)
            {
                phone++;
            }
            if (item.Period == 0)
            {
                am++;
            }
            else if (item.Period == 1)
            {
                pm++;
            }

            if (item.Language == 0)
            {
                ar++;
            }
            else if (item.Language == 1)
            {
                eng++;
            }
            if (item.Customer_Gender == 0)
            {
                female++;
            }
            else if (item.Customer_Gender == 1)
            {
                male++;
            }
            if (item.Search_Type == 0)
            {
                index++;
            }
            else if (item.Search_Type == 1)
            {
                infoDb++;
            }
            if (item.Degree == 0)
            {
                Phd++;
            }
            else if (item.Degree == 1)
            {
                master++;
            }
            else if (item.Degree == 2)
            {
                Bac++;
            }
            else if (item.Degree == 3)
            {
                Othor++;
            }
            if (item.IsBook)
                book++;
            if (item.IsArticle)
                article++;
            if (item.IsThesis)
                thesis++;
            if (item.IsDocument)
                document++;
            if (item.IsImage)
                image++;
            if (item.IsManuscript)
                manuscript++;
            int tempNumOfPages = int.TryParse(item.NumOfPages.ToString(), out tempNumOfPages) ? tempNumOfPages : 0;
            int tempNumOfItems = int.TryParse(item.NumOfItems.ToString(), out tempNumOfItems) ? tempNumOfItems : 0;
            numOfPages += tempNumOfPages;
            numOfItems += tempNumOfItems;
        }
        lblTotal2.Text = total.ToString();
        lblAr2.Text = ar.ToString();
        lblEng2.Text = eng.ToString();
        lblMonawla2.Text = monawla.ToString();
        lblMail2.Text = mail.ToString();
        lblEmail2.Text = email.ToString();
        lblFax2.Text = fax.ToString();
        lblPhone2.Text = phone.ToString();
        lblAM2.Text = am.ToString();
        lblPM2.Text = pm.ToString();
        lblIndex2.Text = index.ToString();
        lblInfoDB2.Text = infoDb.ToString();
        lblPhd2.Text = Phd.ToString();
        lblmaster2.Text = master.ToString();
        lblBac2.Text = Bac.ToString();
        lblOthor2.Text = Othor.ToString();
        lblBooks2.Text = book.ToString();
        lblArticle2.Text = article.ToString();
        lblThesis2.Text = thesis.ToString();
        lblDocuments2.Text = document.ToString();
        lblImages2.Text = image.ToString();
        lblManuscripts2.Text = manuscript.ToString();
        lblNumOfPages2.Text = numOfPages.ToString();
        lblNumOfItems2.Text = numOfItems.ToString();
    }
    private void bindRowThree()
    {
        int total = 0;
        int male = 0;
        int female = 0;
        int ar = 0;
        int eng = 0;
        int monawla = 0;
        int mail = 0;
        int email = 0;
        int phone = 0;
        int fax = 0;
        int am = 0;
        int pm = 0;
        int index = 0;
        int infoDb = 0;
        int Phd = 0;
        int master = 0;
        int Bac = 0;
        int Othor = 0;
        int book = 0;
        int article = 0;
        int thesis = 0;
        int document = 0;
        int image = 0;
        int manuscript = 0;
        int numOfItems = 0;
        int numOfPages = 0;
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
        var q = new StatisticsReportForReferenceServicesDataContext().StatisticsSearch(startDate, endDate, txtUserName.Text.Trim(), null, null).ToArray<StatisticsSearchResult>();
        if (!string.IsNullOrEmpty(ddlDepartment.SelectedValue.ToString()))
            q = new StatisticsReportForReferenceServicesDataContext().StatisticsSearch(startDate, endDate, txtUserName.Text.Trim(), null, int.Parse(ddlDepartment.SelectedValue.ToString())).ToArray<StatisticsSearchResult>();
        lblTotal3.Text = q.Length.ToString();
        foreach (var item in q)
        {
            total++;
            if (item.Send_Method == 0)
            {
                monawla++;
            }
            else if (item.Send_Method == 1)
            {
                mail++;
            }
            else if (item.Send_Method == 2)
            {
                email++;
            }
            else if (item.Send_Method == 3)
            {
                fax++;
            }
            else if (item.Send_Method == 4)
            {
                phone++;
            }
            if (item.Period == 0)
            {
                am++;
            }
            else if (item.Period == 1)
            {
                pm++;
            }

            if (item.Language == 0)
            {
                ar++;
            }
            else if (item.Language == 1)
            {
                eng++;
            }
            if (item.Customer_Gender == 0)
            {
                female++;
            }
            else if (item.Customer_Gender == 1)
            {
                male++;
            }
            if (item.Search_Type == 0)
            {
                index++;
            }
            else if (item.Search_Type == 1)
            {
                infoDb++;
            }
            if (item.Degree == 0)
            {
                Phd++;
            }
            else if (item.Degree == 1)
            {
                master++;
            }
            else if (item.Degree == 2)
            {
                Bac++;
            }
            else if (item.Degree == 3)
            {
                Othor++;
            }
            if (item.IsBook)
                book++;
            if (item.IsArticle)
                article++;
            if (item.IsThesis)
                thesis++;
            if (item.IsDocument)
                document++;
            if (item.IsImage)
                image++;
            if (item.IsManuscript)
                manuscript++;
            int tempNumOfPages = int.TryParse(item.NumOfPages.ToString(), out tempNumOfPages) ? tempNumOfPages : 0;
            int tempNumOfItems = int.TryParse(item.NumOfItems.ToString(), out tempNumOfItems) ? tempNumOfItems : 0;
            numOfPages += tempNumOfPages;
            numOfItems += tempNumOfItems;
        }
        lblTotal3.Text = total.ToString();
        lblAr3.Text = ar.ToString();
        lblEng3.Text = eng.ToString();
        lblMonawla3.Text = monawla.ToString();
        lblMail3.Text = mail.ToString();
        lblEmail3.Text = email.ToString();
        lblFax3.Text = fax.ToString();
        lblPhone3.Text = phone.ToString();
        lblAM3.Text = am.ToString();
        lblPM3.Text = pm.ToString();
        lblIndex3.Text = index.ToString();
        lblInfoDB3.Text = infoDb.ToString();
        lblPhd3.Text = Phd.ToString();
        lblmaster3.Text = master.ToString();
        lblBac3.Text = Bac.ToString();
        lblOthor3.Text = Othor.ToString();
        lblBooks3.Text = book.ToString();
        lblArticle3.Text = article.ToString();
        lblThesis3.Text = thesis.ToString();
        lblDocuments3.Text = document.ToString();
        lblImages3.Text = image.ToString();
        lblManuscripts3.Text = manuscript.ToString();
        lblNumOfPages3.Text = numOfPages.ToString();
        lblNumOfItems3.Text = numOfItems.ToString();
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
    private void GetRealDept()
    {
        try
        {
            var query = new StatisticsReportForReferenceServicesDataContext().GetRealDepartments().ToList<GetRealDepartmentsResult>();
            ddlDepartment.DataTextField = "Department_Name";
            ddlDepartment.DataValueField = "Department_id";
            ddlDepartment.DataSource = query;

            ddlDepartment.DataBind();
            ListItem l = new ListItem("--إختر الإدارة--", "", true);
            l.Selected = true;
            ddlDepartment.Items.Insert(0, l);

        }
        catch (Exception ex)
        {
            Helper.LogError(ex.Message, ex.StackTrace);
            //  Response.Redirect("/Admin/Error.aspx");
        }
    }
}