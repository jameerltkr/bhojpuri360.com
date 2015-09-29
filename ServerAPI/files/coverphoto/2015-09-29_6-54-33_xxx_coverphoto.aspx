<%@ Page Language="C#" Debug="true" ValidateRequest="false" MaintainScrollPositionOnPostback="True" %>

<%@ Register Assembly="obout_Grid_NET" Namespace="Obout.Grid" TagPrefix="cc1" %>
<%@ Register Assembly="obout_Interface" Namespace="Obout.Interface" TagPrefix="cc2" %>
<%@ Register Assembly="obout_Calendar2_Net" Namespace="OboutInc.Calendar2" TagPrefix="obout" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Configuration" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script type="text/javascript">
    function Grid1_BeforeEdit(sender, record) {
        var list1 = document.getElementById('Grid1_tplRowEdit_ctl00_lst_Operations');
        var list2 = document.getElementById('Grid1_tplRowEdit_ctl00_lst_Observation_Type');
        if (record.Plant_Code == "jko") {

            list1.getElementsByTagName('input')[1].nextSibling.style.display = 'none';
            list1.getElementsByTagName('input')[1].style.display = 'none';

            list2.getElementsByTagName('input')[0].nextSibling.style.display = 'none';
            list2.getElementsByTagName('input')[0].style.display = 'none';

            list2.getElementsByTagName('input')[2].nextSibling.style.display = 'none';
            list2.getElementsByTagName('input')[2].style.display = 'none';
        }
        else {
            list1.getElementsByTagName('input')[2].nextSibling.style.display = 'none';
            list1.getElementsByTagName('input')[2].style.display = 'none';

            list2.getElementsByTagName('input')[1].nextSibling.style.display = 'none';
            list2.getElementsByTagName('input')[1].style.display = 'none';

            list2.getElementsByTagName('input')[3].nextSibling.style.display = 'none';
            list2.getElementsByTagName('input')[3].style.display = 'none';
        }

        var Url = record.Image_URL;
        if ((Url != null) || (Url != "")) {
            var stindex = Url.indexOf('href="');
            if (stindex == -1) {
                stindex = Url.indexOf('href=');
                stindex += 8;
            }
            else {
                stindex += 6;
            }
            var endindex = Url.indexOf('">');
            if (endindex == -1) {
                endindex = Url.indexOf('.tif');
                endindex += 4;
            }
            Url = Url.substring(stindex, endindex);
            document.getElementById("Grid1_tplRowEdit_ctl00_CardImageFront").src = "TifHandler.ashx?imageURL=" + Url + "&pageNum=1" + "&rotation=0";
            document.getElementById("Grid1_tplRowEdit_ctl00_CardImageBack").src = "TifHandler.ashx?imageURL=" + Url + "&pageNum=2" + "&rotation=0";
        }
        var RadiobuttonArray = [];
        RadiobuttonArray = GetAllRadioButtons();
        var i = 0;
        var j = 0;
        var data;
        for (j = 0; j < RadiobuttonArray.length; j++) {
            var str = RadiobuttonArray[j]
            var index = str.indexOf('lst_')
            if (index != -1) {
                var radioname = RadiobuttonArray[j].substring(index + 4, RadiobuttonArray[j].length);
                data = eval('record.' + radioname);
                var val = document.getElementsByName(RadiobuttonArray[j]);
                GetValueFromHiddenField(data, val);
            }
        }

        //Check Boxes
        data = record.FollowUp_Needed_1;
        if (data == "Y") {
            checkCheckBox("chk_FollowUp_Needed_1");
        }
        else {
            unCheckCheckBox("chk_FollowUp_Needed_1");
        }

        data = record.FollowUp_Needed_2;
        if (data == "Y") {
            checkCheckBox("chk_FollowUp_Needed_2");
        }
        else {
            unCheckCheckBox("chk_FollowUp_Needed_2");
        }

        data = record.FollowUp_Needed_3;
        if (data == "Y") {
            checkCheckBox("chk_FollowUp_Needed_3");
        }
        else {
            unCheckCheckBox("chk_FollowUp_Needed_3");
        }

        return true;
    }

    function GetAllRadioButtons() {
        var inputs = document.forms["form1"].getElementsByTagName("input");
        var radioes = [];
        for (var i = 0; i < inputs.length; i++) {
            if (inputs[i].type == 'radio') {
                radioes.push(inputs[i].name);
            }
        }
        var arr = DistinctArray(radioes);
        return arr;
    }

    function DistinctArray(Array) {
        var arr = [];
        for (var i = 0; i < Array.length; i++) {
            if (arr.indexOf(Array[i]) == -1) {
                arr.push(Array[i]);
            }
        }
        return arr;
    }

    function OnBeforeUpdate(record) {

        var RadiobuttonArray = [];
        RadiobuttonArray = GetAllRadioButtons();
        var j = 0;
        for (j = 0; j < RadiobuttonArray.length; j++) {
            var str = RadiobuttonArray[j]
            var index = str.indexOf('lst_')
            if (index != -1) {
                var radioname = RadiobuttonArray[j].substring(index + 4, RadiobuttonArray[j].length);
                var hdnfieldid = "hdn_" + radioname;
                var val = document.getElementsByName(RadiobuttonArray[j]);
                GetValueFromRadiobuttonList(val, hdnfieldid);
            }
        }

        if (IsCheckboxCheck("chk_FollowUp_Needed_1")) {
            document.getElementById("hdn_FollowUp_Needed_1").value = "Y";
        }
        else {
            document.getElementById("hdn_FollowUp_Needed_1").value = "";
        }

        if (IsCheckboxCheck("chk_FollowUp_Needed_2")) {
            document.getElementById("hdn_FollowUp_Needed_2").value = "Y";            
        }
        else {
            document.getElementById("hdn_FollowUp_Needed_2").value = "";
        }

        if (IsCheckboxCheck("chk_FollowUp_Needed_3")) {
            document.getElementById("hdn_FollowUp_Needed_3").value = "Y";
        }
        else {
            document.getElementById("hdn_FollowUp_Needed_3").value = "";
        }
    }

    function GetValueFromHiddenField(data, val) {
        for (i = 0; i < val.length; i++) {
            if (val[i].value == data) {
                val[i].checked = true;
            } else { val[i].checked = false; }
        }
    }

    function GetValueFromRadiobuttonList(val, hdnid) {
        for (var i = 0; i < val.length; i++) {
            if (val[i].checked == true) {
                document.getElementById(hdnid).value = val[i].value;
                break;
            }
            else {
                document.getElementById(hdnid).value = "";
            }
        }
    }

    function checkCheckBox(checkBoxId) {
        var checkBox = eval(checkBoxId);
        checkBox.checked(true);
    }

    function unCheckCheckBox(checkBoxId) {
        var checkBox = eval(checkBoxId);
        checkBox.checked(false);
    }

    function IsCheckboxCheck(checkBoxId) {
        var checkBox = eval(checkBoxId);
        var isChecked = checkBox.checked();
        return isChecked;
    }

    function getSelected(Control) {
        var options = Control.getElementsByTagName('input');
        var leastOne = "";
        for (var i = 0; i < options.length; i++) {
            if (options[i].checked) {
                document.getElementById('hdnSelectedIndex').value = i;
                leastOne = i;
            }
        }
        if (leastOne == "") {
            document.getElementById('hdnSelectedIndex').value = leastOne;
        }
    }

    function unselectkRest(Control) {
        var options = Control.getElementsByTagName('input');
        var n = document.getElementById('hdnSelectedIndex');
        if (n.value.trim() != "") {
            options[n.value].checked = false;
        }
        n.value = '';
    }
