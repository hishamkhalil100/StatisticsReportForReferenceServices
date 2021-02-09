<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.master" AutoEventWireup="true" CodeFile="Statistics.aspx.cs" Inherits="Admin_Statistics" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <!-- OR for ThemeRoller styling
    <link rel="stylesheet" href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.10.3/themes/south-street/jquery-ui.css">
    <link rel="stylesheet" href="ui-southstreet.datepick.css">
    -->
    <link href="assets/Calenders/jquery.calendars.picker.css" rel="stylesheet" />
    <!-- OR for ThemeRoller styling
    <link rel="stylesheet" href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.10.3/themes/south-street/jquery-ui.css">
    <link rel="stylesheet" href="ui-southstreet.datepick.css">
    -->
    <script src="//ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js">
    </script>

    <script src="assets/Calenders/jquery.plugin.js"></script>
    <!--<script src="jquery.calendars.all.js"></script><!-- Use instead of calendars, plus, and picker below -->

    <script src="assets/Calenders/jquery.calendars.js"></script>
    <script src="assets/Calenders/jquery.calendars.plus.js"></script>
    <script src="assets/Calenders/jquery.calendars.picker.js"></script>
    <!--<script src="jquery.calendars.picker.ext.js"></script><!-- Include for ThemeRoller styling -->
    <script src="assets/Calenders/jquery.calendars.ummalqura.js"></script>
    <script src="assets/Calenders/jquery.calendars.ummalqura-ar.js"></script>
    <link href="assets/Calenders/jquery.calendars.picker.css" rel="stylesheet" />
    <script>
        $(function () {
            //	$.calendars.picker.setDefaults({renderer: $.calendars.picker.themeRollerRenderer}); // Requires jquery.calendars.picker.ext.js
            var calendar = $.calendars.instance('UmmAlQura', 'ar');

            $('#ContentPlaceHolder1_popupDatepicker').calendarsPicker({ calendar: calendar });
            $('#ContentPlaceHolder1_popupDatepickerEnd').calendarsPicker({ calendar: calendar });

            $('.calendars').width = $('#ContentPlaceHolder1_popupDatepicker').width;
        });

        //function showDateStart(date) {
        //    //document.getElementById("lblStart").innerHTML = date;
        //    document.getElementById('lblStart').innerText = date;
        //}
        //function showDateEnd(date) {
        //    //document.getElementById("lblStart").innerHTML = date;
        //    document.getElementById('lblEnd').innerText = date;
        //}
        //function btnSubmetClicked() {
        //    alert(document.getElementById('ContentPlaceHolder1_popupDatepicker').value);
        //    window.location.href(window.location.href + "&SDate=" + document.getElementById('lblstart').innerText + "&EDate=" + document.getElementById('lblEnd').innerText);
        //}
        function printdiv(printpage) {
            var headstr = "<html><head><title></title></head><body><div style=\"margin:0 auto;\"><h1 style=\"text-align:center;\"><img src=\"img/KFNLLOGO.png\"/></h1><br /><br /><br /><h1 style=\"text-align:center;\">إدارة الدراسات والخدمات المرجعية</h1>";
            var fromToDate = "";
            var datestart = document.getElementById("ContentPlaceHolder1_popupDatepicker").getAttribute("value");
            var dateEnd = document.getElementById("ContentPlaceHolder1_popupDatepickerEnd").getAttribute("value");
            if (datestart != null && dateEnd != null) {
                fromToDate = "<h4 id=\"h4date\" style=\"text-align:center;\"> احصائية من تاريخ " + datestart + " الى تاريخ " + dateEnd + "</h4></div>";
            } else if (datestart != null && dateEnd == null) {
                fromToDate = "<h4 id=\"h4date\" style=\"text-align:center;\"> احصائية من تاريخ " + datestart + "</h4></div>";

            } else if (datestart == null && dateEnd != null) {
                fromToDate = "<h4 id=\"h4date\" style=\"text-align:center;\"> الى تاريخ " + dateEnd + "</h4></div>";
            }
            else {
                fromToDate = "</div>";
            }
            var footstr = "</body>";
            var newstr = document.all.item(printpage).innerHTML;
            var oldstr = document.body.innerHTML;
            document.body.innerHTML = headstr + fromToDate + newstr + footstr;
            window.print();
            document.body.innerHTML = oldstr;
            return false;
        }
    </script>
    <style type="text/css">
        .ss option:hover {
            background-color: #0aa89e;
        }

        .ss option:active {
            background-color: #0aa89e;
        }

        /*.ss select : {
            background-color: #0aa89e;
        }*/

        .ss first-child select {
            -webkit-appearance: none;
            -moz-appearance: none;
            appearance: none;
        }

        .ss select::-ms-expand { /* for IE 11 */
            display: none;
        }
    </style>
    <style type="text/css">
        .rblStyle label {
            float: left;
            margin-right: 5px;
            margin-left: 15px;
        }

        .textTable th {
            text-align: center;
        }

        .textTable td {
            text-align: center;
        }

        .calendars-month-year {
            width: 49% !important;
        }

        .borderLeft {
            border-left: 1px solid #ddd !important;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <!-- BEGIN PAGE -->
    <div class="space7"></div>
    <div class="row-fluid">
        <div class="span12">
            <!-- BEGIN SAMPLE TABLE widget-->
            <div class="widget">
                <div class="widget-title">
                    <h4><i class="icon-cogs"></i>التقارير</h4>
                    <span class="tools">
                        <a class="icon-chevron-down" href="javascript:;"></a>
                        <a class="icon-remove" href="javascript:;"></a>
                    </span>
                </div>
                <div class="widget-body">
                    <div class="row-fluid">
                        <div class="span3">
                            <asp:TextBox type="text" ID="txtUserName" runat="server" CssClass="span10 " placeholder="اسم الموظف "></asp:TextBox>
                        </div>
                        <div class="span3">
                            <input type="text" class="span10 ss" id="popupDatepicker" runat="server" name="txtStart" placeholder="تاريخ الإدخال" />
                        </div>
                        <div class="span3">
                            <input type="text" class="span10 ss" value="" id="popupDatepickerEnd" runat="server" placeholder="تاريخ الانتهاء" />
                        </div>
                        <div class="span3">
                            <asp:DropDownList ID="ddlDepartment" runat="server" size="1" class="input">
                            </asp:DropDownList>
                        </div>
                        <div class="row-fluid">
                            <div class="span6 offset3">
                                <div class="span6">
                                    <asp:Button CssClass="span10 btn btn-primary " ID="btnSearch" runat="server" Text="بحث" OnClick="btnSearch_Click" />
                                </div>
                                <div class="span6">
                                    <asp:Button ID="printButton" runat="server" CssClass="span10 btn btn-primary" Text="طباعة" OnClientClick="printdiv('div_print');" />
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="space7"></div>
                    <div class="space7"></div>
                    <div class="space7"></div>
                    <div id="div_print">
                        <table class="table table-striped table-bordered table-advance table-hover textTable">
                            <thead>
                                <tr>
                                    <th class="borderLeft">&nbsp;</th>
                                    <th rowspan="2" class="borderLeft"><i class="fa fa-th-large"></i>&nbsp; مجموع البحوث</th>
                                    <th colspan="2" class="borderLeft"><i class="fa fa-language"></i>&nbsp;اللغة</th>
                                    <th colspan="2" class="borderLeft"><i class=" icon-calendar"></i>&nbsp; الفترة</th>
                                    <th colspan="5" class="borderLeft"><i class=" fa fa-cogs"></i>&nbsp; طريقة الأرسال</th>
                                    <th colspan="2" class="borderLeft"><i class=" fa fa-search"></i>&nbsp; مصارد المعلومات</th>
                                    <th colspan="4" class="borderLeft"><i class=" fa fa fa-graduation-cap"></i>&nbsp; التخصص العلمي</th>
                                        <th colspan="6" class="borderLeft"><i class=" fa fa fa-graduation-cap"></i>&nbsp;نوع الوعاء</th>
                                        <th colspan="1" class="borderLeft"><i class=" fa fa fa-graduation-cap"></i>&nbsp; عدد الأوعية</th>
                                      <th colspan="1" class="borderLeft"><i class=" fa fa fa-graduation-cap"></i>&nbsp; عدد الصفحات</th>
                                </tr>
                                <tr>
                                    <th class="borderLeft"><i></i>&nbsp; </th>
                                    <th><i class="fa fa-comment"></i>&nbsp; عربي</th>
                                    <th class="borderLeft"><i class="fa fa-comment-o"></i>&nbsp; انجليزي</th>
                                    <th><i class="fa fa-sun-o"></i>&nbsp; صباحي</th>
                                    <th class="borderLeft"><i class="fa fa-moon-o"></i>&nbsp; مسائي</th>
                                    <th><i class=" fa fa-hand-paper-o"></i>&nbsp; مناولة</th>
                                    <th><i class="fa fa-inbox"></i>&nbsp;بريد</th>
                                    <th><i class="fa fa-envelope-o"></i>&nbsp;بريد الكتروني</th>
                                    <th><i class="fa fa-fax"></i>&nbsp;خدمة ذاتية</th>
                                    <th class="borderLeft"><i class="fa fa-phone"></i>&nbsp;هاتف</th>
                                    <th><i class="fa fa-search"></i>&nbsp;الفهرس</th>
                                    <th class="borderLeft"><i class="fa fa-search"></i>&nbsp;قواعد المعلومات</th>
                                    <th class="borderLeft"><i class="fa fa-graduation-cap"></i>&nbsp;دكتوراه</th>
                                    <th class="borderLeft"><i class="fa fa-search"></i>&nbsp;ماجستير</th>
                                    <th class="borderLeft"><i class="fa fa-sticky-note-o"></i>&nbsp;جامعي</th>
                                     <th class="borderLeft"><i class="fa fa-plus"></i>&nbsp;اخرى</th>
                                    <th class="borderLeft"><i class="fa fa-book"></i>&nbsp;كتب</th>
                                    <th class="borderLeft"><i class="fa fa-file-text-o"></i>&nbsp;رسائل</th>
                                    <th class="borderLeft"><i class="fa fa-file-text-o"></i>&nbsp;مقالات</th>
                                    <th class="borderLeft"><i class="fa fa-file-text"></i>&nbsp;وثائق</th>
                                    <th class="borderLeft"><i class="fa fa-picture-o"></i>&nbsp;صور</th>
                                    <th class="borderLeft"><i class="fa fa-map-o"></i>&nbsp;مخطوطات</th>
                                    <th class="borderLeft"><i class="fa fa-file"></i>&nbsp;صفحات</th>
                                    <th class="borderLeft"><i class="fa fa-window-maximize"></i>&nbsp;اوعية</th>
                                  
                                </tr>

                            </thead>
                            <tbody>
                                <tr>
                                    <td class="borderLeft">
                                        <div class="success"></div>
                                        &nbsp; &nbsp;&nbsp;باحثون
                                    </td>
                                    <td class=" borderLeft">
                                        <asp:Label ID="lblTotal" runat="server" />
                                    </td>
                                    <td>
                                        <asp:Label ID="lblAr" runat="server" />
                                    </td>
                                    <td class="borderLeft">
                                        <asp:Label ID="lblEng" runat="server" />
                                    </td>
                                    <td>
                                        <asp:Label ID="lblAM" runat="server" />
                                    </td>
                                    <td class="borderLeft">
                                        <asp:Label ID="lblPM" runat="server" />
                                    </td>
                                    <td>
                                        <asp:Label ID="lblMonawla" runat="server" />
                                    </td>
                                    <td>
                                        <asp:Label ID="lblMail" runat="server" />
                                    </td>
                                    <td>
                                        <asp:Label ID="lblEmail" runat="server" />
                                    </td>
                                    <td>
                                        <asp:Label ID="lblFax" runat="server" />
                                    </td>
                                    <td class="borderLeft">
                                        <asp:Label ID="lblPhone" runat="server" />
                                    </td>
                                    <td>
                                        <asp:Label ID="lblIndex" runat="server" />
                                    </td>
                                    <td class="borderLeft">
                                        <asp:Label ID="lblInfoDB" runat="server" />
                                    </td>
                                    <td>
                                        <asp:Label ID="lblPhd" runat="server" />
                                    </td>
                                    <td>
                                        <asp:Label ID="lblmaster" runat="server" />
                                    </td>
                                    <td>
                                        <asp:Label ID="lblBac" runat="server" />
                                    </td>
                                    <td class="borderLeft">
                                        <asp:Label ID="lblOthor" runat="server" />
                                    </td>
                                      <td>
                                        <asp:Label ID="lblBooks" runat="server" />
                                    </td>
                                      <td>
                                        <asp:Label ID="lblArticle" runat="server" />
                                    </td>
                                      <td>
                                        <asp:Label ID="lblThesis" runat="server" />
                                    </td>
                                      <td>
                                        <asp:Label ID="lblDocuments" runat="server" />
                                    </td>
                                     <td>
                                        <asp:Label ID="lblImages" runat="server" />
                                    </td>
                                    <td class="borderLeft">
                                        <asp:Label ID="lblManuscripts" runat="server" />
                                    </td>
                                         <td class="borderLeft">
                                        <asp:Label ID="lblNumOfPages" runat="server" />
                                    </td>
                                      <td class="borderLeft">
                                        <asp:Label ID="lblNumOfItems" runat="server" />
                                    </td>

                                </tr>
                                <tr>
                                    <td class="borderLeft">
                                        <div class="success"></div>
                                        &nbsp; &nbsp;&nbsp; باحثات
                                    </td>
                                    <td class="borderLeft">
                                        <asp:Label ID="lblTotal2" runat="server" />
                                    </td>
                                    <td>
                                        <asp:Label ID="lblAr2" runat="server" />
                                    </td>
                                    <td class="borderLeft">
                                        <asp:Label ID="lblEng2" runat="server" />
                                    </td>
                                    <td>
                                        <asp:Label ID="lblAM2" runat="server" />
                                    </td>
                                    <td class="borderLeft">
                                        <asp:Label ID="lblPM2" runat="server" />
                                    </td>
                                    <td>
                                        <asp:Label ID="lblMonawla2" runat="server" />
                                    </td>
                                    <td>
                                        <asp:Label ID="lblMail2" runat="server" />
                                    </td>
                                    <td>
                                        <asp:Label ID="lblEmail2" runat="server" />
                                    </td>
                                    <td>
                                        <asp:Label ID="lblFax2" runat="server" />
                                    </td>
                                    <td class="borderLeft">
                                        <asp:Label ID="lblPhone2" runat="server" />
                                    </td>
                                    <td>
                                        <asp:Label ID="lblIndex2" runat="server" />
                                    </td>
                                    <td class="borderLeft">
                                        <asp:Label ID="lblInfoDB2" runat="server" />
                                    </td>
                                    <td>
                                        <asp:Label ID="lblPhd2" runat="server" />
                                    </td>
                                    <td>
                                        <asp:Label ID="lblmaster2" runat="server" />
                                    </td>
                                    <td>
                                        <asp:Label ID="lblBac2" runat="server" />
                                    </td>
                                    <td class="borderLeft">
                                        <asp:Label ID="lblOthor2" runat="server" />
                                    </td>
                                     <td>
                                        <asp:Label ID="lblBooks2" runat="server" />
                                    </td>
                                      <td>
                                        <asp:Label ID="lblArticle2" runat="server" />
                                    </td>
                                      <td>
                                        <asp:Label ID="lblThesis2" runat="server" />
                                    </td>
                                      <td>
                                        <asp:Label ID="lblDocuments2" runat="server" />
                                    </td>
                                     <td>
                                        <asp:Label ID="lblImages2" runat="server" />
                                    </td>
                                    <td class="borderLeft">
                                        <asp:Label ID="lblManuscripts2" runat="server" />
                                    </td>
                                         <td class="borderLeft">
                                        <asp:Label ID="lblNumOfPages2" runat="server" />
                                    </td>
                                      <td class="borderLeft">
                                        <asp:Label ID="lblNumOfItems2" runat="server" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <div class="success"></div>
                                        &nbsp; &nbsp; الإجمالي
                                    </td>
                                    <td class="borderLeft">
                                        <asp:Label ID="lblTotal3" runat="server" />
                                    </td>
                                    <td>
                                        <asp:Label ID="lblAr3" runat="server" />
                                    </td>
                                    <td class="borderLeft">
                                        <asp:Label ID="lblEng3" runat="server" />
                                    </td>
                                    <td>
                                        <asp:Label ID="lblAM3" runat="server" />
                                    </td>
                                    <td class="borderLeft">
                                        <asp:Label ID="lblPM3" runat="server" />
                                    </td>
                                    <td>
                                        <asp:Label ID="lblMonawla3" runat="server" />
                                    </td>
                                    <td>
                                        <asp:Label ID="lblMail3" runat="server" />
                                    </td>
                                    <td>
                                        <asp:Label ID="lblEmail3" runat="server" />
                                    </td>
                                    <td>
                                        <asp:Label ID="lblFax3" runat="server" />
                                    </td>

                                    <td class="borderLeft">
                                        <asp:Label ID="lblPhone3" runat="server" />
                                    </td>
                                    <td>
                                        <asp:Label ID="lblIndex3" runat="server" />
                                    </td>
                                    <td class="borderLeft">
                                        <asp:Label ID="lblInfoDB3" runat="server" />
                                    </td>
                                    <td>
                                        <asp:Label ID="lblPhd3" runat="server" />
                                    </td>
                                    <td>
                                        <asp:Label ID="lblmaster3" runat="server" />
                                    </td>
                                    <td>
                                        <asp:Label ID="lblBac3" runat="server" />
                                    </td>
                                    <td class="borderLeft">
                                        <asp:Label ID="lblOthor3" runat="server" />
                                    </td>
                                     <td>
                                        <asp:Label ID="lblBooks3" runat="server" />
                                    </td>
                                      <td>
                                        <asp:Label ID="lblArticle3" runat="server" />
                                    </td>
                                      <td>
                                        <asp:Label ID="lblThesis3" runat="server" />
                                    </td>
                                      <td>
                                        <asp:Label ID="lblDocuments3" runat="server" />
                                    </td>
                                     <td>
                                        <asp:Label ID="lblImages3" runat="server" />
                                    </td>
                                    <td class="borderLeft">
                                        <asp:Label ID="lblManuscripts3" runat="server" />
                                    </td>
                                     <td class="borderLeft">
                                        <asp:Label ID="lblNumOfPages3" runat="server" />
                                    </td>
                                      <td class="borderLeft">
                                        <asp:Label ID="lblNumOfItems3" runat="server" />
                                    </td>
                                    <%-- <td class="borderLeft" colspan="11">
                                        <asp:Label ID="lblTotal3" runat="server" />
                                    </td>--%>
                                </tr>

                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
            <!-- END SAMPLE TABLE widget-->
        </div>
        <img src="img/KFNLLOGO.png" style="visibility: hidden; display: none" />
</asp:Content>