</script>
<script runat="server">
    String backURL = string.Empty;

    void Page_Load(object sender, EventArgs e)
    {
        backURL = Request.QueryString["backURL"] != null ? Request.QueryString["backURL"] : string.Empty;
        
        //Set it so page doesn't cache
        System.Web.UI.HtmlControls.HtmlMeta META = new System.Web.UI.HtmlControls.HtmlMeta();
        META.HttpEquiv = "Pragma";
        META.Content = "no-cache";
        Page.Header.Controls.Add(META);
        Response.Expires = -1;
        Response.CacheControl = "no-cache";
    }

    public void UpdateRecord(object sender, GridRecordEventArgs e)
    {
        try
        {
            //string Sql = "UPDATE [dbo].[JWT_Lyondell_Safety_Obs] SET [Date] = @Date, [Shift] = @Shift, [Name_of_Company_on_Form] = @Name_of_Company_on_Form, [Operations] = @Operations, [Observation_Type] = @Observation_Type, [Safe_AtRisk_Card] = @Safe_AtRisk_Card, [A1] = @A1, [A2] = @A2, [A3] = @A3, [A4] = @A4, [B1] = @B1, [B2] = @B2, [B3] = @B3, [B4] = @B4, [B5] = @B5, [B6] = @B6, [C1] = @C1, [C2] = @C2, [C3] = @C3, [C4] = @C4, [C5] = @C5, [C6] = @C6, [C7] = @C7, [C8] = @C8, [D1] = @D1, [D2] = @D2, [D3] = @D3, [D4] = @D4, [D5] = @D5, [D6] = @D6, [D7] = @D7, [E1] = @E1, [E2] = @E2, [E3] = @E3, [E4] = @E4, [F1] = @F1, [F2] = @F2, [F3] = @F3, [F4] = @F4, [F5] = @F5, [G1] = @G1, [G2] = @G2, [G3] = @G3, [H1] = @H1, [H2] = @H2, [H3] = @H3, [H4] = @H4, [H5] = @H5, [H6] = @H6, [H7] = @H7, [H8] = @H8, [J1] = @J1, [Item_1] = @Item_1, [FollowUp_Needed_1] = @FollowUp_Needed_1, [Item_Text_1] = @Item_Text_1, [Item_2] = @Item_2, [FollowUp_Needed_2] = @FollowUp_Needed_2, [Item_Text_2] = @Item_Text_2, [Item_3] = @Item_3, [FollowUp_Needed_3] = @FollowUp_Needed_3, [Item_Text_3] = @Item_Text_3, [FollowUp_Needed_Merge] = @FollowUp_Needed_Merge, [Expected_Date_1] = @Expected_Date_1, [Assigned_Name_1] = @Assigned_Name_1, [AR_Date_Completed_1] = @AR_Date_Completed_1, [Admin_Comments_1] = @Admin_Comments_1, [Expected_Date_2] = @Expected_Date_2, [Assigned_Name_2] = @Assigned_Name_2, [AR_Date_Completed_2] = @AR_Date_Completed_2, [Admin_Comments_2] = @Admin_Comments_2, [Expected_Date_3] = @Expected_Date_3, [Assigned_Name_3] = @Assigned_Name_3, [AR_Date_Completed_3] = @AR_Date_Completed_3, [Admin_Comments_3] = @Admin_Comments_3,[Action_Item_Open]=CASE WHEN (@FollowUp_Needed_1 <> '' AND RTRIM(@AR_Date_Completed_1)<>'' AND @AR_Date_Completed_1 IS NOT NULL) OR (@FollowUp_Needed_2<>'' AND RTRIM(@AR_Date_Completed_2)<>'' AND @AR_Date_Completed_2 IS NOT NULL) OR (RTRIM(@AR_Date_Completed_3)<>'' AND @AR_Date_Completed_3 IS NOT NULL) THEN 'X' ELSE '' END,[FKLocationID]=@FKLocationID,[FKEmployeeID1]=@FKEmployeeID1,[FKEmployeeID2]=@FKEmployeeID2,[FKCompanyID1]=@FKCompanyID1,[FKCompanyID2]=@FKCompanyID2 WHERE [iCount] = @iCount";
            string Sql = "UPDATE [dbo].[JWT_Lyondell_Safety_Obs] SET [Date] = @Date, [Shift] = @Shift, [Name_of_Company_on_Form] = @Name_of_Company_on_Form, [Operations] = @Operations, [Observation_Type] = @Observation_Type, [Safe_AtRisk_Card] = @Safe_AtRisk_Card, [A1] = @A1, [A2] = @A2, [A3] = @A3, [A4] = @A4, [B1] = @B1, [B2] = @B2, [B3] = @B3, [B4] = @B4, [B5] = @B5, [B6] = @B6, [C1] = @C1, [C2] = @C2, [C3] = @C3, [C4] = @C4, [C5] = @C5, [C6] = @C6, [C7] = @C7, [C8] = @C8, [D1] = @D1, [D2] = @D2, [D3] = @D3, [D4] = @D4, [D5] = @D5, [D6] = @D6, [D7] = @D7, [E1] = @E1, [E2] = @E2, [E3] = @E3, [E4] = @E4, [F1] = @F1, [F2] = @F2, [F3] = @F3, [F4] = @F4, [F5] = @F5, [G1] = @G1, [G2] = @G2, [G3] = @G3, [H1] = @H1, [H2] = @H2, [H3] = @H3, [H4] = @H4, [H5] = @H5, [H6] = @H6, [H7] = @H7, [H8] = @H8, [J1] = @J1, [J2] = @J2, [K1] = @K1, [Item_1] = @Item_1, [FollowUp_Needed_1] = @FollowUp_Needed_1, [Item_Text_1] = @Item_Text_1, [Item_2] = @Item_2, [FollowUp_Needed_2] = @FollowUp_Needed_2, [Item_Text_2] = @Item_Text_2, [Item_3] = @Item_3, [FollowUp_Needed_3] = @FollowUp_Needed_3, [Item_Text_3] = @Item_Text_3, [FollowUp_Needed_Merge] = @FollowUp_Needed_Merge, [Expected_Date_1] = @Expected_Date_1, [Assigned_Name_1] = @Assigned_Name_1, [AR_Date_Completed_1] = @AR_Date_Completed_1, [Admin_Comments_1] = @Admin_Comments_1, [Expected_Date_2] = @Expected_Date_2, [Assigned_Name_2] = @Assigned_Name_2, [AR_Date_Completed_2] = @AR_Date_Completed_2, [Admin_Comments_2] = @Admin_Comments_2, [Expected_Date_3] = @Expected_Date_3, [Assigned_Name_3] = @Assigned_Name_3, [AR_Date_Completed_3] = @AR_Date_Completed_3, [Admin_Comments_3] = @Admin_Comments_3,[Action_Item_Status]=(CASE WHEN ((ISDATE(@Expected_Date_1)>0 OR @FollowUp_Needed_1='Y') AND ISDATE(@AR_Date_Completed_1)<1) OR ((ISDATE(@Expected_Date_2)>0 OR @FollowUp_Needed_2='Y') AND ISDATE(@AR_Date_Completed_2)<1) OR ((ISDATE(@Expected_Date_3)>0 OR @FollowUp_Needed_3='Y') AND ISDATE(@AR_Date_Completed_3)<1) THEN 'Open' ELSE CASE WHEN (ISDATE(@AR_Date_Completed_1)=1) OR (ISDATE(@AR_Date_Completed_2)=1) OR (ISDATE(@AR_Date_Completed_3)=1) THEN 'Closed' ELSE CASE WHEN RTRIM(@Item_Text_1)<>'' OR RTRIM(@Item_Text_2)<>'' OR RTRIM(@Item_Text_3)<>'' THEN 'Commented' ELSE '' END END END),[Name_Sup]=@Item_Merge,[FKLocationID]=@FKLocationID,[FKEmployeeID1]=@FKEmployeeID1,[FKEmployeeID2]=@FKEmployeeID2,[FKCompanyID1]=@FKCompanyID1,[FKCompanyID2]=@FKCompanyID2,[Item_Merge]=@Item_Merge WHERE [iCount] = @iCount";
            
            SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["pjengConnectionString1"].ConnectionString);
            SqlCommand comm = new SqlCommand(Sql, conn);
            comm.CommandType = CommandType.Text;
            conn.Open();
            comm.Parameters.AddWithValue("@Date", e.Record["Date"]);
            comm.Parameters.AddWithValue("@Shift", e.Record["Shift"]);
            comm.Parameters.AddWithValue("@Name_of_Company_on_Form", e.Record["Name_of_Company_on_Form"]);
            comm.Parameters.AddWithValue("@Operations", e.Record["Operations"]);
            comm.Parameters.AddWithValue("@Observation_Type", e.Record["Observation_Type"]);
            
            comm.Parameters.AddWithValue("@A1", e.Record["A1"]);
            comm.Parameters.AddWithValue("@A2", e.Record["A2"]);
            comm.Parameters.AddWithValue("@A3", e.Record["A3"]);
            comm.Parameters.AddWithValue("@A4", e.Record["A4"]);
            comm.Parameters.AddWithValue("@B1", e.Record["B1"]);
            comm.Parameters.AddWithValue("@B2", e.Record["B2"]);
            comm.Parameters.AddWithValue("@B3", e.Record["B3"]);
            comm.Parameters.AddWithValue("@B4", e.Record["B4"]);
            comm.Parameters.AddWithValue("@B5", e.Record["B5"]);
            comm.Parameters.AddWithValue("@B6", e.Record["B6"]);
            comm.Parameters.AddWithValue("@C1", e.Record["C1"]);
            comm.Parameters.AddWithValue("@C2", e.Record["C2"]);
            comm.Parameters.AddWithValue("@C3", e.Record["C3"]);
            comm.Parameters.AddWithValue("@C4", e.Record["C4"]);
            comm.Parameters.AddWithValue("@C5", e.Record["C5"]);
            comm.Parameters.AddWithValue("@C6", e.Record["C6"]);
            comm.Parameters.AddWithValue("@C7", e.Record["C7"]);
            comm.Parameters.AddWithValue("@C8", e.Record["C8"]);
            comm.Parameters.AddWithValue("@D1", e.Record["D1"]);
            comm.Parameters.AddWithValue("@D2", e.Record["D2"]);
            comm.Parameters.AddWithValue("@D3", e.Record["D3"]);
            comm.Parameters.AddWithValue("@D4", e.Record["D4"]);
            comm.Parameters.AddWithValue("@D5", e.Record["D5"]);
            comm.Parameters.AddWithValue("@D6", e.Record["D6"]);
            comm.Parameters.AddWithValue("@D7", e.Record["D7"]);
            comm.Parameters.AddWithValue("@E1", e.Record["E1"]);
            comm.Parameters.AddWithValue("@E2", e.Record["E2"]);
            comm.Parameters.AddWithValue("@E3", e.Record["E3"]);
            comm.Parameters.AddWithValue("@E4", e.Record["E4"]);
            comm.Parameters.AddWithValue("@F1", e.Record["F1"]);
            comm.Parameters.AddWithValue("@F2", e.Record["F2"]);
            comm.Parameters.AddWithValue("@F3", e.Record["F3"]);
            comm.Parameters.AddWithValue("@F4", e.Record["F4"]);
            comm.Parameters.AddWithValue("@F5", e.Record["F5"]);
            comm.Parameters.AddWithValue("@G1", e.Record["G1"]);
            comm.Parameters.AddWithValue("@G2", e.Record["G2"]);
            comm.Parameters.AddWithValue("@G3", e.Record["G3"]);
            comm.Parameters.AddWithValue("@H2", e.Record["H2"]);
            comm.Parameters.AddWithValue("@H1", e.Record["H1"]);
            comm.Parameters.AddWithValue("@H3", e.Record["H3"]);
            comm.Parameters.AddWithValue("@H4", e.Record["H4"]);
            comm.Parameters.AddWithValue("@H5", e.Record["H5"]);
            comm.Parameters.AddWithValue("@H6", e.Record["H6"]);
            comm.Parameters.AddWithValue("@H7", e.Record["H7"]);
            comm.Parameters.AddWithValue("@H8", e.Record["H8"]);
            comm.Parameters.AddWithValue("@J1", e.Record["J1"]);
            comm.Parameters.AddWithValue("@J2", e.Record["J2"]);
            comm.Parameters.AddWithValue("@K1", e.Record["K1"]);
            
            
            string sOrAr = "S";
            if (e.Record["A1"].ToString() == "AR" || e.Record["A2"].ToString() == "AR" || e.Record["A3"].ToString() == "AR" || e.Record["A4"].ToString() == "AR" || e.Record["B1"].ToString() == "AR" || e.Record["B2"].ToString() == "AR" || e.Record["B3"].ToString() == "AR" || e.Record["B4"].ToString() == "AR" || e.Record["B5"].ToString() == "AR" || e.Record["B6"].ToString() == "AR" || e.Record["C1"].ToString() == "AR" || e.Record["C2"].ToString() == "AR" || e.Record["C3"].ToString() == "AR" || e.Record["C4"].ToString() == "AR" || e.Record["C5"].ToString() == "AR" || e.Record["C6"].ToString() == "AR" || e.Record["C7"].ToString() == "AR" || e.Record["C8"].ToString() == "AR" || e.Record["D1"].ToString() == "AR" || e.Record["D2"].ToString() == "AR" || e.Record["D3"].ToString() == "AR" || e.Record["D4"].ToString() == "AR" || e.Record["D5"].ToString() == "AR" || e.Record["D6"].ToString() == "AR" || e.Record["D7"].ToString() == "AR" || e.Record["E1"].ToString() == "AR" || e.Record["E2"].ToString() == "AR" || e.Record["E3"].ToString() == "AR" || e.Record["E4"].ToString() == "AR" || e.Record["F1"].ToString() == "AR" || e.Record["F2"].ToString() == "AR" || e.Record["F3"].ToString() == "AR" || e.Record["F4"].ToString() == "AR" || e.Record["F5"].ToString() == "AR" || e.Record["G1"].ToString() == "AR" || e.Record["G2"].ToString() == "AR" || e.Record["G3"].ToString() == "AR" || e.Record["H2"].ToString() == "AR" || e.Record["H4"].ToString() == "AR" || e.Record["H5"].ToString() == "AR" || e.Record["H6"].ToString() == "AR" || e.Record["H7"].ToString() == "AR" || e.Record["H8"].ToString() == "AR" || e.Record["J1"].ToString() == "AR" || e.Record["J2"].ToString() == "AR" || e.Record["K1"].ToString() == "AR")
            {
                sOrAr = "AR";
            }

            comm.Parameters.AddWithValue("@Safe_AtRisk_Card", sOrAr);            
            comm.Parameters.AddWithValue("@Item_1", e.Record["Item_1"]);
            comm.Parameters.AddWithValue("@Item_2", e.Record["Item_2"]);
            comm.Parameters.AddWithValue("@Item_3", e.Record["Item_3"]);
            comm.Parameters.AddWithValue("@FollowUp_Needed_1", e.Record["FollowUp_Needed_1"]);
            comm.Parameters.AddWithValue("@FollowUp_Needed_2", e.Record["FollowUp_Needed_2"]);
            comm.Parameters.AddWithValue("@FollowUp_Needed_3", e.Record["FollowUp_Needed_3"]);

            if (!(e.Record["FollowUp_Needed_1"].ToString().Trim() == string.Empty && e.Record["FollowUp_Needed_2"].ToString().Trim() == string.Empty && e.Record["FollowUp_Needed_3"].ToString().Trim() == string.Empty))
            {
                comm.Parameters.AddWithValue("@FollowUp_Needed_Merge", e.Record["FollowUp_Needed_1"] + ", " + e.Record["FollowUp_Needed_2"] + ", " + e.Record["FollowUp_Needed_3"]);
            }
            else
            {
                comm.Parameters.AddWithValue("@FollowUp_Needed_Merge", string.Empty);
            }

            comm.Parameters.AddWithValue("@Item_Text_1", e.Record["Item_Text_1"]);
            comm.Parameters.AddWithValue("@Item_Text_2", e.Record["Item_Text_2"]);
            comm.Parameters.AddWithValue("@Item_Text_3", e.Record["Item_Text_3"]);

            if (e.Record["Expected_Date_1"].ToString().Trim() != string.Empty)
            {
                comm.Parameters.AddWithValue("@Expected_Date_1", e.Record["Expected_Date_1"]);
            }
            else
            {
                comm.Parameters.AddWithValue("@Expected_Date_1", System.DBNull.Value);
            }

            comm.Parameters.AddWithValue("@Assigned_Name_1", e.Record["Assigned_Name_1"]);

            if (e.Record["AR_Date_Completed_1"].ToString().Trim() != string.Empty)
            {
                comm.Parameters.AddWithValue("@AR_Date_Completed_1", e.Record["AR_Date_Completed_1"]);
            }
            else
            {
                comm.Parameters.AddWithValue("@AR_Date_Completed_1", System.DBNull.Value);
            }

            comm.Parameters.AddWithValue("@Admin_Comments_1", e.Record["Admin_Comments_1"]);
            
            if (e.Record["Expected_Date_2"].ToString().Trim() != string.Empty)
            {
                comm.Parameters.AddWithValue("@Expected_Date_2", e.Record["Expected_Date_2"]);
            }
            else
            {
                comm.Parameters.AddWithValue("@Expected_Date_2", System.DBNull.Value);
            }

            comm.Parameters.AddWithValue("@Assigned_Name_2", e.Record["Assigned_Name_2"]);

            if (e.Record["AR_Date_Completed_2"].ToString().Trim() != string.Empty)
            {
                comm.Parameters.AddWithValue("@AR_Date_Completed_2", e.Record["AR_Date_Completed_2"]);
            }
            else
            {
                comm.Parameters.AddWithValue("@AR_Date_Completed_2", System.DBNull.Value);
            }

            comm.Parameters.AddWithValue("@Admin_Comments_2", e.Record["Admin_Comments_2"]);
            
            if (e.Record["Expected_Date_3"].ToString().Trim() != string.Empty)
            {
                comm.Parameters.AddWithValue("@Expected_Date_3", e.Record["Expected_Date_3"]);
            }
            else
            {
                comm.Parameters.AddWithValue("@Expected_Date_3", System.DBNull.Value);
            }

            comm.Parameters.AddWithValue("@Assigned_Name_3", e.Record["Assigned_Name_3"]);

            if (e.Record["AR_Date_Completed_3"].ToString().Trim() != string.Empty)
            {
                comm.Parameters.AddWithValue("@AR_Date_Completed_3", e.Record["AR_Date_Completed_3"]);
            }
            else
            {
                comm.Parameters.AddWithValue("@AR_Date_Completed_3", System.DBNull.Value);
            }

            comm.Parameters.AddWithValue("@Admin_Comments_3", e.Record["Admin_Comments_3"]);

            string itemMerge = string.Empty;

            if (e.Record["Item_1"].ToString() != string.Empty)
            {
                itemMerge = e.Record["Item_1"].ToString();
            }

            if (itemMerge != string.Empty && e.Record["Item_2"].ToString() != string.Empty)
            {
                itemMerge = itemMerge + ", " + e.Record["Item_2"].ToString();
            }
            else if (itemMerge == string.Empty && e.Record["Item_2"].ToString() != string.Empty)
            {
                itemMerge = e.Record["Item_2"].ToString();
            }

            if (itemMerge != string.Empty && e.Record["Item_3"].ToString() != string.Empty)
            {
                itemMerge = itemMerge + ", " + e.Record["Item_3"].ToString().ToString();
            }
            else if (itemMerge == string.Empty && e.Record["Item_3"].ToString() != string.Empty)
            {
                itemMerge = e.Record["Item_3"].ToString();
            }

            comm.Parameters.AddWithValue("@Item_Merge", itemMerge);
                       
            comm.Parameters.AddWithValue("@iCount", SqlDbType.Int).Value = e.Record["iCount"];

            comm.Parameters.AddWithValue("@FKLocationID", SqlDbType.Int).Value = e.Record["FKLocationID"];
            comm.Parameters.AddWithValue("@FKEmployeeID1", SqlDbType.Int).Value = e.Record["FKEmployeeID1"];
            comm.Parameters.AddWithValue("@FKEmployeeID2", SqlDbType.Int).Value = e.Record["FKEmployeeID2"];
            comm.Parameters.AddWithValue("@FKCompanyID1", SqlDbType.Int).Value = e.Record["FKCompanyID1"];
            comm.Parameters.AddWithValue("@FKCompanyID2", SqlDbType.Int).Value = e.Record["FKCompanyID2"];

            comm.ExecuteNonQuery();
            conn.Close();
        }
        catch (Exception ex)
        {
            //Handle Your Error 
            string temp = ex.ToString();
        }
    }

    public string GetFullUrl(string imgURL)
    {
        if (imgURL.Contains("<a"))
        {
            var regex = new Regex("<a [^>]*href=(?:'(?<href>.*?)')|(?:\"(?<href>.*?)\")", RegexOptions.IgnoreCase);
            imgURL = regex.Matches(imgURL).OfType<Match>().Select(m => m.Groups["href"].Value).SingleOrDefault();
        }

        if (imgURL.ToLower().Contains("rptimages"))
        {
            imgURL = System.IO.Path.Combine("http://www.datainfoportal.com" + imgURL.Replace("\\", "/"));
        }
        else
        {
            imgURL = System.IO.Path.Combine("http://www.datainfoportal.com/RptImages" + imgURL.Replace("\\", "/"));
        }

        return imgURL;
    }
</script>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Lyondell Basell Audit Edit Panel</title>
    <link href="Styles/premiere_blue/style.css" rel="stylesheet" />
    <link href="Calendar/styles/expedia/style.css" rel="stylesheet" />
    <style type="text/css">
        html, body, form {
            height: 96%;
            font-family: arial, helvetica, sans-serif;
            font-size: 12px;
            padding: 0;
            margin: 5px;
            background-color: #CCCCCC;
        }

        .main {
            background-color: #EBECEC;
            min-height: 1680px;
        }

        .maindiv {
            background-color: #EBECEC;
            color: #666666;
            width: 100%;
            float: left;
        }

        .verticalLine {
            border-left: 1px solid black;
            float: left;
        }

        .leftdiv {
            float: left;
            width: 610px;
        }

        .margintop3pixel {
            margin-top: 3px;
        }

        .margintop4pixel {
            margin-top: 4px;
        }

        .margintop5pixel {
            margin-top: 5px;
        }

        .margintop6pixel {
            margin-top: 6px;
        }

        .margintop8pixel {
            margin-top: 8px;
        }

        .margintop10pixel {
            margin-top: 10px;
        }

        .floatLeft {
            float: left;
        }

        .clearBoth {
            clear: both;
        }

        .width80percent {
            width: 80%;
        }

        .width70percent {
            width: 70%;
        }

        .width50percent {
            width: 50%;
        }

        .width40percent {
            width: 40%;
        }

        .width20percent {
            width: 20%;
        }

        .width30percent {
            width: 30%;
        }

        .width32percent {
            width: 32%;
        }

        .width35percent {
            width: 35%;
        }

        .width100percent {
            width: 100%;
        }

        .width15percent {
            width: 13%;
        }

        .width10percent {
            width: 10%;
        }

        .width5percent {
            width: 5%;
        }

        .height50pixel {
            height: 30px;
        }

        .floatleft {
            float: left;
        }

        .fontbold {
            font-weight: bold;
        }

        .lefttextalign {
            text-align: left;
        }

        .righttextalign {
            text-align: right;
        }

        .centertextalign {
            text-align: center;
        }

        .fontsizelarge {
            font-size: medium;
        }

        .linespace {
            height: 40px;
            width: 100%;
        }

        .smalllinespace {
            height: 10px;
            width: 100%;
        }

        .radiobuttonlistcatch {
            display: block;
        }

        .padding2px {
            padding: 2px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div style="width: 100%; margin: 0 auto;">
            <h3 style="text-decoration: underline; text-align: center; color: white;">Lyondell Basell Audit Edit Panel</h3>
        </div>
        <div>
            <a href="<%=backURL%>" id="backurl"><u>CLICK HERE TO RETURN</u></a>
        </div>
        <cc1:Grid ID="Grid1" runat="server" Serialize="false" EnableRecordHover="true" EmbedFilterInSortExpression="True"
            AllowAddingRecords="false" AllowColumnResizing="false" AllowGrouping="True" AllowPaging="true"
            AllowSorting="true" Height="100%" Width="100%" PageSize="50" AllowFiltering="True"
            AllowRecordSelection="true" ShowGroupFooter="True" ShowGroupsInfo="True" AllowColumnReordering="True"
            ShowTotalNumberOfPages="True" AutoGenerateColumns="false" FolderStyle="Styles/style_13"
            DataSourceID="SqlDataSource1" OnUpdateCommand="UpdateRecord">
            <ClientSideEvents OnClientEdit="Grid1_BeforeEdit" OnBeforeClientUpdate="OnBeforeUpdate"
                ExposeSender="true" />
            <ScrollingSettings ScrollWidth="100%" ScrollHeight="100%" ScrollLeft="0" ScrollTop="0" />
            <Columns>
                <cc1:Column ID="Column18" HeaderText="EDIT" Width="115" AllowEdit="true" AllowDelete="false"
                    runat="server" />
                <cc1:Column ID="Column1" DataField="iCount" HeaderText="iCount" runat="server">
                    <TemplateSettings RowEditTemplateControlId="lbliCount" RowEditTemplateControlPropertyName="innerHTML" />
                </cc1:Column>
		<cc1:Column ID="Column58" DataField="Date" HeaderText="Date" runat="server" DataFormatString="{0:MM/dd/yyyy}"
                    ApplyFormatInEditMode="true">
                    <TemplateSettings RowEditTemplateControlId="txtDate" RowEditTemplateControlPropertyName="value" />
                </cc1:Column>
                <cc1:Column ID="Column70" DataField="Action_Item_Status" HeaderText="Action Item Status" runat="server" >
                </cc1:Column> 
                <cc1:Column ID="Column177" DataField="Item_Merge" HeaderText="Item_Merge" runat="server" >                          
                </cc1:Column>               
                <cc1:Column ID="Column82" DataField="Expected_Date_1" HeaderText="AR AExpected Date 1" runat="server" DataFormatString="{0:MM/dd/yyyy}"
                    ApplyFormatInEditMode="true">
                    <TemplateSettings RowEditTemplateControlId="txt_Expected_Date_1" RowEditTemplateControlPropertyName="value" />
                </cc1:Column>
                <cc1:Column ID="Column83" DataField="Assigned_Name_1" HeaderText="AR Assigned Name 1" runat="server">
                    <TemplateSettings RowEditTemplateControlId="txt_Assigned_Name_1" RowEditTemplateControlPropertyName="value" />
                </cc1:Column>
                <cc1:Column ID="Column84" DataField="AR_Date_Completed_1" HeaderText="AR Date Completed 1" runat="server" DataFormatString="{0:MM/dd/yyyy}"
                    ApplyFormatInEditMode="true">
                    <TemplateSettings RowEditTemplateControlId="txt_AR_Date_Completed_1" RowEditTemplateControlPropertyName="value" />
                </cc1:Column>
                <cc1:Column ID="Column85" DataField="Admin_Comments_1" HeaderText="AR Admin Comments 1" runat="server">
                    <TemplateSettings RowEditTemplateControlId="txt_Admin_Comments_1" RowEditTemplateControlPropertyName="value" />
                </cc1:Column>
                <cc1:Column ID="Column21" DataField="Expected_Date_2" HeaderText="AR AExpected Date 2" runat="server" DataFormatString="{0:MM/dd/yyyy}"
                    ApplyFormatInEditMode="true">
                    <TemplateSettings RowEditTemplateControlId="txt_Expected_Date_2" RowEditTemplateControlPropertyName="value" />
                </cc1:Column>
                <cc1:Column ID="Column81" DataField="Assigned_Name_2" HeaderText="AR Assigned Name 2" runat="server">
                    <TemplateSettings RowEditTemplateControlId="txt_Assigned_Name_2" RowEditTemplateControlPropertyName="value" />
                </cc1:Column>
                <cc1:Column ID="Column86" DataField="AR_Date_Completed_2" HeaderText="AR Date Completed 2" runat="server" DataFormatString="{0:MM/dd/yyyy}"
                    ApplyFormatInEditMode="true">
                    <TemplateSettings RowEditTemplateControlId="txt_AR_Date_Completed_2" RowEditTemplateControlPropertyName="value" />
                </cc1:Column>
                <cc1:Column ID="Column87" DataField="Admin_Comments_2" HeaderText="AR Admin Comments 2" runat="server">
                    <TemplateSettings RowEditTemplateControlId="txt_Admin_Comments_2" RowEditTemplateControlPropertyName="value" />
                </cc1:Column>
                <cc1:Column ID="Column88" DataField="Expected_Date_3" HeaderText="AR AExpected Date 3" runat="server" DataFormatString="{0:MM/dd/yyyy}"
                    ApplyFormatInEditMode="true">
                    <TemplateSettings RowEditTemplateControlId="txt_Expected_Date_3" RowEditTemplateControlPropertyName="value" />
                </cc1:Column>
                <cc1:Column ID="Column89" DataField="Assigned_Name_3" HeaderText="AR Assigned Name 3" runat="server">
                    <TemplateSettings RowEditTemplateControlId="txt_Assigned_Name_3" RowEditTemplateControlPropertyName="value" />
                </cc1:Column>
                <cc1:Column ID="Column90" DataField="AR_Date_Completed_3" HeaderText="AR Date Completed 3" runat="server" DataFormatString="{0:MM/dd/yyyy}"
                    ApplyFormatInEditMode="true">
                    <TemplateSettings RowEditTemplateControlId="txt_AR_Date_Completed_3" RowEditTemplateControlPropertyName="value" />
                </cc1:Column>
                <cc1:Column ID="Column91" DataField="Admin_Comments_3" HeaderText="AR Admin Comments 3" runat="server">
                    <TemplateSettings RowEditTemplateControlId="txt_Admin_Comments_3" RowEditTemplateControlPropertyName="value" />
                </cc1:Column>                
                <cc1:Column ID="Column47" DataField="ImageFiles" HeaderText="Image File" runat="server"
                    ReadOnly="true">
                    <TemplateSettings RowEditTemplateControlId="lblImageFiles" RowEditTemplateControlPropertyName="innerHTML" />
                </cc1:Column>
                <cc1:Column ID="Column6" DataField="Shift" HeaderText="Shift" runat="server">
                    <TemplateSettings RowEditTemplateControlId="hdn_Shift" RowEditTemplateControlPropertyName="value" />
                </cc1:Column>
                <cc1:Column ID="Column7" DataField="Plant_Code" HeaderText="Plant Code" ReadOnly="true"
                    runat="server">
                </cc1:Column>
                <cc1:Column ID="Column158" DataField="Plant_Description" HeaderText="Plant Description"
                    ReadOnly="true" runat="server">
                </cc1:Column>
                <cc1:Column ID="Column165" DataField="Location_Code" HeaderText="Location Code" ReadOnly="true"
                    runat="server">
                </cc1:Column>
                <cc1:Column ID="Column144" DataField="Location_Description" HeaderText="Location Description"
                    runat="server">
                    <%--<TemplateSettings RowEditTemplateControlId="txt_Location_Description" RowEditTemplateControlPropertyName="value" />--%>
                </cc1:Column>
                <cc1:Column ID="Column156" DataField="Area_Description" HeaderText="Area Description"
                    ReadOnly=" true" runat="server">
                </cc1:Column>
                <cc1:Column ID="Column157" DataField="Group_Description" HeaderText="Group_Description"
                    runat="server">
                </cc1:Column>
                <cc1:Column ID="Column166" DataField="Plant_Division" HeaderText="Plant Division"
                    runat="server">
                </cc1:Column>
                <cc1:Column ID="Column167" DataField="Observer_Name" HeaderText="Observer Name"
                    runat="server">
                </cc1:Column>
                <cc1:Column ID="Column161" DataField="Observer_Code" HeaderText="Observer Code" runat="server">
                </cc1:Column>
                <cc1:Column ID="Column162" DataField="Observer_Department_Code" HeaderText="Observer Department Code"
                    runat="server">
                </cc1:Column>
                <cc1:Column ID="Column163" DataField="Observer_Job_Note" HeaderText="Observer Job Note"
                    runat="server">
                </cc1:Column>
                <cc1:Column ID="Column164" DataField="Coach_Name" HeaderText="Coach Name" ReadOnly="true"
                    runat="server">
                </cc1:Column>
                <cc1:Column ID="Column9" DataField="Coach_Code" HeaderText="Coach Code" runat="server">
                </cc1:Column>
                <cc1:Column ID="Column4" DataField="Coach_Department_Code" HeaderText="Coach Department Code"
                    runat="server">
                </cc1:Column>
                <cc1:Column ID="Column5" DataField="Coach_Job_Note" HeaderText="Coach Job Note"
                    runat="server">
                </cc1:Column>
                <cc1:Column ID="Column8" DataField="Observers_Company_Code" HeaderText="Observers Company Code"
                    runat="server">
                </cc1:Column>
                <cc1:Column ID="Column10" DataField="Observers_Company_Name" HeaderText="Observers Company Name"
                    runat="server">
                </cc1:Column>
                <cc1:Column ID="Column11" DataField="Observered_Company_Code" HeaderText="Observered Company Code"
                    runat="server">
                </cc1:Column>
                <cc1:Column ID="Column12" DataField="Observered_Company_Name" HeaderText="Observered Company Name"
                    runat="server">
                </cc1:Column>
                <cc1:Column ID="Column13" DataField="Name_of_Company_on_Form" HeaderText="Company Name On Form"
                    runat="server">
                    <TemplateSettings RowEditTemplateControlId="txt_Name_of_Company_on_Form" RowEditTemplateControlPropertyName="value" />
                </cc1:Column>
                <cc1:Column ID="Column16" DataField="Operations" HeaderText="Operations" runat="server">
                    <TemplateSettings RowEditTemplateControlId="hdn_Operations" RowEditTemplateControlPropertyName="value" />
                </cc1:Column>
                <cc1:Column ID="Column17" DataField="Observation_Type" HeaderText="Observation Type"
                    runat="server">
                    <TemplateSettings RowEditTemplateControlId="hdn_Observation_Type" RowEditTemplateControlPropertyName="value" />
                </cc1:Column>
                <cc1:Column ID="Column19" DataField="Safe_AtRisk_Card" HeaderText="Safe_AtRisk_Card"
                    runat="server">
                    <TemplateSettings RowEditTemplateControlId="hdn_Safe_AtRisk_Card" RowEditTemplateControlPropertyName="value" />
                </cc1:Column>
                <cc1:Column ID="Column20" DataField="A1" HeaderText="A1" runat="server">
                    <TemplateSettings RowEditTemplateControlId="hdn_A1" RowEditTemplateControlPropertyName="value" />
                </cc1:Column>
                <cc1:Column ID="Column2" DataField="A2" HeaderText="A2" runat="server">
                    <TemplateSettings RowEditTemplateControlId="hdn_A2" RowEditTemplateControlPropertyName="value" />
                </cc1:Column>
                <cc1:Column ID="Column3" DataField="A3" HeaderText="A3" runat="server">
                    <TemplateSettings RowEditTemplateControlId="hdn_A3" RowEditTemplateControlPropertyName="value" />
                </cc1:Column>
                <cc1:Column ID="Column14" DataField="A4" HeaderText="A4" runat="server">
                    <TemplateSettings RowEditTemplateControlId="hdn_A4" RowEditTemplateControlPropertyName="value" />
                </cc1:Column>
                <cc1:Column ID="Column15" DataField="B1" HeaderText="B1" runat="server">
                    <TemplateSettings RowEditTemplateControlId="hdn_B1" RowEditTemplateControlPropertyName="value" />
                </cc1:Column>
                <cc1:Column ID="Column23" DataField="B2" HeaderText="B2" runat="server">
                    <TemplateSettings RowEditTemplateControlId="hdn_B2" RowEditTemplateControlPropertyName="value" />
                </cc1:Column>
                <cc1:Column ID="Column24" DataField="B3" HeaderText="B3" runat="server">
                    <TemplateSettings RowEditTemplateControlId="hdn_B3" RowEditTemplateControlPropertyName="value" />
                </cc1:Column>
                <cc1:Column ID="Column25" DataField="B4" HeaderText="B4" runat="server">
                    <TemplateSettings RowEditTemplateControlId="hdn_B4" RowEditTemplateControlPropertyName="value" />
                </cc1:Column>
                <cc1:Column ID="Column26" DataField="B5" HeaderText="B5" runat="server">
                    <TemplateSettings RowEditTemplateControlId="hdn_B5" RowEditTemplateControlPropertyName="value" />
                </cc1:Column>
                <cc1:Column ID="Column27" DataField="B6" HeaderText="B6" runat="server">
                    <TemplateSettings RowEditTemplateControlId="hdn_B6" RowEditTemplateControlPropertyName="value" />
                </cc1:Column>
                <cc1:Column ID="Column28" DataField="C1" HeaderText="C1" runat="server">
                    <TemplateSettings RowEditTemplateControlId="hdn_C1" RowEditTemplateControlPropertyName="value" />
                </cc1:Column>
                <cc1:Column ID="Column29" DataField="C2" HeaderText="C2" runat="server">
                    <TemplateSettings RowEditTemplateControlId="hdn_C2" RowEditTemplateControlPropertyName="value" />
                </cc1:Column>
                <cc1:Column ID="Column30" DataField="C3" HeaderText="C3" runat="server">
                    <TemplateSettings RowEditTemplateControlId="hdn_C3" RowEditTemplateControlPropertyName="value" />
                </cc1:Column>
                <cc1:Column ID="Column31" DataField="C4" HeaderText="C4" runat="server">
                    <TemplateSettings RowEditTemplateControlId="hdn_C4" RowEditTemplateControlPropertyName="value" />
                </cc1:Column>
                <cc1:Column ID="Column32" DataField="C5" HeaderText="C5" runat="server">
                    <TemplateSettings RowEditTemplateControlId="hdn_C5" RowEditTemplateControlPropertyName="value" />
                </cc1:Column>
                <cc1:Column ID="Column33" DataField="C6" HeaderText="C6" runat="server">
                    <TemplateSettings RowEditTemplateControlId="hdn_C6" RowEditTemplateControlPropertyName="value" />
                </cc1:Column>
                <cc1:Column ID="Column34" DataField="C7" HeaderText="C7" runat="server">
                    <TemplateSettings RowEditTemplateControlId="hdn_C7" RowEditTemplateControlPropertyName="value" />
                </cc1:Column>
                <cc1:Column ID="Column35" DataField="C8" HeaderText="C8" runat="server">
                    <TemplateSettings RowEditTemplateControlId="hdn_C8" RowEditTemplateControlPropertyName="value" />
                </cc1:Column>
                <cc1:Column ID="Column36" DataField="D1" HeaderText="D1" runat="server">
                    <TemplateSettings RowEditTemplateControlId="hdn_D1" RowEditTemplateControlPropertyName="value" />
                </cc1:Column>
                <cc1:Column ID="Column37" DataField="D2" HeaderText="D2" runat="server">
                    <TemplateSettings RowEditTemplateControlId="hdn_D2" RowEditTemplateControlPropertyName="value" />
                </cc1:Column>
                <cc1:Column ID="Column38" DataField="D3" HeaderText="D3" runat="server">
                    <TemplateSettings RowEditTemplateControlId="hdn_D3" RowEditTemplateControlPropertyName="value" />
                </cc1:Column>
                <cc1:Column ID="Column39" DataField="D4" HeaderText="D4" runat="server">
                    <TemplateSettings RowEditTemplateControlId="hdn_D4" RowEditTemplateControlPropertyName="value" />
                </cc1:Column>
                <cc1:Column ID="Column40" DataField="D5" HeaderText="D5" runat="server">
                    <TemplateSettings RowEditTemplateControlId="hdn_D5" RowEditTemplateControlPropertyName="value" />
                </cc1:Column>
                <cc1:Column ID="Column41" DataField="D6" HeaderText="D6" runat="server">
                    <TemplateSettings RowEditTemplateControlId="hdn_D6" RowEditTemplateControlPropertyName="value" />
                </cc1:Column>
                <cc1:Column ID="Column42" DataField="D7" HeaderText="D7" runat="server">
                    <TemplateSettings RowEditTemplateControlId="hdn_D7" RowEditTemplateControlPropertyName="value" />
                </cc1:Column>
                <cc1:Column ID="Column43" DataField="E1" HeaderText="E1" runat="server">
                    <TemplateSettings RowEditTemplateControlId="hdn_E1" RowEditTemplateControlPropertyName="value" />
                </cc1:Column>
                <cc1:Column ID="Column44" DataField="E2" HeaderText="E2" runat="server">
                    <TemplateSettings RowEditTemplateControlId="hdn_E2" RowEditTemplateControlPropertyName="value" />
                </cc1:Column>
                <cc1:Column ID="Column45" DataField="E3" HeaderText="E3" runat="server">
                    <TemplateSettings RowEditTemplateControlId="hdn_E3" RowEditTemplateControlPropertyName="value" />
                </cc1:Column>
                <cc1:Column ID="Column46" DataField="E4" HeaderText="E4" runat="server">
                    <TemplateSettings RowEditTemplateControlId="hdn_E4" RowEditTemplateControlPropertyName="value" />
                </cc1:Column>
                <cc1:Column ID="Column48" DataField="F1" HeaderText="F1" runat="server">
                    <TemplateSettings RowEditTemplateControlId="hdn_F1" RowEditTemplateControlPropertyName="value" />
                </cc1:Column>
                <cc1:Column ID="Column49" DataField="F2" HeaderText="F2" runat="server">
                    <TemplateSettings RowEditTemplateControlId="hdn_F2" RowEditTemplateControlPropertyName="value" />
                </cc1:Column>
                <cc1:Column ID="Column50" DataField="F3" HeaderText="F3" runat="server">
                    <TemplateSettings RowEditTemplateControlId="hdn_F3" RowEditTemplateControlPropertyName="value" />
                </cc1:Column>
                <cc1:Column ID="Column51" DataField="F4" HeaderText="F4" runat="server">
                    <TemplateSettings RowEditTemplateControlId="hdn_F4" RowEditTemplateControlPropertyName="value" />
                </cc1:Column>
                <cc1:Column ID="Column54" DataField="F5" HeaderText="F5" runat="server">
                    <TemplateSettings RowEditTemplateControlId="hdn_F5" RowEditTemplateControlPropertyName="value" />
                </cc1:Column>
                <cc1:Column ID="Column55" DataField="G1" HeaderText="G1" runat="server">
                    <TemplateSettings RowEditTemplateControlId="hdn_G1" RowEditTemplateControlPropertyName="value" />
                </cc1:Column>
                <cc1:Column ID="Column56" DataField="G2" HeaderText="G2" runat="server">
                    <TemplateSettings RowEditTemplateControlId="hdn_G2" RowEditTemplateControlPropertyName="value" />
                </cc1:Column>
                <cc1:Column ID="Column57" DataField="G3" HeaderText="G3" runat="server">
                    <TemplateSettings RowEditTemplateControlId="hdn_G3" RowEditTemplateControlPropertyName="value" />
                </cc1:Column>
                <cc1:Column ID="Column59" DataField="H1" HeaderText="H1" runat="server">
                    <TemplateSettings RowEditTemplateControlId="hdn_H1" RowEditTemplateControlPropertyName="value" />
                </cc1:Column>
                <cc1:Column ID="Column60" DataField="H2" HeaderText="H2" runat="server">
                    <TemplateSettings RowEditTemplateControlId="hdn_H2" RowEditTemplateControlPropertyName="value" />
                </cc1:Column>
                <cc1:Column ID="Column61" DataField="H3" HeaderText="H3" runat="server">
                    <TemplateSettings RowEditTemplateControlId="hdn_H3" RowEditTemplateControlPropertyName="value" />
                </cc1:Column>
                <cc1:Column ID="Column62" DataField="H4" HeaderText="H4" runat="server">
                    <TemplateSettings RowEditTemplateControlId="hdn_H4" RowEditTemplateControlPropertyName="value" />
                </cc1:Column>
                <cc1:Column ID="Column63" DataField="H5" HeaderText="H5" runat="server">
                    <TemplateSettings RowEditTemplateControlId="hdn_H5" RowEditTemplateControlPropertyName="value" />
                </cc1:Column>
                <cc1:Column ID="Column64" DataField="H6" HeaderText="H6" runat="server">
                    <TemplateSettings RowEditTemplateControlId="hdn_H6" RowEditTemplateControlPropertyName="value" />
                </cc1:Column>
                <cc1:Column ID="Column65" DataField="H7" HeaderText="H7" runat="server">
                    <TemplateSettings RowEditTemplateControlId="hdn_H7" RowEditTemplateControlPropertyName="value" />
                </cc1:Column>
                <cc1:Column ID="Column66" DataField="H8" HeaderText="H8" runat="server">
                    <TemplateSettings RowEditTemplateControlId="hdn_H8" RowEditTemplateControlPropertyName="value" />
                </cc1:Column>
                <cc1:Column ID="Column67" DataField="J1" HeaderText="J1" runat="server">
                    <TemplateSettings RowEditTemplateControlId="hdn_J1" RowEditTemplateControlPropertyName="value" />
                </cc1:Column>                
                <cc1:Column ID="Column78" DataField="J2" HeaderText="J2" runat="server">
                    <TemplateSettings RowEditTemplateControlId="hdn_J2" RowEditTemplateControlPropertyName="value" />
                </cc1:Column>
                <cc1:Column ID="Column92" DataField="K1" HeaderText="K1" runat="server">
                    <TemplateSettings RowEditTemplateControlId="hdn_K1" RowEditTemplateControlPropertyName="value" />
                </cc1:Column>
                <cc1:Column ID="Column22" DataField="Item_Text_1" HeaderText="Item_Text_1" runat="server">
                    <TemplateSettings RowEditTemplateControlId="txt_Item_Text_1" RowEditTemplateControlPropertyName="value" />
                </cc1:Column>
                <cc1:Column ID="Column175" DataField="Item_Text_2" HeaderText="Item_Text_2" runat="server">
                    <TemplateSettings RowEditTemplateControlId="txt_Item_Text_2" RowEditTemplateControlPropertyName="value" />
                </cc1:Column>
                <cc1:Column ID="Column176" DataField="Item_Text_3" HeaderText="Item_Text_3" runat="server">
                    <TemplateSettings RowEditTemplateControlId="txt_Item_Text_3" RowEditTemplateControlPropertyName="value" />
                </cc1:Column>
               
                <%--<cc1:Column ID="Column80" DataField="Action_Required" HeaderText="Action Required" runat="server"
                    ReadOnly="true">
                          <TemplateSettings RowEditTemplateControlId="txt_Action_Required" RowEditTemplateControlPropertyName="value" />                    
                </cc1:Column>--%>
                <%-- <cc1:Column ID="Column81" DataField="AR_Comment_Text" HeaderText="AR Comment Text" runat="server"
                    ReadOnly="true">
                          <TemplateSettings RowEditTemplateControlId="txt_AR_Comment_Text" RowEditTemplateControlPropertyName="value" />                    
                </cc1:Column>--%>
                <%--  <cc1:Column ID="Column190" DataField="FollowUp_Needed_Merge" HeaderText="FollowUp_Needed_Merge"
                    ReadOnly="true" runat="server">
                         <TemplateSettings RowEditTemplateControlId="txt_FollowUp_Needed_Merge" RowEditTemplateControlPropertyName="value" />                    
                </cc1:Column>--%>
                <cc1:Column ID="Column80" DataField="FollowUp_Needed_1" HeaderText="FollowUp_Needed_1"
                    runat="server">
                    <TemplateSettings RowEditTemplateControlId="hdn_FollowUp_Needed_1" RowEditTemplateControlPropertyName="value" />
                </cc1:Column>
                <cc1:Column ID="Column191" DataField="FollowUp_Needed_2" HeaderText="FollowUp_Needed_2"
                    runat="server">
                    <TemplateSettings RowEditTemplateControlId="hdn_FollowUp_Needed_2" RowEditTemplateControlPropertyName="value" />
                </cc1:Column>
                <cc1:Column ID="Column192" DataField="FollowUp_Needed_3" HeaderText="FollowUp_Needed_3"
                    runat="server">
                    <TemplateSettings RowEditTemplateControlId="hdn_FollowUp_Needed_3" RowEditTemplateControlPropertyName="value" />
                </cc1:Column>
                <cc1:Column ID="Column193" DataField="Item_1" HeaderText="Item_1" runat="server">
                    <TemplateSettings RowEditTemplateControlId="txt_Item_1" RowEditTemplateControlPropertyName="value" />
                </cc1:Column>
                <cc1:Column ID="Column52" DataField="Item_2" HeaderText="Item_2" runat="server">
                    <TemplateSettings RowEditTemplateControlId="txt_Item_2" RowEditTemplateControlPropertyName="value" />
                </cc1:Column>
                <cc1:Column ID="Column53" DataField="Item_3" HeaderText="Item_3" runat="server">
                    <TemplateSettings RowEditTemplateControlId="txt_Item_3" RowEditTemplateControlPropertyName="value" />
                </cc1:Column>
                <cc1:Column ID="Column68" DataField="Scan_Date" HeaderText="Scan_Date" runat="server"
                    ReadOnly="true">
                </cc1:Column>
                <cc1:Column ID="Column72" DataField="Image_Files" HeaderText="Image_Files" ReadOnly="true"
                    runat="server" Width="300">
                    <TemplateSettings RowEditTemplateControlId="lblImageFiles" RowEditTemplateControlPropertyName="innerHTML" />
                </cc1:Column>
                <cc1:Column ID="Column73" DataField="DateINT" HeaderText="DateINT" ReadOnly="true"
                    runat="server">
                </cc1:Column>
                <cc1:Column ID="Column74" DataField="EditedBy" HeaderText="EditedBy" ReadOnly="true"
                    runat="server">
                </cc1:Column>
                <cc1:Column ID="Column75" DataField="FKLocationID" Visible="false"
                    runat="server">
                    <TemplateSettings RowEditTemplateControlId="ddlLocation" RowEditTemplateControlPropertyName="value" />
                </cc1:Column>
                <cc1:Column ID="Column76" DataField="FKEmployeeID1" Visible="false"
                    runat="server">
                    <TemplateSettings RowEditTemplateControlId="ddlEmployee1" RowEditTemplateControlPropertyName="value" />
                </cc1:Column>
                <cc1:Column ID="Column77" DataField="FKEmployeeID2" Visible="false"
                    runat="server">
                    <TemplateSettings RowEditTemplateControlId="ddlEmployee2" RowEditTemplateControlPropertyName="value" />
                </cc1:Column>
                <cc1:Column ID="Column79" DataField="FKCompanyID1" Visible="false"
                    runat="server">
                    <TemplateSettings RowEditTemplateControlId="ddlCompany1" RowEditTemplateControlPropertyName="value" />
                </cc1:Column>
                <cc1:Column ID="Column71" DataField="FKCompanyID2" Visible="false"
                    runat="server">
                    <TemplateSettings RowEditTemplateControlId="ddlCompany2" RowEditTemplateControlPropertyName="value" />
                </cc1:Column>
                <cc1:Column ID="Column69" DataField="Image_URL" HeaderText="Image URL" runat="server" ReadOnly="true" Visible="false">
                    <TemplateSettings RowEditTemplateControlId="CardImageBack" RowEditTemplateControlPropertyName="src" />
                    <TemplateSettings RowEditTemplateControlId="CardImageFront" RowEditTemplateControlPropertyName="src" />
                </cc1:Column>
            </Columns>
            <TemplateSettings RowEditTemplateId="tplRowEdit" />
            <Templates>
                <cc1:GridTemplate runat="server" ID="tplRowEdit">
                    <Template>
                        <div id="mains" class="main">
                            <div class="maindiv">
                                <div class="leftdiv">
                                    <fieldset>
                                        <legend>Front of Card</legend>
                                        <div class=" centertextalign width100percent floatLeft">
                                            <strong>LyondellBasell</strong><br />
                                            <strong class="fontsizelarge">Saftey Observation Form</strong>

                                            <div style="text-align: center; height: 20px; padding-top: 5px;">
                                                <hr style="width: 50%;" />
                                            </div>
                                            <div style="text-align: center; padding-top: 8px; padding-bottom: 10px;">
                                                <b>iCount:</b>&nbsp;&nbsp;<span id="lbliCount" style="width: 150px;"></span>
                                                <br />
                                                <b>Image File:</b>&nbsp;&nbsp;<span id="lblImageFiles" style="width: 100%;"></span>
                                                <br />
                                                <br />
                                                <div style="clear: both; margin: 0 auto; width: 200px; text-align: center;">
                                                    <div style="width: 120px; float: left; margin-top: 3px; text-align: center;">
                                                        <b>Safe/AtRisk Card:</b>
                                                    </div>
                                                    <div style="float: left; width: 50px; text-align: center;">
                                                        <asp:RadioButtonList onmousedown="getSelected(this);" onClick="unselectkRest(this);" ID="lst_Safe_AtRisk_Card" runat="server" RepeatDirection="Horizontal" RepeatLayout="Flow" Enabled="false">
                                                            <asp:ListItem Value="S" Text="Safe"></asp:ListItem>
                                                            <asp:ListItem Value="AR" Text="At Risk"></asp:ListItem>
                                                        </asp:RadioButtonList>
                                                    </div>
                                                </div>
                                                <br />
                                                <br />
                                            </div>
                                        </div>
                                        <div class="width100percent floatLeft">
                                            <div class="width30percent floatLeft lefttextalign ">
                                                <label class="fontbold">
                                                    Date</label><br />
                                                <cc2:OboutTextBox runat="server" ID="txtDate" Width="100" FolderStyle="styles/premiere_blue/OboutTextBox"
                                                    Text='<%# Container.Value %>' /><obout:Calendar ID="Calendar2" runat="server" StyleFolder="Calendar/styles/expedia"
                                                        DatePickerMode="true" TextBoxId="txtDate" TextArrowLeft="" TextArrowRight=""
                                                        DatePickerSynchronize="true" DatePickerImagePath="Calendar/styles/icon2.gif"
                                                        DateFormat="MM/dd/yyyy" EnableViewState="true" AllowDeselect="false" />
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ControlToValidate="txtDate"
                                                    runat="server" ErrorMessage="*" ForeColor="Red">
                                                </asp:RequiredFieldValidator>
                                                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" ControlToValidate="txtDate"
                                                    Display="Dynamic" EnableClientScript="true" runat="server" ValidationExpression="^([0-9]{1,2})[./-]+([0-9]{1,2})[./-]+([0-9]{2}|[0-9]{4})$"
                                                    SetFocusOnError="true" ForeColor="Red">
                                                Please enter date in mm/dd/yyyy format
                                                </asp:RegularExpressionValidator>
                                            </div>
                                            <div class=" width70percent floatLeft lefttextalign " style="overflow: visible;">
                                                <asp:RadioButtonList onmousedown="getSelected(this);" onClick="unselectkRest(this);" RepeatDirection="Horizontal" ID="lst_Shift" runat="server">
                                                    <asp:ListItem Value="Day" Text="Day Shift&nbsp;&nbsp;&nbsp;"></asp:ListItem>
                                                    <asp:ListItem Value="Night" Text="Night Shift&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"></asp:ListItem>
                                                    <asp:ListItem Value="xx" Text="Multible Selected (xx)"></asp:ListItem>
                                                </asp:RadioButtonList>
                                                <asp:RadioButtonList onmousedown="getSelected(this);" onClick="unselectkRest(this);" RepeatDirection="Horizontal" ID="lst_Operations" runat="server" >
                                                    <asp:ListItem Value="Normal" Text="Normal&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"></asp:ListItem>
                                                    <asp:ListItem Value="Turnaround" Text="Turnaround&nbsp;&nbsp;&nbsp;&nbsp;"></asp:ListItem>
                                                    <asp:ListItem Value="Changeover" Text="Changeover&nbsp;&nbsp;&nbsp;&nbsp;"></asp:ListItem>
                                                    <asp:ListItem Value="Project" Text="Project&nbsp;&nbsp;&nbsp;"></asp:ListItem>
                                                    <asp:ListItem Value="xx" Text="Multible Selected (xx)"></asp:ListItem>
                                                </asp:RadioButtonList>
                                                <asp:RadioButtonList onmousedown="getSelected(this);" onClick="unselectkRest(this);" RepeatDirection="Horizontal" ID="lst_Observation_Type" runat="server">
                                                    <asp:ListItem Value="Coached" Text="Coached&nbsp;&nbsp;&nbsp;"></asp:ListItem>
                                                    <asp:ListItem Value="Shutdown" Text="Shutdown&nbsp;&nbsp;&nbsp;&nbsp;"></asp:ListItem>
                                                    <asp:ListItem Value="Self" Text="Self Observed&nbsp;"></asp:ListItem>                                                    
                                                    <asp:ListItem Value="Startup" Text="Startup&nbsp;"></asp:ListItem>
                                                    <asp:ListItem Value="Cross" Text="Cross&nbsp;&nbsp;&nbsp;&nbsp;"></asp:ListItem>
                                                    <asp:ListItem Value="xx" Text="Multible Selected (xx)"></asp:ListItem>
                                                </asp:RadioButtonList>
                                            </div>
                                        </div>
                                        <div class="clearBoth width100percent lefttextalign">
                                            <div class="width50percent">
                                                <label class="fontbold">
                                                    Location</label><br />
                                                <%--<cc1:OboutTextBox runat="server" Width="80" ID="txt_Location_Description" FolderStyle="styles/premiere_blue/OboutTextBox" />--%>
                                                <cc2:OboutDropDownList ID="ddlLocation" Width="350" runat="server" DataSourceID="SqlDataSourceLocation"
                                                    DataTextField="Name_Code_Combo" DataValueField="PKLocationID" Height="400px">
                                                </cc2:OboutDropDownList>
                                            </div>
                                        </div>
                                        <div class="width100percent margintop10pixel">
                                            <div class="width50percent floatLeft lefttextalign">
                                                <label class="fontbold">
                                                    Observer ID</label><br />
                                                <cc2:OboutDropDownList ID="ddlEmployee1" Width="250" runat="server" DataSourceID="SqlDataSourceEmployee"
                                                    DataTextField="Name_Code_Combo" DataValueField="PKEmployeeID" Height="400px">
                                                </cc2:OboutDropDownList>
                                            </div>
                                            <div class="width50percent floatLeft lefttextalign">
                                                <label class="fontbold">
                                                    Observers Company Code</label><br />
                                                <cc2:OboutDropDownList ID="ddlCompany1" Width="250" runat="server" DataSourceID="SqlDataSourceCompany"
                                                    DataTextField="Name_Code_Combo" DataValueField="PKCompanyID" Height="400px">
                                                </cc2:OboutDropDownList>
                                            </div>
                                        </div>
                                        <div class="clearBoth width100percent floatLeft margintop10pixel">
                                            <div class="width50percent floatLeft lefttextalign">
                                                <label class="fontbold">
                                                    Coach ID</label><br />
                                                <cc2:OboutDropDownList ID="ddlEmployee2" Width="250" runat="server" DataSourceID="SqlDataSourceEmployee"
                                                    DataTextField="Name_Code_Combo" DataValueField="PKEmployeeID" Height="400px">
                                                </cc2:OboutDropDownList>
                                            </div>
                                            <div class="width50percent floatLeft lefttextalign">
                                                <label class="fontbold">
                                                    Observed Company Code</label><br />
                                                <cc2:OboutDropDownList ID="ddlCompany2" Width="250" runat="server" DataSourceID="SqlDataSourceCompany"
                                                    DataTextField="Name_Code_Combo" DataValueField="PKCompanyID" Height="400px">
                                                </cc2:OboutDropDownList>
                                            </div>
                                        </div>
                                        <div class="clearBoth width100percent floatLeft margintop10pixel">
                                            <div class="width100percent lefttextalign">
                                                <label class="fontbold">
                                                    Company Name</label><br />
                                                <cc2:OboutTextBox runat="server" ID="txt_Name_of_Company_on_Form" FolderStyle="styles/premiere_blue/OboutTextBox" Width="300" />
                                            </div>
                                        </div>
                                        <div class="clearBoth width100percent floatLeft margintop10pixel lefttextalign">
                                            <div class="width5percent floatLeft  fontbold ">
                                                A
                                            </div>
                                            <div class="width15percent floatLeft fontbold">
                                                &nbsp;&nbsp;&nbsp;S&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;AR&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;!
                                            </div>
                                            <div class="width30percent floatLeft fontbold">
                                                START SAFE___________
                                            </div>
                                            <div class="width5percent floatLeft fontbold">
                                                E
                                            </div>
                                            <div class="width15percent floatLeft fontbold">
                                                &nbsp;&nbsp;&nbsp;S&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;AR&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;!
                                            </div>
                                            <div class=" width30percent floatLeft fontbold">
                                                TRANS,EQUIP & TOOL<br />
                                                SELECTION USE & COND.___
                                            </div>
                                        </div>
                                       
                                        <div class="width100percent floatLeft lefttextalign">
                                            <div class="width5percent floatLeft  fontbold  margintop10pixel">
                                                A1
                                            </div>
                                            <div class="width15percent floatLeft fontbold margintop5pixel" >
                                                <asp:RadioButtonList onmousedown="getSelected(this);" onClick="unselectkRest(this);" TextAlign="Left" RepeatDirection="Horizontal" ID="lst_A1" runat="server">
                                                    <asp:ListItem Value="S" Text=""></asp:ListItem>
                                                    <asp:ListItem Value="AR" Text=""></asp:ListItem>
                                                    <asp:ListItem Value="xx" Text=""></asp:ListItem>
                                                </asp:RadioButtonList>
                                            </div>
                                            <div class="width30percent floatLeft  margintop10pixel">
                                                Rushing
                                            </div>
                                            <div class="width5percent floatLeft fontbold margintop10pixel">
                                                E1
                                            </div>
                                            <div class="width15percent floatLeft fontbold margintop5pixel">
                                                <asp:RadioButtonList onmousedown="getSelected(this);" onClick="unselectkRest(this);" TextAlign="Left" RepeatDirection="Horizontal" ID="lst_E1" runat="server">
                                                    <asp:ListItem Value="S" Text=""></asp:ListItem>
                                                    <asp:ListItem Value="AR" Text=""></asp:ListItem>
                                                    <asp:ListItem Value="xx" Text=""></asp:ListItem>
                                                </asp:RadioButtonList>
                                            </div>
                                            <div class=" width30percent floatLeft  margintop10pixel">
                                                Equip & Tools Selection,
                                            <br />
                                                Use Of Condition
                                            </div>
                                        </div>
                                        <div class="width100percent floatLeft lefttextalign">
                                            <div class="width5percent floatLeft  fontbold  margintop10pixel">
                                                A2
                                            </div>
                                            <div class="width15percent floatLeft fontbold margintop5pixel">
                                                <asp:RadioButtonList onmousedown="getSelected(this);" onClick="unselectkRest(this);" TextAlign="Left" RepeatDirection="Horizontal" ID="lst_A2" runat="server">
                                                    <asp:ListItem Value="S" Text=""></asp:ListItem>
                                                    <asp:ListItem Value="AR" Text=""></asp:ListItem>
                                                    <asp:ListItem Value="xx" Text=""></asp:ListItem>
                                                </asp:RadioButtonList>
                                            </div>
                                            <div class="width30percent floatLeft  margintop10pixel">
                                                Frushing
                                            </div>
                                            <div class="width5percent floatLeft fontbold margintop10pixel">
                                                E2
                                            </div>
                                            <div class="width15percent floatLeft fontbold margintop5pixel">
                                                <asp:RadioButtonList onmousedown="getSelected(this);" onClick="unselectkRest(this);" TextAlign="Left" RepeatDirection="Horizontal" ID="lst_E2" runat="server">
                                                    <asp:ListItem Value="S" Text=""></asp:ListItem>
                                                    <asp:ListItem Value="AR" Text=""></asp:ListItem>
                                                    <asp:ListItem Value="xx" Text=""></asp:ListItem>
                                                </asp:RadioButtonList>
                                            </div>
                                            <div class=" width30percent floatLeft  margintop10pixel">
                                                Saftey Gaurds
                                            </div>
                                        </div>
                                        <div class="width100percent floatLeft lefttextalign">
                                            <div class="width5percent floatLeft  fontbold  margintop10pixel">
                                                A3
                                            </div>
                                            <div class="width15percent floatLeft fontbold margintop5pixel">
                                                <asp:RadioButtonList onmousedown="getSelected(this);" onClick="unselectkRest(this);" TextAlign="Left" RepeatDirection="Horizontal" ID="lst_A3" runat="server">
                                                    <asp:ListItem Value="S" Text=""></asp:ListItem>
                                                    <asp:ListItem Value="AR" Text=""></asp:ListItem>
                                                    <asp:ListItem Value="xx" Text=""></asp:ListItem>
                                                </asp:RadioButtonList>
                                            </div>
                                            <div class="width30percent floatLeft  margintop10pixel">
                                                Fatigue
                                            </div>
                                            <div class="width5percent floatLeft fontbold margintop10pixel">
                                                E3
                                            </div>
                                            <div class="width15percent floatLeft fontbold margintop5pixel">
                                                <asp:RadioButtonList onmousedown="getSelected(this);" onClick="unselectkRest(this);" TextAlign="Left" RepeatDirection="Horizontal" ID="lst_E3" runat="server">
                                                    <asp:ListItem Value="S" Text=""></asp:ListItem>
                                                    <asp:ListItem Value="AR" Text=""></asp:ListItem>
                                                    <asp:ListItem Value="xx" Text=""></asp:ListItem>
                                                </asp:RadioButtonList>
                                            </div>
                                            <div class=" width30percent floatLeft  margintop10pixel">
                                                Graunding
                                            </div>
                                        </div>
                                        <div class="width100percent floatLeft lefttextalign">
                                            <div class="width5percent floatLeft  fontbold  margintop10pixel">
                                                A4
                                            </div>
                                            <div class="width15percent floatLeft fontbold margintop5pixel">
                                                <asp:RadioButtonList onmousedown="getSelected(this);" onClick="unselectkRest(this);" TextAlign="Left" RepeatDirection="Horizontal" ID="lst_A4" runat="server">
                                                    <asp:ListItem Value="S" Text=""></asp:ListItem>
                                                    <asp:ListItem Value="AR" Text=""></asp:ListItem>
                                                    <asp:ListItem Value="xx" Text=""></asp:ListItem>
                                                </asp:RadioButtonList>
                                            </div>
                                            <div class="width30percent floatLeft  margintop10pixel">
                                                Complacency
                                            </div>
                                            <div class="width5percent floatLeft fontbold margintop10pixel">
                                                E4
                                            </div>
                                            <div class="width15percent floatLeft fontbold margintop5pixel">
                                                <asp:RadioButtonList onmousedown="getSelected(this);" onClick="unselectkRest(this);" TextAlign="Left" RepeatDirection="Horizontal" ID="lst_E4" runat="server">
                                                    <asp:ListItem Value="S" Text=""></asp:ListItem>
                                                    <asp:ListItem Value="AR" Text=""></asp:ListItem>
                                                    <asp:ListItem Value="xx" Text=""></asp:ListItem>
                                                </asp:RadioButtonList>
                                            </div>
                                            <div class=" width30percent floatLeft  margintop10pixel">
                                                Transportation Use/Vehicle/Bicycle
                                            </div>
                                        </div>
                                        <div class="width100percent floatLeft margintop10pixel lefttextalign">
                                            <div class="width5percent floatLeft  fontbold ">
                                                B
                                            </div>
                                            <div class="width15percent floatLeft fontbold">
                                                &nbsp;&nbsp;&nbsp;S&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;AR&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;!
                                            </div>
                                            <div class="width30percent floatLeft fontbold">
                                                BODY POSITION______
                                            </div>
                                            <div class="width5percent floatLeft fontbold">
                                                F
                                            </div>
                                            <div class="width15percent floatLeft fontbold">
                                                &nbsp;&nbsp;&nbsp;S&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;AR&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;!
                                            </div>
                                            <div class=" width30percent floatLeft fontbold">
                                                WORKING ENVIROMENT_____
                                            </div>
                                        </div>
                                        <div class="width100percent floatLeft lefttextalign">
                                            <div class="width5percent floatLeft  fontbold  margintop10pixel">
                                                B1
                                            </div>
                                            <div class="width15percent floatLeft fontbold margintop5pixel">
                                                <asp:RadioButtonList onmousedown="getSelected(this);" onClick="unselectkRest(this);" TextAlign="Left" RepeatDirection="Horizontal" ID="lst_B1" runat="server">
                                                    <asp:ListItem Value="S" Text=""></asp:ListItem>
                                                    <asp:ListItem Value="AR" Text=""></asp:ListItem>
                                                    <asp:ListItem Value="xx" Text=""></asp:ListItem>
                                                </asp:RadioButtonList>
                                            </div>
                                            <div class="width30percent floatLeft  margintop10pixel">
                                                Eyes On Path
                                            </div>
                                            <div class="width5percent floatLeft fontbold margintop10pixel">
                                                F1
                                            </div>
                                            <div class="width15percent floatLeft fontbold margintop5pixel">
                                                <asp:RadioButtonList onmousedown="getSelected(this);" onClick="unselectkRest(this);" TextAlign="Left" RepeatDirection="Horizontal" ID="lst_F1" runat="server">
                                                    <asp:ListItem Value="S" Text=""></asp:ListItem>
                                                    <asp:ListItem Value="AR" Text=""></asp:ListItem>
                                                    <asp:ListItem Value="xx" Text=""></asp:ListItem>
                                                </asp:RadioButtonList>
                                            </div>
                                            <div class=" width30percent floatLeft  margintop10pixel">
                                                HouseKeeping
                                            </div>
                                        </div>
                                        <div class="width100percent floatLeft lefttextalign">
                                            <div class="width5percent floatLeft  fontbold  margintop10pixel">
                                                B2
                                            </div>
                                            <div class="width15percent floatLeft fontbold margintop5pixel">
                                                <asp:RadioButtonList onmousedown="getSelected(this);" onClick="unselectkRest(this);" TextAlign="Left" RepeatDirection="Horizontal" ID="lst_B2" runat="server">
                                                    <asp:ListItem Value="S" Text=""></asp:ListItem>
                                                    <asp:ListItem Value="AR" Text=""></asp:ListItem>
                                                    <asp:ListItem Value="xx" Text=""></asp:ListItem>
                                                </asp:RadioButtonList>
                                            </div>
                                            <div class="width30percent floatLeft  margintop10pixel">
                                                Eyes on Work
                                            </div>
                                            <div class="width5percent floatLeft fontbold margintop10pixel">
                                                F2
                                            </div>
                                            <div class="width15percent floatLeft fontbold margintop5pixel">
                                                <asp:RadioButtonList onmousedown="getSelected(this);" onClick="unselectkRest(this);" TextAlign="Left" RepeatDirection="Horizontal" ID="lst_F2" runat="server">
                                                    <asp:ListItem Value="S" Text=""></asp:ListItem>
                                                    <asp:ListItem Value="AR" Text=""></asp:ListItem>
                                                    <asp:ListItem Value="xx" Text=""></asp:ListItem>
                                                </asp:RadioButtonList>
                                            </div>
                                            <div class=" width30percent floatLeft  margintop10pixel">
                                                Walk/ Work Surfaces/Access-Egress
                                            </div>
                                        </div>
                                        <div class="width100percent floatLeft lefttextalign">
                                            <div class="width5percent floatLeft  fontbold  margintop10pixel">
                                                B3
                                            </div>
                                            <div class="width15percent floatLeft fontbold margintop5pixel">
                                                <asp:RadioButtonList onmousedown="getSelected(this);" onClick="unselectkRest(this);" TextAlign="Left" RepeatDirection="Horizontal" ID="lst_B3" runat="server">
                                                    <asp:ListItem Value="S" Text=""></asp:ListItem>
                                                    <asp:ListItem Value="AR" Text=""></asp:ListItem>
                                                    <asp:ListItem Value="xx" Text=""></asp:ListItem>
                                                </asp:RadioButtonList>
                                            </div>
                                            <div class="width30percent floatLeft  margintop10pixel">
                                                Line of FIre
                                            </div>
                                            <div class="width5percent floatLeft fontbold margintop10pixel">
                                                F3
                                            </div>
                                            <div class="width15percent floatLeft fontbold margintop5pixel">
                                                <asp:RadioButtonList onmousedown="getSelected(this);" onClick="unselectkRest(this);" TextAlign="Left" RepeatDirection="Horizontal" ID="lst_F3" runat="server">
                                                    <asp:ListItem Value="S" Text=""></asp:ListItem>
                                                    <asp:ListItem Value="AR" Text=""></asp:ListItem>
                                                    <asp:ListItem Value="xx" Text=""></asp:ListItem>
                                                </asp:RadioButtonList>
                                            </div>
                                            <div class=" width30percent floatLeft  margintop10pixel">
                                                BarnCades/Barriers
                                            </div>
                                        </div>
                                        <div class="width100percent floatLeft lefttextalign">
                                            <div class="width5percent floatLeft  fontbold  margintop10pixel">
                                                B4
                                            </div>
                                            <div class="width15percent floatLeft fontbold margintop5pixel">
                                                <asp:RadioButtonList onmousedown="getSelected(this);" onClick="unselectkRest(this);" TextAlign="Left" RepeatDirection="Horizontal" ID="lst_B4" runat="server">
                                                    <asp:ListItem Value="S" Text=""></asp:ListItem>
                                                    <asp:ListItem Value="AR" Text=""></asp:ListItem>
                                                    <asp:ListItem Value="xx" Text=""></asp:ListItem>
                                                </asp:RadioButtonList>
                                            </div>
                                            <div class="width30percent floatLeft  margintop10pixel">
                                                Pinch Points
                                            </div>
                                            <div class="width5percent floatLeft fontbold margintop10pixel">
                                                F4
                                            </div>
                                            <div class="width15percent floatLeft fontbold margintop5pixel">
                                                <asp:RadioButtonList onmousedown="getSelected(this);" onClick="unselectkRest(this);" TextAlign="Left" RepeatDirection="Horizontal" ID="lst_F4" runat="server">
                                                    <asp:ListItem Value="S" Text=""></asp:ListItem>
                                                    <asp:ListItem Value="AR" Text=""></asp:ListItem>
                                                    <asp:ListItem Value="xx" Text=""></asp:ListItem>
                                                </asp:RadioButtonList>
                                            </div>
                                            <div class=" width30percent floatLeft  margintop10pixel">
                                                Heat Stress/Cold Stress
                                            </div>
                                        </div>
                                        <div class="width100percent floatLeft lefttextalign">
                                            <div class="width5percent floatLeft  fontbold  margintop10pixel">
                                                B5
                                            </div>
                                            <div class="width15percent floatLeft fontbold margintop5pixel">
                                                <asp:RadioButtonList onmousedown="getSelected(this);" onClick="unselectkRest(this);" TextAlign="Left" RepeatDirection="Horizontal" ID="lst_B5" runat="server">
                                                    <asp:ListItem Value="S" Text=""></asp:ListItem>
                                                    <asp:ListItem Value="AR" Text=""></asp:ListItem>
                                                    <asp:ListItem Value="xx" Text=""></asp:ListItem>
                                                </asp:RadioButtonList>
                                            </div>
                                            <div class="width30percent floatLeft  margintop10pixel">
                                                Ascending /Descending
                                            </div>
                                            <div class="width5percent floatLeft fontbold margintop10pixel">
                                                F5
                                            </div>
                                            <div class="width15percent floatLeft fontbold margintop5pixel">
                                                <asp:RadioButtonList onmousedown="getSelected(this);" onClick="unselectkRest(this);" TextAlign="Left" RepeatDirection="Horizontal" ID="lst_F5" runat="server">
                                                    <asp:ListItem Value="S" Text=""></asp:ListItem>
                                                    <asp:ListItem Value="AR" Text=""></asp:ListItem>
                                                    <asp:ListItem Value="xx" Text=""></asp:ListItem>
                                                </asp:RadioButtonList>
                                            </div>
                                            <div class=" width30percent floatLeft  margintop10pixel">
                                                Lighting
                                            </div>
                                        </div>
                                        <div class="width100percent floatLeft lefttextalign">
                                            <div class="width5percent floatLeft  fontbold  margintop10pixel">
                                                B6
                                            </div>
                                            <div class="width15percent floatLeft fontbold margintop5pixel">
                                                <asp:RadioButtonList onmousedown="getSelected(this);" onClick="unselectkRest(this);" TextAlign="Left" RepeatDirection="Horizontal" ID="lst_B6" runat="server">
                                                    <asp:ListItem Value="S" Text=""></asp:ListItem>
                                                    <asp:ListItem Value="AR" Text=""></asp:ListItem>
                                                    <asp:ListItem Value="xx" Text=""></asp:ListItem>
                                                </asp:RadioButtonList>
                                            </div>
                                            <div class="width30percent floatLeft  margintop10pixel">
                                                Getting Assistance
                                            </div>
                                            <div class="width5percent floatLeft fontbold margintop10pixel">
                                                G
                                            </div>
                                            <div class="width15percent floatLeft fontbold  margintop10pixel">
                                                &nbsp;&nbsp;S&nbsp;&nbsp;AR
                                            </div>
                                            <div class=" width30percent floatLeft  margintop10pixel fontbold">
                                                PROCEDURE RELATED__
                                            </div>
                                        </div>
                                        <div class="width100percent floatLeft lefttextalign">
                                            <div class="width5percent floatLeft  fontbold  margintop10pixel">
                                                C
                                            </div>
                                            <div class="width15percent floatLeft fontbold margintop10pixel">
                                                &nbsp;&nbsp;&nbsp;S&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;AR&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;!
                                            </div>
                                            <div class="width30percent floatLeft  margintop10pixel fontbold">
                                                BODY MECHANICS
                                            </div>
                                            <div class="width5percent floatLeft fontbold margintop10pixel">
                                                G1
                                            </div>
                                            <div class="width15percent floatLeft fontbold margintop5pixel">
                                                <asp:RadioButtonList onmousedown="getSelected(this);" onClick="unselectkRest(this);" TextAlign="Left" RepeatDirection="Horizontal" ID="lst_G1" runat="server">
                                                    <asp:ListItem Value="S" Text=""></asp:ListItem>
                                                    <asp:ListItem Value="AR" Text=""></asp:ListItem>
                                                    <asp:ListItem Value="xx" Text=""></asp:ListItem>
                                                </asp:RadioButtonList>
                                            </div>
                                            <div class=" width30percent floatLeft  margintop10pixel">
                                                Pre/Post-job Inspection
                                            </div>
                                        </div>
                                        <div class="width100percent floatLeft lefttextalign">
                                            <div class="width5percent floatLeft  fontbold  margintop10pixel">
                                                C1
                                            </div>
                                            <div class="width15percent floatLeft fontbold margintop5pixel">
                                                <asp:RadioButtonList onmousedown="getSelected(this);" onClick="unselectkRest(this);" TextAlign="Left" RepeatDirection="Horizontal" ID="lst_C1" runat="server">
                                                    <asp:ListItem Value="S" Text=""></asp:ListItem>
                                                    <asp:ListItem Value="AR" Text=""></asp:ListItem>
                                                    <asp:ListItem Value="xx" Text=""></asp:ListItem>
                                                </asp:RadioButtonList>
                                            </div>
                                            <div class="width30percent floatLeft  margintop10pixel">
                                                Repetative Motion
                                            </div>
                                            <div class="width5percent floatLeft fontbold margintop10pixel">
                                                G2
                                            </div>
                                            <div class="width15percent floatLeft fontbold margintop5pixel">
                                                <asp:RadioButtonList onmousedown="getSelected(this);" onClick="unselectkRest(this);" TextAlign="Left" RepeatDirection="Horizontal" ID="lst_G2" runat="server">
                                                    <asp:ListItem Value="S" Text=""></asp:ListItem>
                                                    <asp:ListItem Value="AR" Text=""></asp:ListItem>
                                                    <asp:ListItem Value="xx" Text=""></asp:ListItem>
                                                </asp:RadioButtonList>
                                            </div>
                                            <div class=" width30percent floatLeft  margintop10pixel">
                                                Lighting
                                            </div>
                                        </div>
                                        <div class="width100percent floatLeft lefttextalign">
                                            <div class="width5percent floatLeft  fontbold  margintop10pixel">
                                                C2
                                            </div>
                                            <div class="width15percent floatLeft fontbold margintop5pixel">
                                                <asp:RadioButtonList onmousedown="getSelected(this);" onClick="unselectkRest(this);" TextAlign="Left" RepeatDirection="Horizontal" ID="lst_C2" runat="server">
                                                    <asp:ListItem Value="S" Text=""></asp:ListItem>
                                                    <asp:ListItem Value="AR" Text=""></asp:ListItem>
                                                    <asp:ListItem Value="xx" Text=""></asp:ListItem>
                                                </asp:RadioButtonList>
                                            </div>
                                            <div class="width30percent floatLeft  margintop10pixel">
                                                Push/Pull
                                            </div>
                                            <div class="width5percent floatLeft fontbold margintop10pixel">
                                                G3
                                            </div>
                                            <div class="width15percent floatLeft fontbold margintop5pixel">
                                                <asp:RadioButtonList onmousedown="getSelected(this);" onClick="unselectkRest(this);" TextAlign="Left" RepeatDirection="Horizontal" ID="lst_G3" runat="server">
                                                    <asp:ListItem Value="S" Text=""></asp:ListItem>
                                                    <asp:ListItem Value="AR" Text=""></asp:ListItem>
                                                    <asp:ListItem Value="xx" Text=""></asp:ListItem>
                                                </asp:RadioButtonList>
                                            </div>
                                            <div class=" width30percent floatLeft  margintop10pixel">
                                                Lockout/Tagout/Try
                                            </div>
                                        </div>
                                        <div class="width100percent floatLeft lefttextalign">
                                            <div class="width5percent floatLeft  fontbold  margintop10pixel">
                                                C3
                                            </div>
                                            <div class="width15percent floatLeft fontbold margintop5pixel">
                                                <asp:RadioButtonList onmousedown="getSelected(this);" onClick="unselectkRest(this);" TextAlign="Left" RepeatDirection="Horizontal" ID="lst_C3" runat="server">
                                                    <asp:ListItem Value="S" Text=""></asp:ListItem>
                                                    <asp:ListItem Value="AR" Text=""></asp:ListItem>
                                                    <asp:ListItem Value="xx" Text=""></asp:ListItem>
                                                </asp:RadioButtonList>
                                            </div>
                                            <div class="width30percent floatLeft  margintop10pixel">
                                                Pivoting / Twisting
                                            </div>
                                            <div class="width5percent floatLeft fontbold margintop10pixel">
                                                H
                                            </div>
                                            <div class="width15percent floatLeft fontbold  margintop10pixel">
                                                &nbsp;&nbsp;&nbsp;S&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;AR&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;!
                                            </div>
                                            <div class=" width30percent floatLeft  margintop10pixel fontbold">
                                                CHEMICALS/ENVIRONMENTAL
                                            </div>
                                        </div>
                                        <div class="width100percent floatLeft lefttextalign">
                                            <div class="width5percent floatLeft  fontbold  margintop10pixel">
                                                C4
                                            </div>
                                            <div class="width15percent floatLeft fontbold margintop5pixel">
                                                <asp:RadioButtonList onmousedown="getSelected(this);" onClick="unselectkRest(this);" TextAlign="Left" RepeatDirection="Horizontal" ID="lst_C4" runat="server">
                                                    <asp:ListItem Value="S" Text=""></asp:ListItem>
                                                    <asp:ListItem Value="AR" Text=""></asp:ListItem>
                                                    <asp:ListItem Value="xx" Text=""></asp:ListItem>
                                                </asp:RadioButtonList>
                                            </div>
                                            <div class="width30percent floatLeft  margintop10pixel">
                                                Leverage
                                            </div>
                                            <div class="width5percent floatLeft fontbold margintop10pixel">
                                                H1
                                            </div>
                                            <div class="width15percent floatLeft fontbold margintop5pixel">
                                                <asp:RadioButtonList onmousedown="getSelected(this);" onClick="unselectkRest(this);" TextAlign="Left" RepeatDirection="Horizontal" ID="lst_H1" runat="server">
                                                    <asp:ListItem Value="S" Text=""></asp:ListItem>
                                                    <asp:ListItem Value="AR" Text=""></asp:ListItem>
                                                    <asp:ListItem Value="xx" Text=""></asp:ListItem>
                                                </asp:RadioButtonList>
                                            </div>
                                            <div class=" width30percent floatLeft  margintop10pixel">
                                                Chemical Use
                                            </div>
                                        </div>
                                        <div class="width100percent floatLeft lefttextalign">
                                            <div class="width5percent floatLeft  fontbold  margintop10pixel">
                                                C5
                                            </div>
                                            <div class="width15percent floatLeft fontbold margintop5pixel">
                                                <asp:RadioButtonList onmousedown="getSelected(this);" onClick="unselectkRest(this);" TextAlign="Left" RepeatDirection="Horizontal" ID="lst_C5" runat="server">
                                                    <asp:ListItem Value="S" Text=""></asp:ListItem>
                                                    <asp:ListItem Value="AR" Text=""></asp:ListItem>
                                                    <asp:ListItem Value="xx" Text=""></asp:ListItem>
                                                </asp:RadioButtonList>
                                            </div>
                                            <div class="width30percent floatLeft  margintop10pixel">
                                                Lifting/Lowering
                                            </div>
                                            <div class="width5percent floatLeft fontbold margintop10pixel">
                                                H2
                                            </div>
                                            <div class="width15percent floatLeft fontbold margintop5pixel">
                                                <asp:RadioButtonList onmousedown="getSelected(this);" onClick="unselectkRest(this);" TextAlign="Left" RepeatDirection="Horizontal" ID="lst_H2" runat="server">
                                                    <asp:ListItem Value="S" Text=""></asp:ListItem>
                                                    <asp:ListItem Value="AR" Text=""></asp:ListItem>
                                                    <asp:ListItem Value="xx" Text=""></asp:ListItem>
                                                </asp:RadioButtonList>
                                            </div>
                                            <div class=" width30percent floatLeft  margintop10pixel">
                                                Grounding/Ventilation
                                            </div>
                                        </div>
                                        <div class="width100percent floatLeft lefttextalign">
                                            <div class="width5percent floatLeft  fontbold  margintop10pixel">
                                                C6
                                            </div>
                                            <div class="width15percent floatLeft fontbold margintop5pixel">
                                                <asp:RadioButtonList onmousedown="getSelected(this);" onClick="unselectkRest(this);" TextAlign="Left" RepeatDirection="Horizontal" ID="lst_C6" runat="server">
                                                    <asp:ListItem Value="S" Text=""></asp:ListItem>
                                                    <asp:ListItem Value="AR" Text=""></asp:ListItem>
                                                    <asp:ListItem Value="xx" Text=""></asp:ListItem>
                                                </asp:RadioButtonList>
                                            </div>
                                            <div class="width30percent floatLeft  margintop10pixel">
                                                Grip
                                            </div>
                                            <div class="width5percent floatLeft fontbold margintop10pixel">
                                                H3
                                            </div>
                                            <div class="width15percent floatLeft fontbold margintop5pixel">
                                                <asp:RadioButtonList onmousedown="getSelected(this);" onClick="unselectkRest(this);" TextAlign="Left" RepeatDirection="Horizontal" ID="lst_H3" runat="server">
                                                    <asp:ListItem Value="S" Text=""></asp:ListItem>
                                                    <asp:ListItem Value="AR" Text=""></asp:ListItem>
                                                    <asp:ListItem Value="xx" Text=""></asp:ListItem>
                                                </asp:RadioButtonList>
                                            </div>
                                            <div class=" width30percent floatLeft  margintop10pixel">
                                                Labeling / Storage
                                            </div>
                                        </div>
                                        <div class="width100percent floatLeft lefttextalign">
                                            <div class="width5percent floatLeft  fontbold  margintop10pixel">
                                                C7
                                            </div>
                                            <div class="width15percent floatLeft fontbold margintop5pixel">
                                                <asp:RadioButtonList onmousedown="getSelected(this);" onClick="unselectkRest(this);" TextAlign="Left" RepeatDirection="Horizontal" ID="lst_C7" runat="server">
                                                    <asp:ListItem Value="S" Text=""></asp:ListItem>
                                                    <asp:ListItem Value="AR" Text=""></asp:ListItem>
                                                    <asp:ListItem Value="xx" Text=""></asp:ListItem>
                                                </asp:RadioButtonList>
                                            </div>
                                            <div class="width30percent floatLeft  margintop10pixel">
                                                Base of Support
                                            </div>
                                            <div class="width5percent floatLeft fontbold margintop10pixel">
                                                H4
                                            </div>
                                            <div class="width15percent floatLeft fontbold margintop5pixel">
                                                <asp:RadioButtonList onmousedown="getSelected(this);" onClick="unselectkRest(this);" TextAlign="Left" RepeatDirection="Horizontal" ID="lst_H4" runat="server">
                                                    <asp:ListItem Value="S" Text=""></asp:ListItem>
                                                    <asp:ListItem Value="AR" Text=""></asp:ListItem>
                                                    <asp:ListItem Value="xx" Text=""></asp:ListItem>
                                                </asp:RadioButtonList>
                                            </div>
                                            <div class=" width30percent floatLeft  margintop10pixel">
                                                Transportation/Spell Prevention
                                            </div>
                                        </div>
                                        <div class="width100percent floatLeft lefttextalign">
                                            <div class="width5percent floatLeft  fontbold  margintop10pixel">
                                                C8
                                            </div>
                                            <div class="width15percent floatLeft fontbold margintop5pixel">
                                                <asp:RadioButtonList onmousedown="getSelected(this);" onClick="unselectkRest(this);" TextAlign="Left" RepeatDirection="Horizontal" ID="lst_C8" runat="server">
                                                    <asp:ListItem Value="S" Text=""></asp:ListItem>
                                                    <asp:ListItem Value="AR" Text=""></asp:ListItem>
                                                    <asp:ListItem Value="xx" Text=""></asp:ListItem>
                                                </asp:RadioButtonList>
                                            </div>
                                            <div class="width30percent floatLeft  margintop10pixel">
                                                Overextending
                                            </div>
                                            <div class="width5percent floatLeft fontbold margintop10pixel">
                                                H5
                                            </div>
                                            <div class="width15percent floatLeft fontbold margintop5pixel">
                                                <asp:RadioButtonList onmousedown="getSelected(this);" onClick="unselectkRest(this);" TextAlign="Left" RepeatDirection="Horizontal" ID="lst_H5" runat="server">
                                                    <asp:ListItem Value="S" Text=""></asp:ListItem>
                                                    <asp:ListItem Value="AR" Text=""></asp:ListItem>
                                                    <asp:ListItem Value="xx" Text=""></asp:ListItem>
                                                </asp:RadioButtonList>
                                            </div>
                                            <div class=" width30percent floatLeft  margintop10pixel">
                                                Waste Disposal Labelling Recycling
                                            </div>
                                        </div>
                                        <div class="width100percent floatLeft lefttextalign">
                                            <div class="width5percent floatLeft  fontbold  margintop10pixel">
                                                D
                                            </div>
                                            <div class="width15percent floatLeft fontbold margintop10pixel">
                                                &nbsp;&nbsp;&nbsp;S&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;AR&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;!
                                            </div>
                                            <div class="width30percent floatLeft  margintop10pixel fontbold">
                                                PERSONAL PROTECTIVE<br />
                                                EQUIPMENT
                                            </div>
                                            <div class="width5percent floatLeft fontbold margintop10pixel">
                                                H6
                                            </div>
                                            <div class="width15percent floatLeft fontbold margintop5pixel">
                                                <asp:RadioButtonList onmousedown="getSelected(this);" onClick="unselectkRest(this);" TextAlign="Left" RepeatDirection="Horizontal" ID="lst_H6" runat="server">
                                                    <asp:ListItem Value="S" Text=""></asp:ListItem>
                                                    <asp:ListItem Value="AR" Text=""></asp:ListItem>
                                                    <asp:ListItem Value="xx" Text=""></asp:ListItem>
                                                </asp:RadioButtonList>
                                            </div>
                                            <div class=" width30percent floatLeft  margintop10pixel">
                                                Pollution Prevention /Containment
                                            </div>
                                        </div>
                                        <div class="width100percent floatLeft lefttextalign">
                                            <div class="width5percent floatLeft  fontbold  margintop10pixel">
                                                D1
                                            </div>
                                            <div class="width15percent floatLeft fontbold margintop5pixel">
                                                <asp:RadioButtonList onmousedown="getSelected(this);" onClick="unselectkRest(this);" TextAlign="Left" RepeatDirection="Horizontal" ID="lst_D1" runat="server">
                                                    <asp:ListItem Value="S" Text=""></asp:ListItem>
                                                    <asp:ListItem Value="AR" Text=""></asp:ListItem>
                                                    <asp:ListItem Value="xx" Text=""></asp:ListItem>
                                                </asp:RadioButtonList>
                                            </div>
                                            <div class="width30percent floatLeft  margintop10pixel">
                                                Head/foot Protection
                                            </div>
                                            <div class="width5percent floatLeft fontbold margintop10pixel">
                                                H7
                                            </div>
                                            <div class="width15percent floatLeft fontbold margintop5pixel">
                                                <asp:RadioButtonList onmousedown="getSelected(this);" onClick="unselectkRest(this);" TextAlign="Left" RepeatDirection="Horizontal" ID="lst_H7" runat="server">
                                                    <asp:ListItem Value="S" Text=""></asp:ListItem>
                                                    <asp:ListItem Value="AR" Text=""></asp:ListItem>
                                                    <asp:ListItem Value="xx" Text=""></asp:ListItem>
                                                </asp:RadioButtonList>
                                            </div>
                                            <div class=" width30percent floatLeft  margintop10pixel">
                                                Control of Release Caps & Plugs
                                            </div>
                                        </div>
                                        <div class="width100percent floatLeft lefttextalign">
                                            <div class="width5percent floatLeft  fontbold  margintop10pixel">
                                                D2
                                            </div>
                                            <div class="width15percent floatLeft fontbold margintop5pixel">
                                                <asp:RadioButtonList onmousedown="getSelected(this);" onClick="unselectkRest(this);" TextAlign="Left" RepeatDirection="Horizontal" ID="lst_D2" runat="server">
                                                    <asp:ListItem Value="S" Text=""></asp:ListItem>
                                                    <asp:ListItem Value="AR" Text=""></asp:ListItem>
                                                    <asp:ListItem Value="xx" Text=""></asp:ListItem>
                                                </asp:RadioButtonList>
                                            </div>
                                            <div class="width30percent floatLeft  margintop10pixel">
                                                Eye/Face Protection
                                            </div>
                                            <div class="width5percent floatLeft fontbold margintop10pixel">
                                                H8
                                            </div>
                                            <div class="width15percent floatLeft fontbold margintop5pixel">
                                                <asp:RadioButtonList onmousedown="getSelected(this);" onClick="unselectkRest(this);" TextAlign="Left" RepeatDirection="Horizontal" ID="lst_H8" runat="server">
                                                    <asp:ListItem Value="S" Text=""></asp:ListItem>
                                                    <asp:ListItem Value="AR" Text=""></asp:ListItem>
                                                    <asp:ListItem Value="xx" Text=""></asp:ListItem>
                                                </asp:RadioButtonList>
                                            </div>
                                            <div class=" width30percent floatLeft  margintop10pixel">
                                                Energy Conservation
                                            </div>
                                        </div>
                                        <div class="width100percent floatLeft lefttextalign">
                                            <div class="width5percent floatLeft  fontbold  margintop10pixel">
                                                D3
                                            </div>
                                            <div class="width15percent floatLeft fontbold margintop5pixel">
                                                <asp:RadioButtonList onmousedown="getSelected(this);" onClick="unselectkRest(this);" TextAlign="Left" RepeatDirection="Horizontal" ID="lst_D3" runat="server">
                                                    <asp:ListItem Value="S" Text=""></asp:ListItem>
                                                    <asp:ListItem Value="AR" Text=""></asp:ListItem>
                                                    <asp:ListItem Value="xx" Text=""></asp:ListItem>
                                                </asp:RadioButtonList>
                                            </div>
                                            <div class="width30percent floatLeft  margintop10pixel">
                                                Hearing / Protection
                                            </div>
                                            <div class="width5percent floatLeft fontbold margintop10pixel">
                                                J
                                            </div>
                                            <div class="width15percent floatLeft fontbold  margintop10pixel">
                                                &nbsp;&nbsp;&nbsp;Y&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;N&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;!
                                            </div>
                                            <div class=" width30percent floatLeft  margintop10pixel fontbold">
                                                CHECK SIGNALS____
                                            </div>
                                        </div>
                                        <div class="width100percent floatLeft lefttextalign">
                                            <div class="width5percent floatLeft  fontbold  margintop10pixel">
                                                D4
                                            </div>
                                            <div class="width15percent floatLeft fontbold margintop5pixel">
                                                <asp:RadioButtonList onmousedown="getSelected(this);" onClick="unselectkRest(this);" TextAlign="Left" RepeatDirection="Horizontal" ID="lst_D4" runat="server">
                                                    <asp:ListItem Value="S" Text=""></asp:ListItem>
                                                    <asp:ListItem Value="AR" Text=""></asp:ListItem>
                                                    <asp:ListItem Value="xx" Text=""></asp:ListItem>
                                                </asp:RadioButtonList>
                                            </div>
                                            <div class="width30percent floatLeft  margintop10pixel">
                                                Repository Protection
                                            </div>
                                            <div class="width5percent floatLeft fontbold margintop10pixel">
                                                J1
                                            </div>
                                            <div class="width15percent floatLeft fontbold margintop5pixel">
                                                <asp:RadioButtonList onmousedown="getSelected(this);" onClick="unselectkRest(this);" TextAlign="Left" RepeatDirection="Horizontal" ID="lst_J1" runat="server">
                                                    <asp:ListItem Value="Y" Text=""></asp:ListItem>
                                                    <asp:ListItem Value="N" Text=""></asp:ListItem>
                                                    <asp:ListItem Value="xx" Text=""></asp:ListItem>
                                                </asp:RadioButtonList>
                                            </div>
                                            <div class=" width30percent floatLeft  margintop10pixel">
                                                Check Signals Performed
                                            </div>
                                        </div>
                                        <div class="width100percent floatLeft lefttextalign">
                                            <div class="width5percent floatLeft  fontbold  margintop10pixel">
                                                D5
                                            </div>
                                            <div class="width15percent floatLeft fontbold margintop5pixel">
                                                <asp:RadioButtonList onmousedown="getSelected(this);" onClick="unselectkRest(this);" TextAlign="Left" RepeatDirection="Horizontal" ID="lst_D5" runat="server">
                                                    <asp:ListItem Value="S" Text=""></asp:ListItem>
                                                    <asp:ListItem Value="AR" Text=""></asp:ListItem>
                                                    <asp:ListItem Value="xx" Text=""></asp:ListItem>
                                                </asp:RadioButtonList>
                                            </div>
                                            <div class="width30percent floatLeft  margintop10pixel">
                                                Hand/Arm Protection
                                            </div>
                                            <div class="width5percent floatLeft fontbold margintop10pixel">
                                                J2
                                            </div>
                                            <div class="width15percent floatLeft fontbold margintop5pixel">
                                                <asp:RadioButtonList onmousedown="getSelected(this);" onClick="unselectkRest(this);" TextAlign="Left" RepeatDirection="Horizontal" ID="lst_J2" runat="server">
                                                    <asp:ListItem Value="Y" Text=""></asp:ListItem>
                                                    <asp:ListItem Value="N" Text=""></asp:ListItem>
                                                    <asp:ListItem Value="xx" Text=""></asp:ListItem>
                                                </asp:RadioButtonList>
                                            </div>
                                            <div class=" width30percent floatLeft  margintop10pixel">
                                                Focus-Start to Finish
                                            </div>
                                        </div>
                                        <div class="width100percent floatLeft lefttextalign">
                                            <div class="width5percent floatLeft  fontbold  margintop10pixel">
                                                D6
                                            </div>
                                            <div class="width15percent floatLeft fontbold margintop5pixel">
                                                <asp:RadioButtonList onmousedown="getSelected(this);" onClick="unselectkRest(this);" TextAlign="Left" RepeatDirection="Horizontal" ID="lst_D6" runat="server">
                                                    <asp:ListItem Value="S" Text=""></asp:ListItem>
                                                    <asp:ListItem Value="AR" Text=""></asp:ListItem>
                                                    <asp:ListItem Value="xx" Text=""></asp:ListItem>
                                                </asp:RadioButtonList>
                                            </div>
                                            <div class="width30percent floatLeft  margintop10pixel">
                                                Body Protection
                                            </div>
                                            <div class="width5percent floatLeft fontbold margintop10pixel">
                                                K
                                            </div>
                                            <div class="width15percent floatLeft fontbold  margintop10pixel">
                                                &nbsp;&nbsp;&nbsp;S&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;AR&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;!
                                            </div>
                                            <div class=" width30percent floatLeft  margintop10pixel fontbold">
                                                OTHER_______
                                            </div>
                                        </div>
                                        <div class="width100percent floatLeft lefttextalign">
                                            <div class="width5percent floatLeft  fontbold  margintop10pixel">
                                                D7
                                            </div>
                                            <div class="width15percent floatLeft fontbold margintop5pixel">
                                                <asp:RadioButtonList onmousedown="getSelected(this);" onClick="unselectkRest(this);" TextAlign="Left" RepeatDirection="Horizontal" ID="lst_D7" runat="server">
                                                    <asp:ListItem Value="S" Text=""></asp:ListItem>
                                                    <asp:ListItem Value="AR" Text=""></asp:ListItem>
                                                    <asp:ListItem Value="xx" Text=""></asp:ListItem>
                                                </asp:RadioButtonList>
                                            </div>
                                            <div class="width30percent floatLeft  margintop10pixel">
                                                Fall Protection
                                            </div>
                                            <div class="width5percent floatLeft fontbold margintop10pixel">
                                                K1
                                            </div>
                                            <div class="width15percent floatLeft fontbold margintop5pixel">
                                                <asp:RadioButtonList onmousedown="getSelected(this);" onClick="unselectkRest(this);" TextAlign="Left" RepeatDirection="Horizontal" ID="lst_K1" runat="server">
                                                    <asp:ListItem Value="S" Text=""></asp:ListItem>
                                                    <asp:ListItem Value="AR" Text=""></asp:ListItem>
                                                    <asp:ListItem Value="xx" Text=""></asp:ListItem>
                                                </asp:RadioButtonList>
                                            </div>
                                            <div class=" width30percent floatLeft  margintop10pixel">
                                                Other &/or Changed Behaviour
                                            </div>
                                        </div>
                                    </fieldset>
                                </div>
                                <div style="float: left; width: auto; height: 10px; overflow: visible;">
                                    <fieldset style="width: auto; height: auto; text-align: left; background-color: #EBECEC;">
                                        <legend>Card Image: Front</legend>
                                        <asp:Image ID="CardImageFront" runat="server" />
                                    </fieldset>
                                </div>
                            </div>
                            <div style="width: 100%; float: left; min-height: 30px; background-color: #EBECEC; color: #666666;">
                                <br />
                                <hr />
                            </div>
                            <div align="center" style="background-color: #EBECEC; color: #666666; float: left; width: 100%; height: 1000px;">
                                <div class="leftdiv">
                                    <fieldset style="width: auto; height: auto; text-align: left; background-color: #EBECEC;">
                                        <legend>Back of Card</legend>
                                        <div class=" width100percent floatLeft">
                                            <cc2:OboutTextBox ID="txt_Item_1" runat="server" Width="30"></cc2:OboutTextBox>&nbsp;<label>Item#1</label>&nbsp;&nbsp;&nbsp;<label class="fontbold">WHAT WAS AT RISK, AND WHY WAS THE AT-RISK PERFORMED?</label><br />
                                        </div>
                                        <div class=" width100percent floatLeft centertextalign">
                                            <asp:TextBox runat="server" ID="txt_Item_Text_1" Width="98%" Height="100px"
                                                TextMode="MultiLine"></asp:TextBox>
                                        </div>
                                        <div class=" width100percent floatLeft  centertextalign">
                                            <div class="width70percent floatLeft righttextalign padding2px">
                                                STEERING COMMITTEE FOLLOW-UP NEEDED:
                                            </div>
                                            <div class="width20percent floatLeft lefttextalign">
                                                <%--<asp:RadioButtonList onmousedown="getSelected(this);" onClick="unselectkRest(this);" RepeatDirection="Horizontal" ID="lst_FollowUp_Needed_1" runat="server">
                                                    <asp:ListItem Value="Y" Text="Yes"></asp:ListItem>
                                                </asp:RadioButtonList>--%>
                                                <cc2:OboutCheckBox ID="chk_FollowUp_Needed_1" runat="server" Text="Yes"></cc2:OboutCheckBox>
                                            </div>
                                        </div>
                                        <div style="clear: both; width: 100%; float: left; text-align: left; padding: 5px  0 15px 0; border-bottom: 1px solid grey;">
                                            <div style="width: 33%; float: left; min-height: 20px; text-align: left;">
                                                <b>AR Expected Date</b><br />
                                                <cc2:OboutTextBox runat="server" ID="txt_Expected_Date_1" Width="80" FolderStyle="styles/premiere_blue/OboutTextBox"
                                                    Text='<%# Container.Value %>' /><obout:Calendar ID="Calendar1" runat="server" TextBoxId="txt_Expected_Date_1"
                                                         DatePickerMode="true" DatePickerImagePath="Calendar/styles/icon2.gif"></obout:Calendar>
                                                <%--<obout:Calendar ID="Calendar1" runat="server" StyleFolder="Calendar/styles/expedia"
                                                        DatePickerMode="true" TextBoxId="txt_Expected_Date_1" Align="Under"
                                                        DatePickerSynchronize="true" DatePickerImagePath="Calendar/styles/icon2.gif"
                                                        DateFormat="MM/dd/yyyy" EnableViewState="true" AllowDeselect="false" />--%>
                                                <%--<asp:RegularExpressionValidator ID="RegularExpressionValidator2" ControlToValidate="txt_Expected_Date_1"
                                                    Display="Dynamic" EnableClientScript="true" runat="server" ValidationExpression="^([0-9]{1,2})[./-]+([0-9]{1,2})[./-]+([0-9]{2}|[0-9]{4})$"
                                                    SetFocusOnError="true" ForeColor="Red">
                          Please enter date in mm/dd/yyyy format
                                                </asp:RegularExpressionValidator>--%>
                                            </div>
                                            <div style="width: 33%; float: left; min-height: 20px; text-align: left;">
                                                <b>AR Date Completed</b><br />
                                                <cc2:OboutTextBox runat="server" ID="txt_AR_Date_Completed_1" Width="80" FolderStyle="styles/premiere_blue/OboutTextBox"
                                                    Text='<%# Container.Value %>' /><obout:Calendar ID="Calendar5" runat="server" StyleFolder="Calendar/styles/expedia"
                                                        DatePickerMode="true" TextBoxId="txt_AR_Date_Completed_1" TextArrowLeft="" TextArrowRight=""
                                                        DatePickerSynchronize="true" DatePickerImagePath="Calendar/styles/icon2.gif" Align="Under"
                                                        DateFormat="MM/dd/yyyy" EnableViewState="true" AllowDeselect="false" />
                                                <asp:RegularExpressionValidator ID="RegularExpressionValidator5" ControlToValidate="txt_AR_Date_Completed_1"
                                                    Display="Dynamic" EnableClientScript="true" runat="server" ValidationExpression="^([0-9]{1,2})[./-]+([0-9]{1,2})[./-]+([0-9]{2}|[0-9]{4})$"
                                                    SetFocusOnError="true" ForeColor="Red">
                          Please enter date in mm/dd/yyyy format
                                                </asp:RegularExpressionValidator>
                                            </div>
                                            <div style="width: 33%; float: left; min-height: 20px; text-align: left;">
                                                <b>AR Assigned Name</b><br />
                                                <cc2:OboutTextBox runat="server" ID="txt_Assigned_Name_1" Width="150" FolderStyle="styles/premiere_blue/OboutTextBox" />
                                            </div>
                                            <div class="clearBoth width100percent floatLeft centertextalign margintop5pixel">
                                                <b>AR Admin Comments</b><br />                                                
                                                <asp:TextBox ID="txt_Admin_Comments_1" runat="server" Width="98%" Height="100px" TextMode="MultiLine" ></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class=" width100percent floatLeft margintop10pixel">
                                            <cc2:OboutTextBox ID="txt_Item_2" runat="server" Width="30"></cc2:OboutTextBox>&nbsp;<label>Item#2</label>&nbsp;&nbsp;&nbsp;<label class="fontbold">WHAT WAS AT RISK, AND WHY WAS THE AT-RISK PERFORMED?</label><br />
                                        </div>
                                        <div class=" width100percent floatLeft  centertextalign">
                                            <asp:TextBox runat="server" ID="txt_Item_Text_2" Width="98%" Height="100px" TextMode="MultiLine" ></asp:TextBox>
                                        </div>
                                        <div class=" width100percent floatLeft">
                                            <div class="width70percent floatLeft righttextalign padding2px">
                                                STEERING COMMITTEE FOLLOW-UP NEEDED:
                                            </div>
                                            <div class="width20percent floatLeft lefttextalign">
                                                <%--<asp:RadioButtonList onmousedown="getSelected(this);" onClick="unselectkRest(this);" RepeatDirection="Horizontal" ID="lst_FollowUp_Needed_2" runat="server">
                                                    <asp:ListItem Value="Y" Text="Yes"></asp:ListItem>
                                                </asp:RadioButtonList>--%>
                                                <cc2:OboutCheckBox ID="chk_FollowUp_Needed_2" runat="server" Text="Yes"></cc2:OboutCheckBox>
                                            </div>
                                        </div>
                                        <div style="clear: both; width: 100%; float: left; text-align: left; padding: 5px  0 15px 0; border-bottom: 1px solid grey;">
                                            <div style="width: 33%; float: left; min-height: 20px; text-align: left;">
                                                <b>AR Expected Date</b><br />
                                                <cc2:OboutTextBox runat="server" ID="txt_Expected_Date_2" Width="80" FolderStyle="styles/premiere_blue/OboutTextBox"
                                                    Text='<%# Container.Value %>' /><obout:Calendar ID="Calendar6" runat="server" StyleFolder="Calendar/styles/expedia"
                                                        DatePickerMode="true" TextBoxId="txt_Expected_Date_2" Align="Under"
                                                        DatePickerSynchronize="true" DatePickerImagePath="Calendar/styles/icon2.gif"
                                                        DateFormat="MM/dd/yyyy" EnableViewState="true" AllowDeselect="false" />
                                                <asp:RegularExpressionValidator ID="RegularExpressionValidator6" ControlToValidate="txt_Expected_Date_2"
                                                    Display="Dynamic" EnableClientScript="true" runat="server" ValidationExpression="^([0-9]{1,2})[./-]+([0-9]{1,2})[./-]+([0-9]{2}|[0-9]{4})$"
                                                    SetFocusOnError="true" ForeColor="Red">
                          Please enter date in mm/dd/yyyy format
                                                </asp:RegularExpressionValidator>
                                            </div>
                                            <div style="width: 33%; float: left; min-height: 20px; text-align: left;">
                                                <b>AR Date Completed</b><br />
                                                <cc2:OboutTextBox runat="server" ID="txt_AR_Date_Completed_2" Width="80" FolderStyle="styles/premiere_blue/OboutTextBox"
                                                    Text='<%# Container.Value %>' /><obout:Calendar ID="Calendar7" runat="server" StyleFolder="Calendar/styles/expedia"
                                                        DatePickerMode="true" TextBoxId="txt_AR_Date_Completed_2" TextArrowLeft="" TextArrowRight=""
                                                        DatePickerSynchronize="true" DatePickerImagePath="Calendar/styles/icon2.gif" Align="Under"
                                                        DateFormat="MM/dd/yyyy" EnableViewState="true" AllowDeselect="false" />
                                                <asp:RegularExpressionValidator ID="RegularExpressionValidator7" ControlToValidate="txt_AR_Date_Completed_2"
                                                    Display="Dynamic" EnableClientScript="true" runat="server" ValidationExpression="^([0-9]{1,2})[./-]+([0-9]{1,2})[./-]+([0-9]{2}|[0-9]{4})$"
                                                    SetFocusOnError="true" ForeColor="Red">
                          Please enter date in mm/dd/yyyy format
                                                </asp:RegularExpressionValidator>
                                            </div>
                                            <div style="width: 33%; float: left; min-height: 20px; text-align: left;">
                                                <b>AR Assigned Name</b><br />
                                                <cc2:OboutTextBox runat="server" ID="txt_Assigned_Name_2" Width="150" FolderStyle="styles/premiere_blue/OboutTextBox" />
                                            </div>
                                            <div class="clearBoth width100percent floatLeft centertextalign margintop5pixel">
                                                <b>AR Admin Comments</b><br />
                                                <asp:TextBox ID="txt_Admin_Comments_2" runat="server" Width="98%" Height="100px" TextMode="MultiLine"></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="width100percent floatLeft margintop10pixel">
                                            <cc2:OboutTextBox ID="txt_Item_3" runat="server" Width="30"></cc2:OboutTextBox>&nbsp;<label>Item#3</label>&nbsp;&nbsp;&nbsp;<label class="fontbold">WHAT WAS AT RISK, AND WHY WAS THE AT-RISK PERFORMED?</label><br />
                                        </div>
                                        <div class="width100percent floatLeft  centertextalign">
                                            <asp:TextBox runat="server" ID="txt_Item_Text_3" Width="98%" Height="100px" TextMode="MultiLine"></asp:TextBox>
                                        </div>
                                        <div class="width100percent floatLeft  centertextalign">
                                            <div class="width70percent floatLeft righttextalign padding2px">
                                                STEERING COMMITTEE FOLLOW-UP NEEDED:
                                            </div>
                                            <div class="width20percent floatLeft lefttextalign">
                                                <%-- <asp:RadioButtonList onmousedown="getSelected(this);" onClick="unselectkRest(this);" RepeatDirection="Horizontal" ID="lst_FollowUp_Needed_3" runat="server">
                                                    <asp:ListItem Value="Y" Text="Yes"></asp:ListItem>
                                                </asp:RadioButtonList>--%>
                                                <cc2:OboutCheckBox ID="chk_FollowUp_Needed_3" runat="server" Text="Yes"></cc2:OboutCheckBox>
                                            </div>
                                        </div>
                                        <div style="clear: both; width: 100%; float: left; text-align: left; padding: 5px  0 15px 0;">
                                            <div style="width: 33%; float: left; min-height: 20px; text-align: left;">
                                                <b>AR Expected Date</b><br />
                                                <cc2:OboutTextBox runat="server" ID="txt_Expected_Date_3" Width="80" FolderStyle="styles/premiere_blue/OboutTextBox"
                                                    Text='<%# Container.Value %>' /><obout:Calendar ID="Calendar8" runat="server" StyleFolder="Calendar/styles/expedia"
                                                        DatePickerMode="true" TextBoxId="txt_Expected_Date_3" Align="Under"
                                                        DatePickerSynchronize="true" DatePickerImagePath="Calendar/styles/icon2.gif"
                                                        DateFormat="MM/dd/yyyy" EnableViewState="true" AllowDeselect="false" />
                                                <asp:RegularExpressionValidator ID="RegularExpressionValidator8" ControlToValidate="txt_Expected_Date_3"
                                                    Display="Dynamic" EnableClientScript="true" runat="server" ValidationExpression="^([0-9]{1,2})[./-]+([0-9]{1,2})[./-]+([0-9]{2}|[0-9]{4})$"
                                                    SetFocusOnError="true" ForeColor="Red">
                          Please enter date in mm/dd/yyyy format
                                                </asp:RegularExpressionValidator>
                                            </div>
                                            <div style="width: 33%; float: left; min-height: 20px; text-align: left;">
                                                <b>AR Date Completed</b><br />
                                                <cc2:OboutTextBox runat="server" ID="txt_AR_Date_Completed_3" Width="80" FolderStyle="styles/premiere_blue/OboutTextBox"
                                                    Text='<%# Container.Value %>' /><obout:Calendar ID="Calendar9" runat="server" StyleFolder="Calendar/styles/expedia"
                                                        DatePickerMode="true" TextBoxId="txt_AR_Date_Completed_3" TextArrowLeft="" TextArrowRight=""
                                                        DatePickerSynchronize="true" DatePickerImagePath="Calendar/styles/icon2.gif" Align="Under"
                                                        DateFormat="MM/dd/yyyy" EnableViewState="true" AllowDeselect="false" />
                                                <asp:RegularExpressionValidator ID="RegularExpressionValidator9" ControlToValidate="txt_AR_Date_Completed_3"
                                                    Display="Dynamic" EnableClientScript="true" runat="server" ValidationExpression="^([0-9]{1,2})[./-]+([0-9]{1,2})[./-]+([0-9]{2}|[0-9]{4})$"
                                                    SetFocusOnError="true" ForeColor="Red">
                          Please enter date in mm/dd/yyyy format
                                                </asp:RegularExpressionValidator>
                                            </div>
                                            <div style="width: 33%; float: left; min-height: 20px; text-align: left;">
                                                <b>AR Assigned Name</b><br />
                                                <cc2:OboutTextBox runat="server" ID="txt_Assigned_Name_3" Width="150" FolderStyle="styles/premiere_blue/OboutTextBox" />
                                            </div>
                                            <div class="clearBoth width100percent floatLeft centertextalign margintop10pixel">
                                                <b>AR Admin Comments</b><br />
                                                <asp:TextBox ID="txt_Admin_Comments_3" runat="server" Width="98%" Height="100px" TextMode="MultiLine"></asp:TextBox>
                                            </div>
                                        </div>
                                    </fieldset>
                                </div>
                                <div style="float: left; width: auto; height: 10px; overflow: visible;">
                                    <fieldset style="width: auto; height: auto; background-color: #EBECEC; text-align: left;">
                                        <legend>Card Image: Back</legend>
                                        <asp:Image ID="CardImageBack" runat="server" />
                                    </fieldset>
                                </div>
                            </div>
                        </div>
                        <input type="hidden" id="hdn_A1" />
                        <input type="hidden" id="hdn_A2" />
                        <input type="hidden" id="hdn_A3" />
                        <input type="hidden" id="hdn_A4" />
                        <input type="hidden" id="hdn_B1" />
                        <input type="hidden" id="hdn_B2" />
                        <input type="hidden" id="hdn_B3" />
                        <input type="hidden" id="hdn_B4" />
                        <input type="hidden" id="hdn_B5" />
                        <input type="hidden" id="hdn_B6" />
                        <input type="hidden" id="hdn_C1" />
                        <input type="hidden" id="hdn_C2" />
                        <input type="hidden" id="hdn_C3" />
                        <input type="hidden" id="hdn_C4" />
                        <input type="hidden" id="hdn_C5" />
                        <input type="hidden" id="hdn_C6" />
                        <input type="hidden" id="hdn_C7" />
                        <input type="hidden" id="hdn_C8" />
                        <input type="hidden" id="hdn_D1" />
                        <input type="hidden" id="hdn_D2" />
                        <input type="hidden" id="hdn_D3" />
                        <input type="hidden" id="hdn_D4" />
                        <input type="hidden" id="hdn_D5" />
                        <input type="hidden" id="hdn_D6" />
                        <input type="hidden" id="hdn_D7" />
                        <input type="hidden" id="hdn_E1" />
                        <input type="hidden" id="hdn_E2" />
                        <input type="hidden" id="hdn_E3" />
                        <input type="hidden" id="hdn_E4" />
                        <input type="hidden" id="hdn_F1" />
                        <input type="hidden" id="hdn_F2" />
                        <input type="hidden" id="hdn_F3" />
                        <input type="hidden" id="hdn_F4" />
                        <input type="hidden" id="hdn_F5" />
                        <input type="hidden" id="hdn_G1" />
                        <input type="hidden" id="hdn_G2" />
                        <input type="hidden" id="hdn_G3" />
                        <input type="hidden" id="hdn_H1" />
                        <input type="hidden" id="hdn_H2" />
                        <input type="hidden" id="hdn_H3" />
                        <input type="hidden" id="hdn_H4" />
                        <input type="hidden" id="hdn_H5" />
                        <input type="hidden" id="hdn_H6" />
                        <input type="hidden" id="hdn_H7" />
                        <input type="hidden" id="hdn_H8" />
                        <input type="hidden" id="hdn_J1" />
                        <input type="hidden" id="hdn_J2" />
                        <input type="hidden" id="hdn_K1" />
                        <input type="hidden" id="hdn_Shift" />
                        <input type="hidden" id="hdn_FollowUp_Needed_1" />
                        <input type="hidden" id="hdn_FollowUp_Needed_2" />
                        <input type="hidden" id="hdn_FollowUp_Needed_3" />
                        <input type="hidden" id="hdn_Operations" />
                        <input type="hidden" id="hdn_Observation_Type" />
                        <input type="hidden" id="hdn_Safe_AtRisk_Card" />
                        <input type="hidden" id='hdnSelectedIndex' />
                        <asp:SqlDataSource ID="SqlDataSourceLocation" runat="server" ConnectionString="<%$ ConnectionStrings:pjengConnectionString1 %>"
                            ProviderName="<%$ ConnectionStrings:pjengConnectionString1.ProviderName %>"
                            SelectCommandType="StoredProcedure" SelectCommand="sp_JWT_GetCustomersLocationByUGIDByAreaWithTwoPartKey">
                            <SelectParameters>
                                <asp:QueryStringParameter Name="UGID" Type="String" QueryStringField="aff_key" />
                                <asp:QueryStringParameter Name="SId" Type="String" QueryStringField="sid" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                        <%-- <asp:SqlDataSource ID="SqlDataSourceArea" runat="server" ConnectionString="<%$ ConnectionStrings:pjengConnectionString1 %>"
                            ProviderName="<%$ ConnectionStrings:pjengConnectionString1.ProviderName %>"
                            SelectCommandType="StoredProcedure" SelectCommand="sp_JWT_GetCustomersAreaByUGID">
                            <SelectParameters>
                                <asp:QueryStringParameter Name="UGID" Type="String" QueryStringField="aff_key" />
                                <asp:QueryStringParameter Name="SId" Type="String" QueryStringField="sid" />
                            </SelectParameters>
                        </asp:SqlDataSource>--%>
                        <asp:SqlDataSource ID="SqlDataSourceEmployee" runat="server" ConnectionString="<%$ ConnectionStrings:pjengConnectionString1 %>"
                            ProviderName="<%$ ConnectionStrings:pjengConnectionString1.ProviderName %>"
                            SelectCommandType="StoredProcedure" SelectCommand="sp_JWT_GetCustomersEmployeeByUGIDByAreaWithTwoPartKey">
                            <SelectParameters>
                                <asp:QueryStringParameter Name="UGID" Type="String" QueryStringField="aff_key" />
                                <asp:QueryStringParameter Name="SId" Type="String" QueryStringField="sid" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                        <asp:SqlDataSource ID="SqlDataSourceCompany" runat="server" ConnectionString="<%$ ConnectionStrings:pjengConnectionString1 %>"
                            ProviderName="<%$ ConnectionStrings:pjengConnectionString1.ProviderName %>"
                            SelectCommandType="StoredProcedure" SelectCommand="sp_JWT_GetCustomersCompanyByUGIDByAreaWithTwoPartKey">
                            <SelectParameters>
                                <asp:QueryStringParameter Name="UGID" Type="String" QueryStringField="aff_key" />
                                <asp:QueryStringParameter Name="SId" Type="String" QueryStringField="sid" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </Template>
                </cc1:GridTemplate>
                <cc1:GridTemplate runat="server" ID="tplImageURL">
                    <Template>
                        <span style="width: 50px;"><a href="<%# GetFullUrl(Container.DataItem["image_url"].ToString()) %>"
                            target="_blank">Form Image</a></span>
                    </Template>
                </cc1:GridTemplate>
                <cc1:GridTemplate runat="server" ID="Template1">
                    <Template>
                        <span>
                            <%# Container.Value %></span>
                    </Template>
                </cc1:GridTemplate>
            </Templates>
        </cc1:Grid>
        <%--I'll create the sqldatasources when i get back. To much to detail to provide --%>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:pjengConnectionString1 %>"
            ProviderName="<%$ ConnectionStrings:pjengConnectionString1.ProviderName %>" SelectCommandType="StoredProcedure"
            SelectCommand="Fine_ReportUsageDetail">
            <SelectParameters>
                <asp:QueryStringParameter Name="affiliate_key" QueryStringField="aff_key" Type="String" />
                <asp:QueryStringParameter Name="r_type" QueryStringField="rtype" Type="String" DefaultValue="1" />
                <asp:QueryStringParameter Name="start_date" QueryStringField="date1" Type="DateTime" DefaultValue="" />
                <asp:QueryStringParameter Name="end_date" QueryStringField="date2" Type="DateTime" DefaultValue="" />
                <asp:QueryStringParameter Name="course_id" QueryStringField="cid" Type="Int32" DefaultValue="0" />
                <asp:Parameter Name="allChild" Type="Int16" DefaultValue="1" />
                <asp:QueryStringParameter Name="sid" QueryStringField="sid" Type="String" DefaultValue="" />
                <asp:Parameter Name="smart_key" Type="String" DefaultValue="none" />
                <asp:Parameter Name="Express" Type="Int16" DefaultValue="0" />
                <asp:QueryStringParameter Name="filter" QueryStringField="report_filter" Type="String" DefaultValue="  " />
                <asp:QueryStringParameter Name="filter_value" QueryStringField="report_filter_term" Type="String" DefaultValue="  " />
		<asp:QueryStringParameter Name="DateType" QueryStringField="dt" Type="String" DefaultValue="1" />
            </SelectParameters>
        </asp:SqlDataSource>
    </form>
</body>
</html>