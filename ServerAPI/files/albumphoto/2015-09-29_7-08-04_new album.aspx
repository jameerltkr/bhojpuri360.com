<%@ Page Language="C#" Debug="true" ValidateRequest="false" MaintainScrollPositionOnPostback="True" %>

<%@ Register Assembly="obout_Grid_NET" Namespace="Obout.Grid" TagPrefix="cc1" %>
<%@ Register Assembly="obout_Interface" Namespace="Obout.Interface" TagPrefix="cc2" %>
<%@ Register Assembly="obout_Calendar2_Net" Namespace="OboutInc.Calendar2" TagPrefix="obout" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Configuration" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script type="text/javascript">
    String.prototype.trim = function () {
        return this.replace(/^\s+|\s+$/g, '');
    }

    window.onload = function () {
        var date = new Date();
        var day = date.getDate();        // yields day
        var month = date.getMonth() + 1;    // yields month
        var year = date.getFullYear();  // yields year
        var hour = date.getHours();     // yields hours 
        var minute = date.getMinutes(); // yields minutes
        var second = date.getSeconds(); // yields seconds

        var newDate;
        var dateType = getParameterByName('df');

        if (dateType == '1') {
            newDate = ("0" + day).slice(-2) + "/" + ("0" + month).slice(-2) + "/" + year;
        }
        else {
            newDate = ("0" + month).slice(-2) + "/" + ("0" + day).slice(-2) + "/" + year;
        }

        txtDate.value(newDate);
        document.getElementById('hdnDateTime').value = newDate;

        var time = month + "/" + day + "/" + year + " " + hour + ':' + minute + ':' + second;

        document.getElementById('hdnTimeOffSet').value = time;

        //fills drop downs
        document.getElementById('hdnAreaID').value = ddl_FKAreaID.options[ddl_FKAreaID.selectedIndex()].value;

        PageMethods.GetLocations(document.getElementById('hdnAreaID').value, onLocationsLoaded, onLocationsLoadedError);
        PageMethods.GetEmployees(document.getElementById('hdnAreaID').value, onEmployeesLoaded, onEmployeesLoadedError);
        PageMethods.GetCompanys(document.getElementById('hdnAreaID').value, onCompanysLoaded, onCompanysLoadedError);
    }

    function getParameterByName(name) {
        name = name.replace(/[\[]/, "\\[").replace(/[\]]/, "\\]");
        var regex = new RegExp("[\\?&]" + name + "=([^&#]*)"),
            results = regex.exec(location.search);
        return results === null ? "" : decodeURIComponent(results[1].replace(/\+/g, " "));
    }

    //function OnBeforeUpdate() {
    //    document.getElementById("hdnAreaID").value = GetSelectedValueFromDropDown("ddl_FKAreaID");
    //    document.getElementById("hdnLocationID").value = GetSelectedValueFromDropDown("ddl_FKLocationID");
    //    document.getElementById("hdnEmployeeID").value = GetSelectedValueFromDropDown("ddl_FKEmployeeID");
    //    document.getElementById("hdnCompanyID").value = GetSelectedValueFromDropDown("ddl_FKCompanyID");
    //}

    function loadPlantSubItems(sender, index) {
        document.getElementById('hdnAreaID').value = sender.value();

        PageMethods.GetLocations(sender.value(), onLocationsLoaded, onLocationsLoadedError);
        PageMethods.GetEmployees(sender.value(), onEmployeesLoaded, onEmployeesLoadedError);
        PageMethods.GetCompanys(sender.value(), onCompanysLoaded, onCompanysLoadedError);
    }

    function onLocationsLoaded(locations) {
        ddl_FKLocationID.options.clear();
        for (var i = 0; i < locations.length; i++) {
            ddl_FKLocationID.options.add(locations[i].Text, locations[i].Value);

            if (locations[i].Text == 'Blank (blk)') {
                document.getElementById('hdnLocationsBlankID').value = locations[i].Value;
            }
        }

        document.getElementById('hdnLocationID').value = document.getElementById('hdnLocationsBlankID').value;
        PassValueDatatoDropDown('ddl_FKLocationID', document.getElementById('hdnLocationsBlankID').value);
    }

    function onLocationsLoadedError() {
        alert('There was an error loading the Locations drop-down list!');
    }

    function onEmployeesLoaded(employees) {
        ddl_FKEmployee1ID.options.clear();
        ddl_FKEmployee2ID.options.clear();
        for (var i = 0; i < employees.length; i++) {
            ddl_FKEmployee1ID.options.add(employees[i].Text, employees[i].Value);
            ddl_FKEmployee2ID.options.add(employees[i].Text, employees[i].Value);

            if (employees[i].Text == 'Blank (blk)') {
                document.getElementById('hdnEmployeesBlankID').value = employees[i].Value;
            }
        }

        document.getElementById('hdnEmployeeID').value = document.getElementById('hdnEmployeesBlankID').value;
        PassValueDatatoDropDown('ddl_FKEmployee1ID', document.getElementById('hdnEmployeesBlankID').value);
        PassValueDatatoDropDown('ddl_FKEmployee2ID', document.getElementById('hdnEmployeesBlankID').value);
    }

    function onEmployeesLoadedError() {
        alert('There was an error loading the Employees drop-down list!');
    }

    function onCompanysLoaded(companys) {
        ddl_FKCompany1ID.options.clear();
        ddl_FKCompany2ID.options.clear();
        for (var i = 0; i < companys.length; i++) {
            ddl_FKCompany1ID.options.add(companys[i].Text, companys[i].Value);
            ddl_FKCompany2ID.options.add(companys[i].Text, companys[i].Value);

            if (companys[i].Text == 'Blank (blk)') {
                document.getElementById('hdnCompanysBlankID').value = companys[i].Value;
            }
        }

        document.getElementById('hdnCompanyID').value = document.getElementById('hdnCompanysBlankID').value;
        PassValueDatatoDropDown('ddl_FKCompany1ID', document.getElementById('hdnCompanysBlankID').value);
        PassValueDatatoDropDown('ddl_FKCompany2ID', document.getElementById('hdnCompanysBlankID').value);
    }

    function onCompanysLoadedError() {
        alert('There was an error loading the Companys drop-down list!');
    }

    function PassValueDatatoDropDown(ddlId, desiredValue) {
        var Dropdownid = eval(ddlId);

        for (var i = 0; i < Dropdownid.options.length; i++) {
            if (Dropdownid.options[i].value.toLowerCase() == desiredValue.toLowerCase()) {
                Dropdownid.selectedIndex(i);
                //  Dropdownid.SelectedIndex = i;
                break;
            }
        }
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
    void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            string sId = Request.QueryString["sid"] != null ? Request.QueryString["sid"] : string.Empty;
            string smartKey = string.Empty;

            System.Data.SqlClient.SqlConnection con = new System.Data.SqlClient.SqlConnection(System.Web.Configuration.WebConfigurationManager.ConnectionStrings["pjengConnectionString1"].ToString());
            System.Data.SqlClient.SqlCommand storedProcCommand = new System.Data.SqlClient.SqlCommand("sp_JWT_GetCustomersSmartKeyBySID", con);
            storedProcCommand.CommandType = System.Data.CommandType.StoredProcedure;
            storedProcCommand.Parameters.AddWithValue("@SId", sId);

            try
            {
                con.Open();
                System.Data.SqlClient.SqlDataReader reader = storedProcCommand.ExecuteReader();

                while (reader.Read())
                {
                    smartKey = reader["Smart_key"].ToString();
                }


                if (!string.IsNullOrEmpty(smartKey))
                {
                    int pipeIndex = -1;

                    pipeIndex = smartKey.IndexOf('|');

                    if (pipeIndex > -1)
                    {
                        smartKey = smartKey.Substring(0, pipeIndex);

                        if (smartKey != "^")
                        {
                            ddl_FKAreaID.DataBind();
                            ddl_FKAreaID.SelectedValue = smartKey;
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                string temp = ex.ToString();
            }
            finally
            {
                con.Close();
            }

            //assigns date format
            if (Request.QueryString["df"] != null)
            {
                if (Request.QueryString["df"].ToString().Trim() == "1")
                {
                    Calendar2.DateFormat = "dd/MM/yyyy";
                }
                else
                {
                    Calendar2.DateFormat = "MM/dd/yyyy";
                }
            }
            else
            {
                Calendar2.DateFormat = "MM/dd/yyyy";
            }

            //set drop down list values to blank
            //  ddl_FKLocationID.SelectedValue = "935";
            //  ddl_FKEmployeeID.SelectedValue = "586";
        }
    }

    void Button1_Click(object sender, EventArgs e)
    {
        string action_Item_Status = string.Empty;
        string SqlQuery = "";
        //Create Sql connection
        SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["pjengConnectionString1"].ConnectionString);
        SqlQuery = @"insert into JWT_Lyondell_Safety_Obs( Image_URL,Image_Files,SC_ID,Date,EditedBy,Shift,Scan_Date,FKAreaID,FKLocationID,FKEmployeeID1,FKCompanyID1,FKEmployeeID2,FKCompanyID2,Name_of_Company_on_Form,Operations,Observation_Type,Safe_AtRisk_Card,A1,A2,A3,A4,B1,B2,B3,B4,B5,B6,C1,C2,C3,C4,C5,C6,C7,C8,D1,D2,D3,D4,D5,D6,D7,E1,E2,E3,E4,F1,F2,F3,F4,F5,G1,G2,G3,H1,H2,H3,H4,H5,H6,H7,H8,J1,Item_1,FollowUp_Needed_1,Item_Text_1,Item_2,FollowUp_Needed_2,Item_Text_2,Item_3,FollowUp_Needed_3,Item_Text_3,Name_Sup,FollowUp_Needed_Merge,Created,Item_Merge,Action_Item_Status)";
        SqlQuery += "values(@Image_URL,@Image_Files,@SC_ID,@Date,@EditedBy,@Shift,@Scan_Date,@FKAreaID,@FKLocationID,@FKEmployeeID1,@FKCompanyID1,@FKEmployeeID2,@FKCompanyID2,@Name_of_Company_on_Form,@Operations,@Observation_Type,@Safe_AtRisk_Card,@A1,@A2,@A3,@A4,@B1,@B2,@B3,@B4,@B5,@B6,@C1,@C2,@C3,@C4,@C5,@C6,@C7,@C8,@D1,@D2,@D3,@D4,@D5,@D6,@D7,@E1,@E2,@E3,@E4,@F1,@F2,@F3,@F4,@F5,@G1,@G2,@G3,@H1,@H2,@H3,@H4,@H5,@H6,@H7,@H8,@J1,@Item_1,@FollowUp_Needed_1,@Item_Text_1,@Item_2,@FollowUp_Needed_2,@Item_Text_2,@Item_3,@FollowUp_Needed_3,@Item_Text_3,@Name_Sup,@FollowUp_Needed_Merge,@Created,@Item_Merge,(CASE WHEN @FollowUp_Needed_1='Y' OR @FollowUp_Needed_2='Y' OR @FollowUp_Needed_3='Y' THEN 'Open' ELSE CASE WHEN RTRIM(@Item_Text_1)<>'' OR RTRIM(@Item_Text_2)<>'' OR RTRIM(@Item_Text_3)<>'' THEN 'Commented' ELSE '' END END))";

        SqlCommand comm = new SqlCommand(SqlQuery, conn);
        comm.CommandType = CommandType.Text;

        comm.Parameters.Add("@Image_Files", System.Data.SqlDbType.VarChar);                     //Image File 
        comm.Parameters["@Image_Files"].Value = "Web";

        comm.Parameters.Add("@Image_URL", System.Data.SqlDbType.VarChar);                     //Image File 
        comm.Parameters["@Image_URL"].Value = "";

        comm.Parameters.Add("@SC_ID", System.Data.SqlDbType.VarChar);                          //SC_ID  
        comm.Parameters["@SC_ID"].Value = "Web";

        comm.Parameters.Add("@Date", System.Data.SqlDbType.VarChar);                           //Date  
        comm.Parameters["@Date"].Value = txtDate.Text;

        comm.Parameters.Add("@Scan_Date", System.Data.SqlDbType.Date);
        comm.Parameters["@Scan_Date"].Value = Convert.ToDateTime(hdnTimeOffSet.Value);

        //        comm.Parameters.Add("@Observer_Number", System.Data.SqlDbType.VarChar);             //Observer_Number  
        //        comm.Parameters["@Observer_Number"].Value = txt_Observer_Number.Text;


        comm.Parameters.Add("@Shift", System.Data.SqlDbType.VarChar);                      //shift  
        int cnt = 0;
        for (int i = 0; i < lst_Shift.Items.Count; i++)
        {
            if (lst_Shift.Items[i].Selected)
            {
                comm.Parameters["@Shift"].Value = lst_Shift.Items[i].Value;
                cnt++;
            }
        }
        if (cnt == 0)
            comm.Parameters["@Shift"].Value = "";


        comm.Parameters.Add("@FKAreaID", System.Data.SqlDbType.VarChar);                           //Date  
        comm.Parameters["@FKAreaID"].Value = ddl_FKAreaID.SelectedValue; ;

        comm.Parameters.Add("@FKLocationID", System.Data.SqlDbType.VarChar);                           //Date  
        comm.Parameters["@FKLocationID"].Value = ddl_FKLocationID.SelectedValue;
        comm.Parameters.Add("@FKEmployeeID1", System.Data.SqlDbType.VarChar);                           //Date  
        comm.Parameters["@FKEmployeeID1"].Value = ddl_FKEmployee1ID.SelectedValue;
        comm.Parameters.Add("@FKCompanyID1", System.Data.SqlDbType.VarChar);                           //Date  
        comm.Parameters["@FKCompanyID1"].Value = ddl_FKCompany1ID.SelectedValue;
        comm.Parameters.Add("@FKEmployeeID2", System.Data.SqlDbType.VarChar);                           //Date  
        comm.Parameters["@FKEmployeeID2"].Value = ddl_FKEmployee2ID.SelectedValue;

        comm.Parameters.Add("@FKCompanyID2", System.Data.SqlDbType.VarChar);                           //Date  
        comm.Parameters["@FKCompanyID2"].Value = ddl_FKCompany2ID.SelectedValue;

        comm.Parameters.Add("@Name_of_Company_on_Form", System.Data.SqlDbType.VarChar);                           //Date  
        comm.Parameters["@Name_of_Company_on_Form"].Value = txt_Name_of_Company_on_Form.Text;




        comm.Parameters.Add("@Operations", System.Data.SqlDbType.VarChar);                       //operation Type
        int cnt1 = 0;
        for (int i = 0; i < lst_Operations.Items.Count; i++)
        {
            if (lst_Operations.Items[i].Selected == true)
            {
                comm.Parameters["@Operations"].Value = lst_Operations.Items[i].Value;
                cnt1++;
            }
        }
        if (cnt1 == 0)
            comm.Parameters["@Operations"].Value = "";

        comm.Parameters.Add("@Observation_Type", System.Data.SqlDbType.VarChar);                       //Employee Type

        for (int i = 0; i < lst_Observation_Type.Items.Count; i++)
        {
            if (lst_Observation_Type.Items[i].Selected == true)
            {
                comm.Parameters["@Observation_Type"].Value = lst_Observation_Type.Items[i].Value;
                cnt1++;
            }
        }
        if (cnt1 == 0)
            comm.Parameters["@Observation_Type"].Value = "";


        comm.Parameters.Add("@Safe_AtRisk_Card", System.Data.SqlDbType.VarChar);              //Safe_At_Risk_Card 

        string safeAR = "S";

        if (lst_A1.Items[1].Selected)
        { safeAR = "AR"; }
        else if (lst_A1.Items[1].Selected)
        { safeAR = "AR"; }
        else if (lst_A2.Items[1].Selected)
        { safeAR = "AR"; }
        else if (lst_A3.Items[1].Selected)
        { safeAR = "AR"; }
        else if (lst_A4.Items[1].Selected)
        { safeAR = "AR"; }
        else if (lst_B1.Items[1].Selected)
        { safeAR = "AR"; }
        else if (lst_B2.Items[1].Selected)
        { safeAR = "AR"; }
        else if (lst_B3.Items[1].Selected)
        { safeAR = "AR"; }
        else if (lst_B4.Items[1].Selected)
        { safeAR = "AR"; }
        else if (lst_B5.Items[1].Selected)
        { safeAR = "AR"; }
        else if (lst_B6.Items[1].Selected)
        { safeAR = "AR"; }
        else if (lst_C1.Items[1].Selected)
        { safeAR = "AR"; }
        else if (lst_C2.Items[1].Selected)
        { safeAR = "AR"; }
        else if (lst_C3.Items[1].Selected)
        { safeAR = "AR"; }
        else if (lst_C4.Items[1].Selected)
        { safeAR = "AR"; }
        else if (lst_C5.Items[1].Selected)
        { safeAR = "AR"; }
        else if (lst_C6.Items[1].Selected)
        { safeAR = "AR"; }
        else if (lst_C7.Items[1].Selected)
        { safeAR = "AR"; }
        else if (lst_C8.Items[1].Selected)
        { safeAR = "AR"; }
        else if (lst_D1.Items[1].Selected)
        { safeAR = "AR"; }
        else if (lst_D2.Items[1].Selected)
        { safeAR = "AR"; }
        else if (lst_D3.Items[1].Selected)
        { safeAR = "AR"; }
        else if (lst_D4.Items[1].Selected)
        { safeAR = "AR"; }
        else if (lst_D5.Items[1].Selected)
        { safeAR = "AR"; }
        else if (lst_D6.Items[1].Selected)
        { safeAR = "AR"; }
        else if (lst_D7.Items[1].Selected)
        { safeAR = "AR"; }
        else if (lst_E1.Items[1].Selected)
        { safeAR = "AR"; }
        else if (lst_E2.Items[1].Selected)
        { safeAR = "AR"; }
        else if (lst_E3.Items[1].Selected)
        { safeAR = "AR"; }
        else if (lst_E4.Items[1].Selected)
        { safeAR = "AR"; }
        else if (lst_F1.Items[1].Selected)
        { safeAR = "AR"; }
        else if (lst_F2.Items[1].Selected)
        { safeAR = "AR"; }
        else if (lst_F3.Items[1].Selected)
        { safeAR = "AR"; }
        else if (lst_F4.Items[1].Selected)
        { safeAR = "AR"; }
        else if (lst_F5.Items[1].Selected)
        { safeAR = "AR"; }
        else if (lst_G1.Items[1].Selected)
        { safeAR = "AR"; }
        else if (lst_G2.Items[1].Selected)
        { safeAR = "AR"; }
        else if (lst_G3.Items[1].Selected)
        { safeAR = "AR"; }
        else if (lst_H1.Items[1].Selected)
        { safeAR = "AR"; }
        else if (lst_H2.Items[1].Selected)
        { safeAR = "AR"; }
        else if (lst_H3.Items[1].Selected)
        { safeAR = "AR"; }
        else if (lst_H4.Items[1].Selected)
        { safeAR = "AR"; }
        else if (lst_H5.Items[1].Selected)
        { safeAR = "AR"; }
        else if (lst_H6.Items[1].Selected)
        { safeAR = "AR"; }
        else if (lst_H7.Items[1].Selected)
        { safeAR = "AR"; }
        else if (lst_H8.Items[1].Selected)
        { safeAR = "AR"; }
        else if (lst_J1.Items[1].Selected)
        { safeAR = "AR"; }
        comm.Parameters["@Safe_AtRisk_Card"].Value = safeAR;



        comm.Parameters.Add("@A1", System.Data.SqlDbType.VarChar);
        if (lst_A1.Items[0].Selected)
        { comm.Parameters["@A1"].Value = "S"; }
        else if (lst_A1.Items[1].Selected)
        { comm.Parameters["@A1"].Value = "AR"; }
        else if (lst_A1.Items[2].Selected)
        { comm.Parameters["@A1"].Value = "xx"; }
        else
        { comm.Parameters["@A1"].Value = string.Empty; }
        comm.Parameters.Add("@A2", System.Data.SqlDbType.VarChar);
        if (lst_A2.Items[0].Selected)
        { comm.Parameters["@A2"].Value = "S"; }
        else if (lst_A2.Items[1].Selected)
        { comm.Parameters["@A2"].Value = "AR"; }
        else if (lst_A2.Items[2].Selected)
        { comm.Parameters["@A2"].Value = "xx"; }
        else
        { comm.Parameters["@A2"].Value = string.Empty; }
        comm.Parameters.Add("@A3", System.Data.SqlDbType.VarChar);
        if (lst_A3.Items[0].Selected)
        { comm.Parameters["@A3"].Value = "S"; }
        else if (lst_A3.Items[1].Selected)
        { comm.Parameters["@A3"].Value = "AR"; }
        else if (lst_A3.Items[2].Selected)
        { comm.Parameters["@A3"].Value = "xx"; }
        else
        { comm.Parameters["@A3"].Value = string.Empty; }
        comm.Parameters.Add("@A4", System.Data.SqlDbType.VarChar);
        if (lst_A4.Items[0].Selected)
        { comm.Parameters["@A4"].Value = "S"; }
        else if (lst_A4.Items[1].Selected)
        { comm.Parameters["@A4"].Value = "AR"; }
        else if (lst_A4.Items[2].Selected)
        { comm.Parameters["@A4"].Value = "xx"; }
        else
        { comm.Parameters["@A4"].Value = string.Empty; }
        comm.Parameters.Add("@B1", System.Data.SqlDbType.VarChar);
        if (lst_B1.Items[0].Selected)
        { comm.Parameters["@B1"].Value = "S"; }
        else if (lst_B1.Items[1].Selected)
        { comm.Parameters["@B1"].Value = "AR"; }
        else if (lst_B1.Items[2].Selected)
        { comm.Parameters["@B1"].Value = "xx"; }
        else
        { comm.Parameters["@B1"].Value = string.Empty; }
        comm.Parameters.Add("@B2", System.Data.SqlDbType.VarChar);
        if (lst_B2.Items[0].Selected)
        { comm.Parameters["@B2"].Value = "S"; }
        else if (lst_B2.Items[1].Selected)
        { comm.Parameters["@B2"].Value = "AR"; }
        else if (lst_B2.Items[2].Selected)
        { comm.Parameters["@B2"].Value = "xx"; }
        else
        { comm.Parameters["@B2"].Value = string.Empty; }
        comm.Parameters.Add("@B3", System.Data.SqlDbType.VarChar);
        if (lst_B3.Items[0].Selected)
        { comm.Parameters["@B3"].Value = "S"; }
        else if (lst_B3.Items[1].Selected)
        { comm.Parameters["@B3"].Value = "AR"; }
        else if (lst_B3.Items[2].Selected)
        { comm.Parameters["@B3"].Value = "xx"; }
        else
        { comm.Parameters["@B3"].Value = string.Empty; }
        comm.Parameters.Add("@B4", System.Data.SqlDbType.VarChar);
        if (lst_B4.Items[0].Selected)
        { comm.Parameters["@B4"].Value = "S"; }
        else if (lst_B4.Items[1].Selected)
        { comm.Parameters["@B4"].Value = "AR"; }
        else if (lst_B4.Items[2].Selected)
        { comm.Parameters["@B4"].Value = "xx"; }
        else
        { comm.Parameters["@B4"].Value = string.Empty; }
        comm.Parameters.Add("@B5", System.Data.SqlDbType.VarChar);
        if (lst_B5.Items[0].Selected)
        { comm.Parameters["@B5"].Value = "S"; }
        else if (lst_B5.Items[1].Selected)
        { comm.Parameters["@B5"].Value = "AR"; }
        else if (lst_B5.Items[2].Selected)
        { comm.Parameters["@B5"].Value = "xx"; }
        else
        { comm.Parameters["@B5"].Value = string.Empty; }
        comm.Parameters.Add("@B6", System.Data.SqlDbType.VarChar);
        if (lst_B6.Items[0].Selected)
        { comm.Parameters["@B6"].Value = "S"; }
        else if (lst_B6.Items[1].Selected)
        { comm.Parameters["@B6"].Value = "AR"; }
        else if (lst_B6.Items[2].Selected)
        { comm.Parameters["@B6"].Value = "xx"; }
        else
        { comm.Parameters["@B6"].Value = string.Empty; }
        comm.Parameters.Add("@C1", System.Data.SqlDbType.VarChar);
        if (lst_C1.Items[0].Selected)
        { comm.Parameters["@C1"].Value = "S"; }
        else if (lst_C1.Items[1].Selected)
        { comm.Parameters["@C1"].Value = "AR"; }
        else if (lst_C1.Items[2].Selected)
        { comm.Parameters["@C1"].Value = "xx"; }
        else
        { comm.Parameters["@C1"].Value = string.Empty; }
        comm.Parameters.Add("@C2", System.Data.SqlDbType.VarChar);
        if (lst_C2.Items[0].Selected)
        { comm.Parameters["@C2"].Value = "S"; }
        else if (lst_C2.Items[1].Selected)
        { comm.Parameters["@C2"].Value = "AR"; }
        else if (lst_C2.Items[2].Selected)
        { comm.Parameters["@C2"].Value = "xx"; }
        else
        { comm.Parameters["@C2"].Value = string.Empty; }
        comm.Parameters.Add("@C3", System.Data.SqlDbType.VarChar);
        if (lst_C3.Items[0].Selected)
        { comm.Parameters["@C3"].Value = "S"; }
        else if (lst_C3.Items[1].Selected)
        { comm.Parameters["@C3"].Value = "AR"; }
        else if (lst_C3.Items[2].Selected)
        { comm.Parameters["@C3"].Value = "xx"; }
        else
        { comm.Parameters["@C3"].Value = string.Empty; }
        comm.Parameters.Add("@C4", System.Data.SqlDbType.VarChar);
        if (lst_C4.Items[0].Selected)
        { comm.Parameters["@C4"].Value = "S"; }
        else if (lst_C4.Items[1].Selected)
        { comm.Parameters["@C4"].Value = "AR"; }
        else if (lst_C4.Items[2].Selected)
        { comm.Parameters["@C4"].Value = "xx"; }
        else
        { comm.Parameters["@C4"].Value = string.Empty; }
        comm.Parameters.Add("@C5", System.Data.SqlDbType.VarChar);
        if (lst_C5.Items[0].Selected)
        { comm.Parameters["@C5"].Value = "S"; }
        else if (lst_C5.Items[1].Selected)
        { comm.Parameters["@C5"].Value = "AR"; }
        else if (lst_C5.Items[2].Selected)
        { comm.Parameters["@C5"].Value = "xx"; }
        else
        { comm.Parameters["@C5"].Value = string.Empty; }
        comm.Parameters.Add("@C6", System.Data.SqlDbType.VarChar);
        if (lst_C6.Items[0].Selected)
        { comm.Parameters["@C6"].Value = "S"; }
        else if (lst_C6.Items[1].Selected)
        { comm.Parameters["@C6"].Value = "AR"; }
        else if (lst_C6.Items[2].Selected)
        { comm.Parameters["@C6"].Value = "xx"; }
        else
        { comm.Parameters["@C6"].Value = string.Empty; }
        comm.Parameters.Add("@C7", System.Data.SqlDbType.VarChar);
        if (lst_C7.Items[0].Selected)
        { comm.Parameters["@C7"].Value = "S"; }
        else if (lst_C7.Items[1].Selected)
        { comm.Parameters["@C7"].Value = "AR"; }
        else if (lst_C7.Items[2].Selected)
        { comm.Parameters["@C7"].Value = "xx"; }
        else
        { comm.Parameters["@C7"].Value = string.Empty; }
        comm.Parameters.Add("@C8", System.Data.SqlDbType.VarChar);
        if (lst_C8.Items[0].Selected)
        { comm.Parameters["@C8"].Value = "S"; }
        else if (lst_C8.Items[1].Selected)
        { comm.Parameters["@C8"].Value = "AR"; }
        else if (lst_C8.Items[2].Selected)
        { comm.Parameters["@C8"].Value = "xx"; }
        else
        { comm.Parameters["@C8"].Value = string.Empty; }
        comm.Parameters.Add("@D1", System.Data.SqlDbType.VarChar);
        if (lst_D1.Items[0].Selected)
        { comm.Parameters["@D1"].Value = "S"; }
        else if (lst_D1.Items[1].Selected)
        { comm.Parameters["@D1"].Value = "AR"; }
        else if (lst_D1.Items[2].Selected)
        { comm.Parameters["@D1"].Value = "xx"; }
        else
        { comm.Parameters["@D1"].Value = string.Empty; }
        comm.Parameters.Add("@D2", System.Data.SqlDbType.VarChar);
        if (lst_D2.Items[0].Selected)
        { comm.Parameters["@D2"].Value = "S"; }
        else if (lst_D2.Items[1].Selected)
        { comm.Parameters["@D2"].Value = "AR"; }
        else if (lst_D2.Items[2].Selected)
        { comm.Parameters["@D2"].Value = "xx"; }
        else
        { comm.Parameters["@D2"].Value = string.Empty; }
        comm.Parameters.Add("@D3", System.Data.SqlDbType.VarChar);
        if (lst_D3.Items[0].Selected)
        { comm.Parameters["@D3"].Value = "S"; }
        else if (lst_D3.Items[1].Selected)
        { comm.Parameters["@D3"].Value = "AR"; }
        else if (lst_D3.Items[2].Selected)
        { comm.Parameters["@D3"].Value = "xx"; }
        else
        { comm.Parameters["@D3"].Value = string.Empty; }
        comm.Parameters.Add("@D4", System.Data.SqlDbType.VarChar);
        if (lst_D4.Items[0].Selected)
        { comm.Parameters["@D4"].Value = "S"; }
        else if (lst_D4.Items[1].Selected)
        { comm.Parameters["@D4"].Value = "AR"; }
        else if (lst_D4.Items[2].Selected)
        { comm.Parameters["@D4"].Value = "xx"; }
        else
        { comm.Parameters["@D4"].Value = string.Empty; }
        comm.Parameters.Add("@D5", System.Data.SqlDbType.VarChar);
        if (lst_D5.Items[0].Selected)
        { comm.Parameters["@D5"].Value = "S"; }
        else if (lst_D5.Items[1].Selected)
        { comm.Parameters["@D5"].Value = "AR"; }
        else if (lst_D5.Items[2].Selected)
        { comm.Parameters["@D5"].Value = "xx"; }
        else
        { comm.Parameters["@D5"].Value = string.Empty; }
        comm.Parameters.Add("@D6", System.Data.SqlDbType.VarChar);
        if (lst_D6.Items[0].Selected)
        { comm.Parameters["@D6"].Value = "S"; }
        else if (lst_D6.Items[1].Selected)
        { comm.Parameters["@D6"].Value = "AR"; }
        else if (lst_D6.Items[2].Selected)
        { comm.Parameters["@D6"].Value = "xx"; }
        else
        { comm.Parameters["@D6"].Value = string.Empty; }
        comm.Parameters.Add("@D7", System.Data.SqlDbType.VarChar);
        if (lst_D7.Items[0].Selected)
        { comm.Parameters["@D7"].Value = "S"; }
        else if (lst_D7.Items[1].Selected)
        { comm.Parameters["@D7"].Value = "AR"; }
        else if (lst_D7.Items[2].Selected)
        { comm.Parameters["@D7"].Value = "xx"; }
        else
        { comm.Parameters["@D7"].Value = string.Empty; }
        comm.Parameters.Add("@E1", System.Data.SqlDbType.VarChar);
        if (lst_E1.Items[0].Selected)
        { comm.Parameters["@E1"].Value = "S"; }
        else if (lst_E1.Items[1].Selected)
        { comm.Parameters["@E1"].Value = "AR"; }
        else if (lst_E1.Items[2].Selected)
        { comm.Parameters["@E1"].Value = "xx"; }
        else
        { comm.Parameters["@E1"].Value = string.Empty; }
        comm.Parameters.Add("@E2", System.Data.SqlDbType.VarChar);
        if (lst_E2.Items[0].Selected)
        { comm.Parameters["@E2"].Value = "S"; }
        else if (lst_E2.Items[1].Selected)
        { comm.Parameters["@E2"].Value = "AR"; }
        else if (lst_E2.Items[2].Selected)
        { comm.Parameters["@E2"].Value = "xx"; }
        else
        { comm.Parameters["@E2"].Value = string.Empty; }
        comm.Parameters.Add("@E3", System.Data.SqlDbType.VarChar);
        if (lst_E3.Items[0].Selected)
        { comm.Parameters["@E3"].Value = "S"; }
        else if (lst_E3.Items[1].Selected)
        { comm.Parameters["@E3"].Value = "AR"; }
        else if (lst_E3.Items[2].Selected)
        { comm.Parameters["@E3"].Value = "xx"; }
        else
        { comm.Parameters["@E3"].Value = string.Empty; }
        comm.Parameters.Add("@E4", System.Data.SqlDbType.VarChar);
        if (lst_E4.Items[0].Selected)
        { comm.Parameters["@E4"].Value = "S"; }
        else if (lst_E4.Items[1].Selected)
        { comm.Parameters["@E4"].Value = "AR"; }
        else if (lst_E4.Items[2].Selected)
        { comm.Parameters["@E4"].Value = "xx"; }
        else
        { comm.Parameters["@E4"].Value = string.Empty; }
        comm.Parameters.Add("@F1", System.Data.SqlDbType.VarChar);
        if (lst_F1.Items[0].Selected)
        { comm.Parameters["@F1"].Value = "S"; }
        else if (lst_F1.Items[1].Selected)
        { comm.Parameters["@F1"].Value = "AR"; }
        else if (lst_F1.Items[2].Selected)
        { comm.Parameters["@F1"].Value = "xx"; }
        else
        { comm.Parameters["@F1"].Value = string.Empty; }
        comm.Parameters.Add("@F2", System.Data.SqlDbType.VarChar);
        if (lst_F2.Items[0].Selected)
        { comm.Parameters["@F2"].Value = "S"; }
        else if (lst_F2.Items[1].Selected)
        { comm.Parameters["@F2"].Value = "AR"; }
        else if (lst_F2.Items[2].Selected)
        { comm.Parameters["@F2"].Value = "xx"; }
        else
        { comm.Parameters["@F2"].Value = string.Empty; }
        comm.Parameters.Add("@F3", System.Data.SqlDbType.VarChar);
        if (lst_F3.Items[0].Selected)
        { comm.Parameters["@F3"].Value = "S"; }
        else if (lst_F3.Items[1].Selected)
        { comm.Parameters["@F3"].Value = "AR"; }
        else if (lst_F3.Items[2].Selected)
        { comm.Parameters["@F3"].Value = "xx"; }
        else
        { comm.Parameters["@F3"].Value = string.Empty; }
        comm.Parameters.Add("@F4", System.Data.SqlDbType.VarChar);
        if (lst_F4.Items[0].Selected)
        { comm.Parameters["@F4"].Value = "S"; }
        else if (lst_F4.Items[1].Selected)
        { comm.Parameters["@F4"].Value = "AR"; }
        else if (lst_F4.Items[2].Selected)
        { comm.Parameters["@F4"].Value = "xx"; }
        else
        { comm.Parameters["@F4"].Value = string.Empty; }
        comm.Parameters.Add("@F5", System.Data.SqlDbType.VarChar);
        if (lst_F5.Items[0].Selected)
        { comm.Parameters["@F5"].Value = "S"; }
        else if (lst_F5.Items[1].Selected)
        { comm.Parameters["@F5"].Value = "AR"; }
        else if (lst_F5.Items[2].Selected)
        { comm.Parameters["@F5"].Value = "xx"; }
        else
        { comm.Parameters["@F5"].Value = string.Empty; }
        comm.Parameters.Add("@G1", System.Data.SqlDbType.VarChar);
        if (lst_G1.Items[0].Selected)
        { comm.Parameters["@G1"].Value = "S"; }
        else if (lst_G1.Items[1].Selected)
        { comm.Parameters["@G1"].Value = "AR"; }
        else if (lst_G1.Items[2].Selected)
        { comm.Parameters["@G1"].Value = "xx"; }
        else
        { comm.Parameters["@G1"].Value = string.Empty; }
        comm.Parameters.Add("@G2", System.Data.SqlDbType.VarChar);
        if (lst_G2.Items[0].Selected)
        { comm.Parameters["@G2"].Value = "S"; }
        else if (lst_G2.Items[1].Selected)
        { comm.Parameters["@G2"].Value = "AR"; }
        else if (lst_G2.Items[2].Selected)
        { comm.Parameters["@G2"].Value = "xx"; }
        else
        { comm.Parameters["@G2"].Value = string.Empty; }
        comm.Parameters.Add("@G3", System.Data.SqlDbType.VarChar);
        if (lst_G3.Items[0].Selected)
        { comm.Parameters["@G3"].Value = "S"; }
        else if (lst_G3.Items[1].Selected)
        { comm.Parameters["@G3"].Value = "AR"; }
        else if (lst_G3.Items[2].Selected)
        { comm.Parameters["@G3"].Value = "xx"; }
        else
        { comm.Parameters["@G3"].Value = string.Empty; }
        comm.Parameters.Add("@H1", System.Data.SqlDbType.VarChar);
        if (lst_H1.Items[0].Selected)
        { comm.Parameters["@H1"].Value = "S"; }
        else if (lst_H1.Items[1].Selected)
        { comm.Parameters["@H1"].Value = "AR"; }
        else if (lst_H1.Items[2].Selected)
        { comm.Parameters["@H1"].Value = "xx"; }
        else
        { comm.Parameters["@H1"].Value = string.Empty; }
        comm.Parameters.Add("@H2", System.Data.SqlDbType.VarChar);
        if (lst_H2.Items[0].Selected)
        { comm.Parameters["@H2"].Value = "S"; }
        else if (lst_H2.Items[1].Selected)
        { comm.Parameters["@H2"].Value = "AR"; }
        else if (lst_H2.Items[2].Selected)
        { comm.Parameters["@H2"].Value = "xx"; }
        else
        { comm.Parameters["@H2"].Value = string.Empty; }
        comm.Parameters.Add("@H3", System.Data.SqlDbType.VarChar);
        if (lst_H3.Items[0].Selected)
        { comm.Parameters["@H3"].Value = "S"; }
        else if (lst_H3.Items[1].Selected)
        { comm.Parameters["@H3"].Value = "AR"; }
        else if (lst_H3.Items[2].Selected)
        { comm.Parameters["@H3"].Value = "xx"; }
        else
        { comm.Parameters["@H3"].Value = string.Empty; }
        comm.Parameters.Add("@H4", System.Data.SqlDbType.VarChar);
        if (lst_H4.Items[0].Selected)
        { comm.Parameters["@H4"].Value = "S"; }
        else if (lst_H4.Items[1].Selected)
        { comm.Parameters["@H4"].Value = "AR"; }
        else if (lst_H4.Items[2].Selected)
        { comm.Parameters["@H4"].Value = "xx"; }
        else
        { comm.Parameters["@H4"].Value = string.Empty; }
        comm.Parameters.Add("@H5", System.Data.SqlDbType.VarChar);
        if (lst_H5.Items[0].Selected)
        { comm.Parameters["@H5"].Value = "S"; }
        else if (lst_H5.Items[1].Selected)
        { comm.Parameters["@H5"].Value = "AR"; }
        else if (lst_H5.Items[2].Selected)
        { comm.Parameters["@H5"].Value = "xx"; }
        else
        { comm.Parameters["@H5"].Value = string.Empty; }
        comm.Parameters.Add("@H6", System.Data.SqlDbType.VarChar);
        if (lst_H6.Items[0].Selected)
        { comm.Parameters["@H6"].Value = "S"; }
        else if (lst_H6.Items[1].Selected)
        { comm.Parameters["@H6"].Value = "AR"; }
        else if (lst_H6.Items[2].Selected)
        { comm.Parameters["@H6"].Value = "xx"; }
        else
        { comm.Parameters["@H6"].Value = string.Empty; }
        comm.Parameters.Add("@H7", System.Data.SqlDbType.VarChar);
        if (lst_H7.Items[0].Selected)
        { comm.Parameters["@H7"].Value = "S"; }
        else if (lst_H7.Items[1].Selected)
        { comm.Parameters["@H7"].Value = "AR"; }
        else if (lst_H7.Items[2].Selected)
        { comm.Parameters["@H7"].Value = "xx"; }
        else
        { comm.Parameters["@H7"].Value = string.Empty; }
        comm.Parameters.Add("@H8", System.Data.SqlDbType.VarChar);
        if (lst_H8.Items[0].Selected)
        { comm.Parameters["@H8"].Value = "S"; }
        else if (lst_H8.Items[1].Selected)
        { comm.Parameters["@H8"].Value = "AR"; }
        else if (lst_H8.Items[2].Selected)
        { comm.Parameters["@H8"].Value = "xx"; }
        else
        { comm.Parameters["@H8"].Value = string.Empty; }
        comm.Parameters.Add("@J1", System.Data.SqlDbType.VarChar);
        if (lst_J1.Items[0].Selected)
        { comm.Parameters["@J1"].Value = "S"; }
        else if (lst_J1.Items[1].Selected)
        { comm.Parameters["@J1"].Value = "AR"; }
        else if (lst_J1.Items[2].Selected)
        { comm.Parameters["@J1"].Value = "xx"; }
        else
        { comm.Parameters["@J1"].Value = string.Empty; }


        comm.Parameters.Add("@Item_1", System.Data.SqlDbType.VarChar);
        comm.Parameters["@Item_1"].Value = txt_Item_1.Text;
        comm.Parameters.Add("@Item_Text_1", System.Data.SqlDbType.VarChar);
        comm.Parameters["@Item_Text_1"].Value = txt_Item_Text_1.Text;

        comm.Parameters.Add("@FollowUp_Needed_1", System.Data.SqlDbType.VarChar);
        if (chk_FollowUp_Needed_1.Checked)
        { comm.Parameters["@FollowUp_Needed_1"].Value = "Y"; }
        else
        { comm.Parameters["@FollowUp_Needed_1"].Value = string.Empty; }

        comm.Parameters.Add("@Item_2", System.Data.SqlDbType.VarChar);
        comm.Parameters["@Item_2"].Value = txt_Item_2.Text;
        comm.Parameters.Add("@Item_Text_2", System.Data.SqlDbType.VarChar);
        comm.Parameters["@Item_Text_2"].Value = txt_Item_Text_2.Text;

        comm.Parameters.Add("@FollowUp_Needed_2", System.Data.SqlDbType.VarChar);
        if (chk_FollowUp_Needed_2.Checked)
        { comm.Parameters["@FollowUp_Needed_2"].Value = "Y"; }
        else
        { comm.Parameters["@FollowUp_Needed_2"].Value = string.Empty; }

        comm.Parameters.Add("@Item_3", System.Data.SqlDbType.VarChar);
        comm.Parameters["@Item_3"].Value = txt_Item_3.Text;
        comm.Parameters.Add("@Item_Text_3", System.Data.SqlDbType.VarChar);
        comm.Parameters["@Item_Text_3"].Value = txt_Item_Text_3.Text;

        comm.Parameters.Add("@FollowUp_Needed_3", System.Data.SqlDbType.VarChar);
        if (chk_FollowUp_Needed_3.Checked)
        { comm.Parameters["@FollowUp_Needed_3"].Value = "Y"; }
        else
        { comm.Parameters["@FollowUp_Needed_3"].Value = string.Empty; }

        comm.Parameters.Add("@Name_Sup", System.Data.SqlDbType.VarChar);
        comm.Parameters["@Name_Sup"].Value = "";

        if (!(chk_FollowUp_Needed_1.Checked == false && chk_FollowUp_Needed_2.Checked == false && chk_FollowUp_Needed_2.Checked == false))
        {
            comm.Parameters.AddWithValue("@FollowUp_Needed_Merge", comm.Parameters["@FollowUp_Needed_1"].Value.ToString() + comm.Parameters["@FollowUp_Needed_1"].Value.ToString().Trim() == string.Empty ? string.Empty : ", " + comm.Parameters["@FollowUp_Needed_1"].Value.ToString().Trim() == string.Empty && comm.Parameters["@FollowUp_Needed_2"].Value.ToString().Trim() == string.Empty ? string.Empty : ", " + comm.Parameters["@FollowUp_Needed_3"].Value.ToString());
        }
        else
        {
            comm.Parameters.AddWithValue("@FollowUp_Needed_Merge", string.Empty);
        }



        comm.Parameters.Add("@Item_Merge", System.Data.SqlDbType.VarChar);
        comm.Parameters["@Item_Merge"].Value = txt_Item_1.Text + txt_Item_1.Text.Trim() == string.Empty ? string.Empty : ", " + txt_Item_1.Text.Trim() == string.Empty && txt_Item_2.Text.Trim() == string.Empty ? string.Empty : ", " + txt_Item_3.Text;



        comm.Parameters.Add("@EditedBy", System.Data.SqlDbType.VarChar);
        comm.Parameters["@EditedBy"].Value = "";

        comm.Parameters.Add("@Created", System.Data.SqlDbType.DateTime);
        comm.Parameters["@Created"].Value = DateTime.Now;



        comm.Parameters.Add("@Inserted_By", System.Data.SqlDbType.VarChar);
        comm.Parameters["@Inserted_By"].Value = Request.QueryString["u"] != null ? Request.QueryString["u"] : string.Empty;

        try
        {
            conn.Open();
            comm.ExecuteNonQuery();
            conn.Close();

            //Clear Controls
            ClearControls();

        }
        catch (Exception ex)
        {
            string temp = ex.ToString();
        }
    }

    void Clear_Click(object sender, EventArgs e)
    {
        ClearControls();
    }

    void ClearControls()
    {
        ddl_FKLocationID.SelectedIndex = -1;
        ddl_FKCompany1ID.SelectedIndex = -1;
        ddl_FKCompany2ID.SelectedIndex = -1;
        ddl_FKEmployee1ID.SelectedIndex = -1;
        ddl_FKEmployee2ID.SelectedIndex = -1;
        txt_Name_of_Company_on_Form.Text = string.Empty;
        lst_Operations.SelectedIndex = -1;
        lst_Observation_Type.SelectedIndex = -1;
        lst_A1.SelectedIndex = -1;
        lst_A2.SelectedIndex = -1;
        lst_A3.SelectedIndex = -1;
        lst_A4.SelectedIndex = -1;
        lst_B1.SelectedIndex = -1;
        lst_B2.SelectedIndex = -1;
        lst_B3.SelectedIndex = -1;
        lst_B4.SelectedIndex = -1;
        lst_B5.SelectedIndex = -1;
        lst_B6.SelectedIndex = -1;
        lst_C1.SelectedIndex = -1;
        lst_C2.SelectedIndex = -1;
        lst_C3.SelectedIndex = -1;
        lst_C4.SelectedIndex = -1;
        lst_C5.SelectedIndex = -1;
        lst_C6.SelectedIndex = -1;
        lst_C7.SelectedIndex = -1;
        lst_C8.SelectedIndex = -1;
        lst_D1.SelectedIndex = -1;
        lst_D2.SelectedIndex = -1;
        lst_D3.SelectedIndex = -1;
        lst_D4.SelectedIndex = -1;
        lst_D5.SelectedIndex = -1;
        lst_D6.SelectedIndex = -1;
        lst_D7.SelectedIndex = -1;
        lst_E1.SelectedIndex = -1;
        lst_E2.SelectedIndex = -1;
        lst_E3.SelectedIndex = -1;
        lst_E4.SelectedIndex = -1;
        lst_F1.SelectedIndex = -1;
        lst_F2.SelectedIndex = -1;
        lst_F3.SelectedIndex = -1;
        lst_F4.SelectedIndex = -1;
        lst_F5.SelectedIndex = -1;
        lst_G1.SelectedIndex = -1;
        lst_G2.SelectedIndex = -1;
        lst_G3.SelectedIndex = -1;
        lst_H1.SelectedIndex = -1;
        lst_H2.SelectedIndex = -1;
        lst_H3.SelectedIndex = -1;
        lst_H4.SelectedIndex = -1;
        lst_H5.SelectedIndex = -1;
        lst_H6.SelectedIndex = -1;
        lst_H7.SelectedIndex = -1;
        lst_H8.SelectedIndex = -1;
        lst_J1.SelectedIndex = -1;
        lst_Shift.SelectedIndex = -1;

        txt_Item_1.Text = string.Empty;
        txt_Item_Text_1.Text = string.Empty;
        chk_FollowUp_Needed_1.Checked = false;
        txt_Item_2.Text = string.Empty;
        txt_Item_Text_2.Text = string.Empty;
        chk_FollowUp_Needed_2.Checked = false;
        txt_Item_3.Text = string.Empty;
        txt_Item_Text_3.Text = string.Empty;
        chk_FollowUp_Needed_3.Checked = false;


    }

    private static int IndexOfNth(string str, char c, int n)
    {
        int s = -1;

        for (int i = 0; i < n; i++)
        {
            s = str.IndexOf(c, s + 1);

            if (s == -1) break;
        }

        return s;
    }


    protected void btnLogout_Click(object sender, EventArgs e)
    {
        Response.Redirect("http://www.etracker5.com/ConocoPhillips");
    }

    [System.Web.Services.WebMethod()]
    [System.Web.Script.Services.ScriptMethod()]
    public static List<ListItem> GetLocations(int plant)
    {
        List<ListItem> locations = new List<ListItem>();
        System.Data.SqlClient.SqlConnection con = new System.Data.SqlClient.SqlConnection(System.Web.Configuration.WebConfigurationManager.ConnectionStrings["pjengConnectionString1"].ToString());

        if (plant > 0)
        {
            System.Data.SqlClient.SqlCommand storedProcCommand = new System.Data.SqlClient.SqlCommand("sp_JWT_GetCustomersLocationByUGIDBySingleAreaAsParam", con);
            storedProcCommand.CommandType = System.Data.CommandType.StoredProcedure;
            storedProcCommand.Parameters.AddWithValue("@UGID", "1EE1CP7N");
            storedProcCommand.Parameters.AddWithValue("@AreaID", plant);

            try
            {
                con.Open();
                System.Data.SqlClient.SqlDataReader reader = storedProcCommand.ExecuteReader();
                while (reader.Read())
                {
                    locations.Add(new ListItem(reader["Name_Code_Combo"].ToString(), reader["PKLocationID"].ToString()));
                }
            }
            catch (Exception ex)
            {
                string temp = ex.ToString();
            }
            finally
            {
                con.Close();
            }
        }

        return locations;
    }

    [System.Web.Services.WebMethod()]
    [System.Web.Script.Services.ScriptMethod()]
    public static List<ListItem> GetEmployees(int plant)
    {
        List<ListItem> employees = new List<ListItem>();
        System.Data.SqlClient.SqlConnection con = new System.Data.SqlClient.SqlConnection(System.Web.Configuration.WebConfigurationManager.ConnectionStrings["pjengConnectionString1"].ToString());

        if (plant > 0)
        {
            System.Data.SqlClient.SqlCommand storedProcCommand = new System.Data.SqlClient.SqlCommand("sp_JWT_GetCustomersEmployeeByUGIDBySingleAreaAsParam", con);
            storedProcCommand.CommandType = System.Data.CommandType.StoredProcedure;
            storedProcCommand.Parameters.AddWithValue("@UGID", "1EE1CP7N");
            storedProcCommand.Parameters.AddWithValue("@AreaID", plant);

            try
            {
                con.Open();
                System.Data.SqlClient.SqlDataReader reader = storedProcCommand.ExecuteReader();
                while (reader.Read())
                {
                    employees.Add(new ListItem(reader["Name_Code_Combo"].ToString(), reader["PKEmployeeID"].ToString()));
                }
            }
            catch (Exception ex)
            {
                string temp = ex.ToString();
            }
            finally
            {
                con.Close();
            }
        }

        return employees;
    }

    [System.Web.Services.WebMethod()]
    [System.Web.Script.Services.ScriptMethod()]
    public static List<ListItem> GetCompanys(int plant)
    {
        List<ListItem> companys = new List<ListItem>();
        System.Data.SqlClient.SqlConnection con = new System.Data.SqlClient.SqlConnection(System.Web.Configuration.WebConfigurationManager.ConnectionStrings["pjengConnectionString1"].ToString());

        if (plant > 0)
        {
            System.Data.SqlClient.SqlCommand storedProcCommand = new System.Data.SqlClient.SqlCommand("sp_JWT_GetCustomersCompanyByUGIDBySingleAreaAsParam", con);
            storedProcCommand.CommandType = System.Data.CommandType.StoredProcedure;
            storedProcCommand.Parameters.AddWithValue("@UGID", "1EE1CP7N");
            storedProcCommand.Parameters.AddWithValue("@AreaID", plant);

            try
            {
                con.Open();
                System.Data.SqlClient.SqlDataReader reader = storedProcCommand.ExecuteReader();
                while (reader.Read())
                {
                    companys.Add(new ListItem(reader["Name_Code_Combo"].ToString(), reader["PKCompanyID"].ToString()));
                }
            }
            catch (Exception ex)
            {
                string temp = ex.ToString();
            }
            finally
            {
                con.Close();
            }
        }

        return companys;
    }
</script>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Saftey Observation Form</title>
    <link href="Styles/premiere_blue/style.css" rel="stylesheet" />
    <link href="Calendar/styles/expedia/style.css" rel="stylesheet" />
    <style type="text/css">
        html, body, form
        {
            height: 96%;
            font-family: arial, helvetica, sans-serif;
            font-size: 12px;
            padding: 0;
            margin: 5px;
            background-color: #CCCCCC;
        }
        
        .main
        {
            background-color: #EBECEC;
        }
        
        .maindiv
        {
            background-color: #EBECEC;
            color: #666666;
            width: 100%;
            float: left;
        }
        
        .verticalLine
        {
            border-left: 1px solid black;
            float: left;
        }
        
        .leftdiv
        {
            float: left;
            width: 585px;
        }
        
        .margintop15pixel
        {
            margin-top: 15px;
        }
        
        .margintop10pixel
        {
            margin-top: 10px;
        }
        
        .margintop5pixel
        {
            margin-top: 5px;
        }
        
        .width50percent
        {
            width: 50%;
            float: left;
        }
        
        .width55percent
        {
            width: 55%;
            float: left;
        }
        
        .width60percent
        {
            width: 55%;
            float: left;
            padding: 0 0 0 10px;
        }
        
        .width60percentNoPad
        {
            width: 60%;
            float: left;
        }
        
        .width40percent
        {
            width: 40%;
            float: left;
        }
        
        .width10percent
        {
            width: 10%;
            float: left;
        }
        
        .width15percent
        {
            width: 15%;
            float: left;
        }
        
        .width20percent
        {
            width: 20%;
            float: left;
        }
        
        .width25percent
        {
            width: 25%;
            float: left;
        }
        
        .width5percent
        {
            width: 5%;
            float: left;
        }
        
        .width30percent
        {
            width: 30%;
            float: left;
        }
        
        .width32percent
        {
            width: 32%;
            float: left;
        }
        
        .width35percent
        {
            width: 35%;
            float: left;
        }
        
        .width100percent
        {
            width: 100%;
            float: left;
        }
        
        .height50pixel
        {
            height: 30px;
        }
        
        .floatleft
        {
            float: left;
        }
        
        .fontbold
        {
            font-weight: bold;
        }
        
        .lefttextalign
        {
            text-align: left;
        }
        
        .righttextalign
        {
            text-align: right;
        }
        
        .centertextalign
        {
            text-align: center;
        }
        
        .fontsizelarge
        {
            font-size: medium;
        }
        
        .linespace
        {
            height: 40px;
            width: 100%;
        }
        
        .smalllinespace
        {
            height: 10px;
            width: 100%;
        }
        
        .radiobuttonlistcatch
        {
            display: block;
        }
        
        .padding2px
        {
            padding: 2px;
        }
        
        .HorizontalLine
        {
            border-bottom: 3px solid black;
            float: left;
        }
        
        .customStyle1
        {
            position: absolute !important;
            left: 0px !important;
            top: 0px !important;
        }
        
        .Horizentalline
        {
            border-top: 4px solid black;
            float: left;
        }
        
        .width58percent
        {
            width: 58%;
            float: left;
        }
        
        .marginright5pixel
        {
            margin-right: 5px;
        }
        
        .margintop3pixel
        {
            margin-top: 3px;
        }
        
        /*kamal*/
        
        .container_01
        {
            width: 467px;
            float: left;
            display: block;
            margin: 5px 0 0px 10px;
            text-align: left;
        }
        
        .button01
        {
            border-radius: 0px !important;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="true">
    </asp:ScriptManager>
    <div style="width: 100%; text-align: center">
        <center>
            <div style="width: 960px;">
                <div class="width100percent main" id="mains" style="width: 101%; background-color: #cccccc !important;">
                    <div class="maindiv" style="width: 477px; height: 1140px; float: left; display: block;
                        background: #fff; border: solid #999 1px; padding: 0 0 10px 0;">
                        <div class="leftdiv" style="width: 477px; margin: 2px 0 0 10px; height: 30px;">
                            <div style="width: 130px; float: left; display: block; background: #fff;">
                                <a id="A1" runat="server" href="#"></a>
                                <asp:Image ID="Image1" runat="server" ImageUrl="~/Images/lyondell_logo.gif" Width="116px"
                                    Height="29px" />
                            </div>
                            <div style="width: 215px; float: left; display: block; background: #fff;">
                                <h3 style="margin: 12px 0 0 8px;">
                                    Saftey Observation Form</h3>
                            </div>
                            <div style="width: 120px; float: left; display: block; background: #fff; text-align: right;">
                                <%--<asp:Button ID="btnLogout" runat="server" Text="Log Out" Width="90px" Height="30px"
                        Font-Bold="true" />--%>
                            </div>
                        </div>
                        <div class="width100percent" style="width: 467px; float: left; display: block; margin: 10px 0 5px 10px;">
                            <div class="width50percent floatLeft lefttextalign ">
                                <div class="width100percent floatLeft lefttextalign ">
                                    <div class="width100percent floatLeft lefttextalign ">
                                        <label class="fontbold">
                                            Date</label><br />
                                        <cc2:OboutTextBox runat="server" ID="txtDate" Width="80px" /><obout:Calendar ID="Calendar2"
                                            runat="server" StyleFolder="Calendar/styles/expedia" DatePickerMode="true" TextBoxId="txtDate"
                                            TextArrowLeft="" TextArrowRight="" DatePickerSynchronize="true" DatePickerImagePath="Calendar/styles/icon2.gif"
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
                                </div>
                                <div class="width100percent floatLeft lefttextalign " style="padding-top: 2px">
                                    <label class="fontbold">
                                        Location</label><br />
                                    <cc2:OboutDropDownList ID="ddl_FKLocationID" Width="215" runat="server" DataTextField="Name_Code_Combo"
                                        DataValueField="PKLocationID" Height="400px">
                                    </cc2:OboutDropDownList>
                                </div>
                                <div class="width100percent floatLeft lefttextalign " style="padding-top: 2px">
                                    <label class="fontbold">
                                        Observer ID</label><br />
                                    <cc2:OboutDropDownList ID="ddl_FKEmployee1ID" Width="215" runat="server" DataTextField="Name_Code_Combo"
                                        DataValueField="PKEmployeeID" Height="400px">
                                    </cc2:OboutDropDownList>
                                </div>
                                <div class="width100percent floatLeft lefttextalign " style="padding-top: 2px">
                                    <label class="fontbold">
                                        Observers Company Code</label><br />
                                    <cc2:OboutDropDownList ID="ddl_FKCompany1ID" Width="215" runat="server" DataTextField="Name_Code_Combo"
                                        DataValueField="PKCompanyID" Height="400px">
                                    </cc2:OboutDropDownList>
                                </div>
                                <div class="width100percent floatLeft lefttextalign " style="padding-top: 2px">
                                    <label class="fontbold">
                                        Coach ID</label><br />
                                    <cc2:OboutDropDownList ID="ddl_FKEmployee2ID" Width="215" runat="server" DataTextField="Name_Code_Combo"
                                        DataValueField="PKEmployeeID" Height="400px">
                                    </cc2:OboutDropDownList>
                                </div>
                                <div class="width100percent floatLeft lefttextalign " style="padding-top: 2px">
                                    <label class="fontbold">
                                        Observed Company Code</label><br />
                                    <cc2:OboutDropDownList ID="ddl_FKCompany2ID" Width="215" runat="server" DataTextField="Name_Code_Combo"
                                        DataValueField="PKCompanyID" Height="400px">
                                    </cc2:OboutDropDownList>
                                </div>
                                <div class="width100percent floatLeft lefttextalign " style="padding-top: 2px">
                                    <label class="fontbold">
                                        Plant</label><br />
                                    <cc2:OboutDropDownList ID="ddl_FKAreaID" Width="215" runat="server" DataSourceID="SqlDataSourceArea"
                                        DataTextField="Name_Code_Combo" DataValueField="PKAreaID" Height="400px" Enabled="false">
                                        <ClientSideEvents OnSelectedIndexChanged="loadPlantSubItems" />
                                    </cc2:OboutDropDownList>
                                </div>
                                <%--  <div class="width100percent floatLeft lefttextalign ">
                                    <div class="width30percent floatLeft lefttextalign">
                                    </div>
                                    <div class="width70percent  righttextalign">
                                    </div>
                                </div>
                                <div class="width100percent floatLeft lefttextalign " style="margin-top: 10px">
                                    <div class="width30percent floatLeft lefttextalign">
                                    </div>
                                    <div class="width70percent righttextalign">
                                    </div>
                                </div>
                                <div class="width100percent floatLeft lefttextalign" style="margin-top: 10px">
                                </div>--%>
                            </div>
                            <div class="width50percent floatLeft lefttextalign ">
                                <div class="width100percent floatLeft lefttextalign ">
                                    <div class="width100percent floatLeft lefttextalign ">
                                        <asp:RadioButtonList onmousedown="getSelected(this);" Width="95%" onClick="unselectkRest(this);"
                                            Font-Size="12px" Font-Bold="true" Style="vertical-align: top" RepeatDirection="Horizontal"
                                            ID="lst_Shift" runat="server">
                                            <asp:ListItem Value="Day" Text="Day Shift&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"></asp:ListItem>
                                            <asp:ListItem Value="Night" Text="Night Shift&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"></asp:ListItem>
                                        </asp:RadioButtonList>
                                        <div style="width: 215px; margin: 5px;" class="Horizentalline">
                                        </div>
                                    </div>
                                </div>
                                <div class="width100percent floatleft lefttextalign">
                                    <asp:RadioButtonList onmousedown="getSelected(this);" RepeatColumns="2" onClick="unselectkRest(this);"
                                        Font-Size="12px" Font-Bold="true" Style="vertical-align: top" RepeatDirection="Horizontal"
                                        ID="lst_Operations" runat="server">
                                        <asp:ListItem Value="Normal" Text="Normal&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"></asp:ListItem>
                                        <asp:ListItem Value="Turnaround" Text="Turnaround&nbsp;&nbsp;&nbsp;&nbsp;"></asp:ListItem>
                                        <asp:ListItem Value="Changeover" Text="Changeover&nbsp;&nbsp;&nbsp;&nbsp;"></asp:ListItem>
                                        <asp:ListItem Value="Project" Text="Project&nbsp;&nbsp;&nbsp;"></asp:ListItem>
                                    </asp:RadioButtonList>
                                    <div style="width: 215px; margin: 5px;" class="Horizentalline">
                                    </div>
                                </div>
                                <div class="width100percent floatleft lefttextalign">
                                    <asp:RadioButtonList onmousedown="getSelected(this);" onClick="unselectkRest(this);"
                                        Font-Size="12px" Font-Bold="true" Style="vertical-align: top" RepeatColumns="2"
                                        RepeatDirection="Horizontal" ID="lst_Observation_Type" runat="server">
                                        <asp:ListItem Value="Coached" Text="Coached&nbsp;&nbsp;&nbsp;"></asp:ListItem>
                                        <asp:ListItem Value="Shutdown" Text="Shutdown&nbsp;&nbsp;&nbsp;&nbsp;"></asp:ListItem>
                                        <asp:ListItem Value="Self" Text="Self Observed&nbsp;"></asp:ListItem>
                                        <asp:ListItem Value="Startup" Text="Startup&nbsp;"></asp:ListItem>
                                        <asp:ListItem Value="Cross" Text="Cross&nbsp;&nbsp;&nbsp;&nbsp;"></asp:ListItem>
                                    </asp:RadioButtonList>
                                </div>
                                <div class="width100percent marginright10pixel lefttextalign floatleft" style="margin-top: 10px">
                                    <label class="fontbold">
                                        Company Name</label><br />
                                    <cc2:OboutTextBox runat="server" ID="txt_Name_of_Company_on_Form" FolderStyle="styles/premiere_blue/OboutTextBox"
                                        Width="200" />
                                </div>
                            </div>
                        </div>
                        <div class="width100percent margintop10pixel" style="width: 467px; float: left; display: block;
                            margin: 5px 0 5px 10px;">
                            <div class="width60percentNoPad floatLeft lefttextalign">
                            </div>
                        </div>
                        <div class="Horizentalline" style="width: 467px; margin: 5px;">
                        </div>
                        <div class=" container_01 margintop10pixel lefttextalign">
                            <div class="width50percent  fontbold">
                                <div class="width10percent">
                                    A
                                </div>
                                <div class="width30percent centertextalign">
                                    <div class="width32percent">
                                        S
                                    </div>
                                    <div class="width32percent">
                                        AR
                                    </div>
                                </div>
                                <div class="width60percent lefttextalign">
                                    FOCUS FACTOR
                                </div>
                            </div>
                            <div class="width50percent  fontbold">
                                <div class="width10percent">
                                    D
                                </div>
                                <div class="width30percent centertextalign">
                                    <div class="width32percent">
                                        S
                                    </div>
                                    <div class="width32percent">
                                        AR
                                    </div>
                                </div>
                                <div class="width60percent lefttextalign">
                                    PERSONAL PROTECTIVE<br />
                                    EQUIPMENT
                                </div>
                            </div>
                        </div>
                        <div class=" container_01  lefttextalign">
                            <div class="width50percent">
                                <div class="width10percent margintop5pixel">
                                    A1
                                </div>
                                <div class="width30percent">
                                    <asp:RadioButtonList onmousedown="getSelected(this);" onClick="unselectkRest(this);"
                                        TextAlign="Left" RepeatDirection="Horizontal" ID="lst_A1" runat="server">
                                        <asp:ListItem Value="S" Text=""></asp:ListItem>
                                        <asp:ListItem Value="AR" Text=""></asp:ListItem>
                                    </asp:RadioButtonList>
                                </div>
                                <div class="width60percent margintop5pixel">
                                    Rushing
                                </div>
                            </div>
                            <div class="width50percent">
                                <div class="width10percent margintop5pixel">
                                    D1
                                </div>
                                <div class="width30percent">
                                    <asp:RadioButtonList onmousedown="getSelected(this);" onClick="unselectkRest(this);"
                                        TextAlign="Left" RepeatDirection="Horizontal" ID="lst_D1" runat="server">
                                        <asp:ListItem Value="S" Text=""></asp:ListItem>
                                        <asp:ListItem Value="AR" Text=""></asp:ListItem>
                                    </asp:RadioButtonList>
                                </div>
                                <div class="width60percent margintop5pixel">
                                    Head/foot Protection
                                </div>
                            </div>
                        </div>
                        <div class=" container_01  lefttextalign">
                            <div class="width50percent">
                                <div class="width10percent margintop5pixel">
                                    A2
                                </div>
                                <div class="width30percent">
                                    <asp:RadioButtonList onmousedown="getSelected(this);" onClick="unselectkRest(this);"
                                        TextAlign="Left" RepeatDirection="Horizontal" ID="lst_A2" runat="server">
                                        <asp:ListItem Value="S" Text=""></asp:ListItem>
                                        <asp:ListItem Value="AR" Text=""></asp:ListItem>
                                    </asp:RadioButtonList>
                                </div>
                                <div class="width60percent margintop5pixel">
                                    Frustration
                                </div>
                            </div>
                            <div class="width50percent">
                                <div class="width10percent margintop5pixel">
                                    D2
                                </div>
                                <div class="width30percent">
                                    <asp:RadioButtonList onmousedown="getSelected(this);" onClick="unselectkRest(this);"
                                        TextAlign="Left" RepeatDirection="Horizontal" ID="lst_D2" runat="server">
                                        <asp:ListItem Value="S" Text=""></asp:ListItem>
                                        <asp:ListItem Value="AR" Text=""></asp:ListItem>
                                    </asp:RadioButtonList>
                                </div>
                                <div class="width60percent margintop5pixel">
                                    Eye/Face Protection
                                </div>
                            </div>
                        </div>
                        <div class=" container_01  lefttextalign">
                            <div class="width50percent">
                                <div class="width10percent margintop5pixel">
                                    A3
                                </div>
                                <div class="width30percent">
                                    <asp:RadioButtonList onmousedown="getSelected(this);" onClick="unselectkRest(this);"
                                        TextAlign="Left" RepeatDirection="Horizontal" ID="lst_A3" runat="server">
                                        <asp:ListItem Value="S" Text=""></asp:ListItem>
                                        <asp:ListItem Value="AR" Text=""></asp:ListItem>
                                    </asp:RadioButtonList>
                                </div>
                                <div class="width60percent margintop5pixel">
                                    Fatigue
                                </div>
                            </div>
                            <div class="width50percent">
                                <div class="width10percent margintop5pixel">
                                    D3
                                </div>
                                <div class="width30percent">
                                    <asp:RadioButtonList onmousedown="getSelected(this);" onClick="unselectkRest(this);"
                                        TextAlign="Left" RepeatDirection="Horizontal" ID="lst_D3" runat="server">
                                        <asp:ListItem Value="S" Text=""></asp:ListItem>
                                        <asp:ListItem Value="AR" Text=""></asp:ListItem>
                                    </asp:RadioButtonList>
                                </div>
                                <div class="width60percent margintop5pixel">
                                    Hearing Protection
                                </div>
                            </div>
                        </div>
                        <div class=" container_01  lefttextalign">
                            <div class="width50percent">
                                <div class="width10percent margintop5pixel">
                                    A4
                                </div>
                                <div class="width30percent">
                                    <asp:RadioButtonList onmousedown="getSelected(this);" onClick="unselectkRest(this);"
                                        TextAlign="Left" RepeatDirection="Horizontal" ID="lst_A4" runat="server">
                                        <asp:ListItem Value="S" Text=""></asp:ListItem>
                                        <asp:ListItem Value="AR" Text=""></asp:ListItem>
                                    </asp:RadioButtonList>
                                </div>
                                <div class="width60percent margintop5pixel">
                                    Complacency
                                </div>
                            </div>
                            <div class="width50percent">
                                <div class="width10percent margintop5pixel">
                                    D4
                                </div>
                                <div class="width30percent">
                                    <asp:RadioButtonList onmousedown="getSelected(this);" onClick="unselectkRest(this);"
                                        TextAlign="Left" RepeatDirection="Horizontal" ID="lst_D4" runat="server">
                                        <asp:ListItem Value="S" Text=""></asp:ListItem>
                                        <asp:ListItem Value="AR" Text=""></asp:ListItem>
                                    </asp:RadioButtonList>
                                </div>
                                <div class="width60percent margintop5pixel">
                                    Respiratory Protection
                                </div>
                            </div>
                        </div>
                        <div class=" container_01 margintop10pixel lefttextalign">
                            <div class="width50percent  fontbold">
                                <div class="width10percent">
                                    B
                                </div>
                                <div class="width30percent centertextalign">
                                    <div class="width32percent">
                                        S
                                    </div>
                                    <div class="width32percent">
                                        AR
                                    </div>
                                    <div class="width32percent">
                                    </div>
                                </div>
                                <div class="width60percent lefttextalign">
                                    BODY POSITION
                                </div>
                            </div>
                            <div class="width50percent">
                                <div class="width10percent margintop5pixel">
                                    D5
                                </div>
                                <div class="width30percent">
                                    <asp:RadioButtonList onmousedown="getSelected(this);" onClick="unselectkRest(this);"
                                        TextAlign="Left" RepeatDirection="Horizontal" ID="lst_D5" runat="server">
                                        <asp:ListItem Value="S" Text=""></asp:ListItem>
                                        <asp:ListItem Value="AR" Text=""></asp:ListItem>
                                    </asp:RadioButtonList>
                                </div>
                                <div class="width60percent margintop5pixel">
                                    Hand/Arm Protection
                                </div>
                            </div>
                        </div>
                        <div class=" container_01  lefttextalign">
                            <div class="width50percent">
                                <div class="width10percent margintop5pixel">
                                    B1
                                </div>
                                <div class="width30percent">
                                    <asp:RadioButtonList onmousedown="getSelected(this);" onClick="unselectkRest(this);"
                                        TextAlign="Left" RepeatDirection="Horizontal" ID="lst_B1" runat="server">
                                        <asp:ListItem Value="S" Text=""></asp:ListItem>
                                        <asp:ListItem Value="AR" Text=""></asp:ListItem>
                                    </asp:RadioButtonList>
                                </div>
                                <div class="width60percent margintop5pixel">
                                    Eyes on Path
                                </div>
                            </div>
                            <div class="width50percent">
                                <div class="width10percent margintop5pixel">
                                    D6
                                </div>
                                <div class="width30percent">
                                    <asp:RadioButtonList onmousedown="getSelected(this);" onClick="unselectkRest(this);"
                                        TextAlign="Left" RepeatDirection="Horizontal" ID="lst_D6" runat="server">
                                        <asp:ListItem Value="S" Text=""></asp:ListItem>
                                        <asp:ListItem Value="AR" Text=""></asp:ListItem>
                                    </asp:RadioButtonList>
                                </div>
                                <div class="width60percent margintop5pixel">
                                    Body Protection
                                </div>
                            </div>
                        </div>
                        <div class=" container_01  lefttextalign">
                            <div class="width50percent">
                                <div class="width10percent margintop5pixel">
                                    B2
                                </div>
                                <div class="width30percent">
                                    <asp:RadioButtonList onmousedown="getSelected(this);" onClick="unselectkRest(this);"
                                        TextAlign="Left" RepeatDirection="Horizontal" ID="lst_B2" runat="server">
                                        <asp:ListItem Value="S" Text=""></asp:ListItem>
                                        <asp:ListItem Value="AR" Text=""></asp:ListItem>
                                    </asp:RadioButtonList>
                                </div>
                                <div class="width60percent margintop5pixel">
                                    Eyes on Work
                                </div>
                            </div>
                            <div class="width50percent">
                                <div class="width10percent margintop5pixel">
                                    D7
                                </div>
                                <div class="width30percent">
                                    <asp:RadioButtonList onmousedown="getSelected(this);" onClick="unselectkRest(this);"
                                        TextAlign="Left" RepeatDirection="Horizontal" ID="lst_D7" runat="server">
                                        <asp:ListItem Value="S" Text=""></asp:ListItem>
                                        <asp:ListItem Value="AR" Text=""></asp:ListItem>
                                    </asp:RadioButtonList>
                                </div>
                                <div class="width60percent margintop5pixel">
                                    Fall Protection
                                </div>
                            </div>
                        </div>
                        <div class=" container_01  lefttextalign">
                            <div class="width50percent">
                                <div class="width10percent margintop5pixel">
                                    B3
                                </div>
                                <div class="width30percent">
                                    <asp:RadioButtonList onmousedown="getSelected(this);" onClick="unselectkRest(this);"
                                        TextAlign="Left" RepeatDirection="Horizontal" ID="lst_B3" runat="server">
                                        <asp:ListItem Value="S" Text=""></asp:ListItem>
                                        <asp:ListItem Value="AR" Text=""></asp:ListItem>
                                    </asp:RadioButtonList>
                                </div>
                                <div class="width60percent margintop5pixel">
                                    Line of Fire
                                </div>
                            </div>
                            <div class="width50percent fontbold">
                                <div class="width10percent">
                                    E
                                </div>
                                <div class="width30percent centertextalign">
                                    <div class="width32percent">
                                        S
                                    </div>
                                    <div class="width32percent">
                                        AR
                                    </div>
                                    <div class="width32percent">
                                    </div>
                                </div>
                                <div class="width60percent lefttextalign">
                                    TRANS, EQUIP & TOOL SELECTION, USE & COND.
                                </div>
                            </div>
                        </div>
                        <div class=" container_01  lefttextalign">
                            <div class="width50percent">
                                <div class="width10percent margintop5pixel">
                                    B4
                                </div>
                                <div class="width30percent">
                                    <asp:RadioButtonList onmousedown="getSelected(this);" onClick="unselectkRest(this);"
                                        TextAlign="Left" RepeatDirection="Horizontal" ID="lst_B4" runat="server">
                                        <asp:ListItem Value="S" Text=""></asp:ListItem>
                                        <asp:ListItem Value="AR" Text=""></asp:ListItem>
                                    </asp:RadioButtonList>
                                </div>
                                <div class="width60percent margintop5pixel">
                                    Pinch Points
                                </div>
                            </div>
                            <div class="width50percent">
                                <div class="width10percent margintop5pixel">
                                    E1
                                </div>
                                <div class="width30percent">
                                    <asp:RadioButtonList onmousedown="getSelected(this);" onClick="unselectkRest(this);"
                                        TextAlign="Left" RepeatDirection="Horizontal" ID="lst_E1" runat="server">
                                        <asp:ListItem Value="S" Text=""></asp:ListItem>
                                        <asp:ListItem Value="AR" Text=""></asp:ListItem>
                                    </asp:RadioButtonList>
                                </div>
                                <div class="width60percent margintop5pixel">
                                    Equip. & Tools Selection,
                                    <br />
                                    Use & Condition
                                </div>
                            </div>
                        </div>
                        <div class=" container_01  lefttextalign">
                            <div class="width50percent">
                                <div class="width10percent margintop5pixel">
                                    B5
                                </div>
                                <div class="width30percent">
                                    <asp:RadioButtonList onmousedown="getSelected(this);" onClick="unselectkRest(this);"
                                        TextAlign="Left" RepeatDirection="Horizontal" ID="lst_B5" runat="server">
                                        <asp:ListItem Value="S" Text=""></asp:ListItem>
                                        <asp:ListItem Value="AR" Text=""></asp:ListItem>
                                    </asp:RadioButtonList>
                                </div>
                                <div class="width60percent margintop5pixel">
                                    Ascending/Descending
                                </div>
                            </div>
                            <div class="width50percent">
                                <div class="width10percent margintop5pixel">
                                    E2
                                </div>
                                <div class="width30percent">
                                    <asp:RadioButtonList onmousedown="getSelected(this);" onClick="unselectkRest(this);"
                                        TextAlign="Left" RepeatDirection="Horizontal" ID="lst_E2" runat="server">
                                        <asp:ListItem Value="S" Text=""></asp:ListItem>
                                        <asp:ListItem Value="AR" Text=""></asp:ListItem>
                                    </asp:RadioButtonList>
                                </div>
                                <div class="width60percent margintop5pixel">
                                    Safety Guards
                                </div>
                            </div>
                        </div>
                        <div class=" container_01  lefttextalign">
                            <div class="width50percent">
                                <div class="width10percent margintop5pixel">
                                    B6
                                </div>
                                <div class="width30percent">
                                    <asp:RadioButtonList onmousedown="getSelected(this);" onClick="unselectkRest(this);"
                                        TextAlign="Left" RepeatDirection="Horizontal" ID="lst_B6" runat="server">
                                        <asp:ListItem Value="S" Text=""></asp:ListItem>
                                        <asp:ListItem Value="AR" Text=""></asp:ListItem>
                                    </asp:RadioButtonList>
                                </div>
                                <div class="width60percent margintop5pixel">
                                    Getting Assistance
                                </div>
                            </div>
                            <div class="width50percent">
                                <div class="width10percent margintop5pixel">
                                    E3
                                </div>
                                <div class="width30percent">
                                    <asp:RadioButtonList onmousedown="getSelected(this);" onClick="unselectkRest(this);"
                                        TextAlign="Left" RepeatDirection="Horizontal" ID="lst_E3" runat="server">
                                        <asp:ListItem Value="S" Text=""></asp:ListItem>
                                        <asp:ListItem Value="AR" Text=""></asp:ListItem>
                                    </asp:RadioButtonList>
                                </div>
                                <div class="width60percent margintop5pixel">
                                    Grounding
                                </div>
                            </div>
                        </div>
                        <div class=" container_01  lefttextalign">
                            <div class="width50percent margintop5pixel fontbold">
                                <div class="width10percent">
                                    C
                                </div>
                                <div class="width30percent centertextalign">
                                    <div class="width32percent">
                                        S
                                    </div>
                                    <div class="width32percent">
                                        AR
                                    </div>
                                    <div class="width32percent">
                                    </div>
                                </div>
                                <div class="width60percent lefttextalign">
                                    BODY MECHANICS
                                </div>
                            </div>
                            <div class="width50percent">
                                <div class="width10percent margintop5pixel">
                                    E4
                                </div>
                                <div class="width30percent">
                                    <asp:RadioButtonList onmousedown="getSelected(this);" onClick="unselectkRest(this);"
                                        TextAlign="Left" RepeatDirection="Horizontal" ID="lst_E4" runat="server">
                                        <asp:ListItem Value="S" Text=""></asp:ListItem>
                                        <asp:ListItem Value="AR" Text=""></asp:ListItem>
                                    </asp:RadioButtonList>
                                </div>
                                <div class="width60percent margintop5pixel">
                                    Transportation Use/Vehicle/Bicycle
                                </div>
                            </div>
                        </div>
                        <div class=" container_01  lefttextalign">
                            <div class="width50percent">
                                <div class="width10percent margintop5pixel">
                                    C1
                                </div>
                                <div class="width30percent">
                                    <asp:RadioButtonList onmousedown="getSelected(this);" onClick="unselectkRest(this);"
                                        TextAlign="Left" RepeatDirection="Horizontal" ID="lst_C1" runat="server">
                                        <asp:ListItem Value="S" Text=""></asp:ListItem>
                                        <asp:ListItem Value="AR" Text=""></asp:ListItem>
                                    </asp:RadioButtonList>
                                </div>
                                <div class="width60percent margintop5pixel">
                                    Repetitive Motion
                                </div>
                            </div>
                            <div class="width50percent fontbold">
                                <div class="width10percent">
                                    F
                                </div>
                                <div class="width30percent centertextalign">
                                    <div class="width32percent">
                                        S
                                    </div>
                                    <div class="width32percent">
                                        AR
                                    </div>
                                    <div class="width32percent">
                                    </div>
                                </div>
                                <div class="width60percent lefttextalign">
                                    WORKING ENVIRONMENT
                                </div>
                            </div>
                        </div>
                        <div class=" container_01  lefttextalign">
                            <div class="width50percent">
                                <div class="width10percent margintop5pixel">
                                    C2
                                </div>
                                <div class="width30percent">
                                    <asp:RadioButtonList onmousedown="getSelected(this);" onClick="unselectkRest(this);"
                                        TextAlign="Left" RepeatDirection="Horizontal" ID="lst_C2" runat="server">
                                        <asp:ListItem Value="S" Text=""></asp:ListItem>
                                        <asp:ListItem Value="AR" Text=""></asp:ListItem>
                                    </asp:RadioButtonList>
                                </div>
                                <div class="width60percent margintop5pixel">
                                    Push/Pull
                                </div>
                            </div>
                            <div class="width50percent">
                                <div class="width10percent margintop5pixel">
                                    F1
                                </div>
                                <div class="width30percent">
                                    <asp:RadioButtonList onmousedown="getSelected(this);" onClick="unselectkRest(this);"
                                        TextAlign="Left" RepeatDirection="Horizontal" ID="lst_F1" runat="server">
                                        <asp:ListItem Value="S" Text=""></asp:ListItem>
                                        <asp:ListItem Value="AR" Text=""></asp:ListItem>
                                    </asp:RadioButtonList>
                                </div>
                                <div class="width60percent margintop5pixel">
                                    Housekeeping
                                </div>
                            </div>
                        </div>
                        <div class=" container_01  lefttextalign">
                            <div class="width50percent">
                                <div class="width10percent margintop5pixel">
                                    C3
                                </div>
                                <div class="width30percent">
                                    <asp:RadioButtonList onmousedown="getSelected(this);" onClick="unselectkRest(this);"
                                        TextAlign="Left" RepeatDirection="Horizontal" ID="lst_C3" runat="server">
                                        <asp:ListItem Value="S" Text=""></asp:ListItem>
                                        <asp:ListItem Value="AR" Text=""></asp:ListItem>
                                    </asp:RadioButtonList>
                                </div>
                                <div class="width60percent margintop5pixel">
                                    Pivoting/Twisting
                                </div>
                            </div>
                            <div class="width50percent">
                                <div class="width10percent margintop5pixel">
                                    F2
                                </div>
                                <div class="width30percent">
                                    <asp:RadioButtonList onmousedown="getSelected(this);" onClick="unselectkRest(this);"
                                        TextAlign="Left" RepeatDirection="Horizontal" ID="lst_F2" runat="server">
                                        <asp:ListItem Value="S" Text=""></asp:ListItem>
                                        <asp:ListItem Value="AR" Text=""></asp:ListItem>
                                    </asp:RadioButtonList>
                                </div>
                                <div class="width60percent margintop5pixel">
                                    Walk /Work Surfaces/Access-Egress
                                </div>
                            </div>
                        </div>
                        <div class=" container_01  lefttextalign">
                            <div class="width50percent">
                                <div class="width10percent margintop5pixel">
                                    C4
                                </div>
                                <div class="width30percent">
                                    <asp:RadioButtonList onmousedown="getSelected(this);" onClick="unselectkRest(this);"
                                        TextAlign="Left" RepeatDirection="Horizontal" ID="lst_C4" runat="server">
                                        <asp:ListItem Value="S" Text=""></asp:ListItem>
                                        <asp:ListItem Value="AR" Text=""></asp:ListItem>
                                    </asp:RadioButtonList>
                                </div>
                                <div class="width60percent margintop5pixel">
                                    Leverage
                                </div>
                            </div>
                            <div class="width50percent">
                                <div class="width10percent margintop5pixel">
                                    F3
                                </div>
                                <div class="width30percent">
                                    <asp:RadioButtonList onmousedown="getSelected(this);" onClick="unselectkRest(this);"
                                        TextAlign="Left" RepeatDirection="Horizontal" ID="lst_F3" runat="server">
                                        <asp:ListItem Value="S" Text=""></asp:ListItem>
                                        <asp:ListItem Value="AR" Text=""></asp:ListItem>
                                    </asp:RadioButtonList>
                                </div>
                                <div class="width60percent margintop5pixel">
                                    Barricades/Barriers
                                </div>
                            </div>
                        </div>
                        <div class=" container_01  lefttextalign">
                            <div class="width50percent">
                                <div class="width10percent margintop5pixel">
                                    C5
                                </div>
                                <div class="width30percent">
                                    <asp:RadioButtonList onmousedown="getSelected(this);" onClick="unselectkRest(this);"
                                        TextAlign="Left" RepeatDirection="Horizontal" ID="lst_C5" runat="server">
                                        <asp:ListItem Value="S" Text=""></asp:ListItem>
                                        <asp:ListItem Value="AR" Text=""></asp:ListItem>
                                    </asp:RadioButtonList>
                                </div>
                                <div class="width60percent margintop5pixel">
                                    Lifting/Lowering
                                </div>
                            </div>
                            <div class="width50percent">
                                <div class="width10percent margintop5pixel">
                                    F4
                                </div>
                                <div class="width30percent">
                                    <asp:RadioButtonList onmousedown="getSelected(this);" onClick="unselectkRest(this);"
                                        TextAlign="Left" RepeatDirection="Horizontal" ID="lst_F4" runat="server">
                                        <asp:ListItem Value="S" Text=""></asp:ListItem>
                                        <asp:ListItem Value="AR" Text=""></asp:ListItem>
                                    </asp:RadioButtonList>
                                </div>
                                <div class="width60percent margintop5pixel">
                                    Heat Stress/Cold Stress
                                </div>
                            </div>
                        </div>
                        <div class=" container_01  lefttextalign">
                            <div class="width50percent">
                                <div class="width10percent margintop5pixel">
                                    C6
                                </div>
                                <div class="width30percent">
                                    <asp:RadioButtonList onmousedown="getSelected(this);" onClick="unselectkRest(this);"
                                        TextAlign="Left" RepeatDirection="Horizontal" ID="lst_C6" runat="server">
                                        <asp:ListItem Value="S" Text=""></asp:ListItem>
                                        <asp:ListItem Value="AR" Text=""></asp:ListItem>
                                    </asp:RadioButtonList>
                                </div>
                                <div class="width60percent margintop5pixel">
                                    Grip
                                </div>
                            </div>
                            <div class="width50percent">
                                <div class="width10percent margintop5pixel">
                                    F5
                                </div>
                                <div class="width30percent">
                                    <asp:RadioButtonList onmousedown="getSelected(this);" onClick="unselectkRest(this);"
                                        TextAlign="Left" RepeatDirection="Horizontal" ID="lst_F5" runat="server">
                                        <asp:ListItem Value="S" Text=""></asp:ListItem>
                                        <asp:ListItem Value="AR" Text=""></asp:ListItem>
                                    </asp:RadioButtonList>
                                </div>
                                <div class="width60percent margintop5pixel">
                                    Lighting
                                </div>
                            </div>
                        </div>
                        <div class=" container_01  lefttextalign">
                            <div class="width50percent">
                                <div class="width10percent margintop5pixel">
                                    C7
                                </div>
                                <div class="width30percent">
                                    <asp:RadioButtonList onmousedown="getSelected(this);" onClick="unselectkRest(this);"
                                        TextAlign="Left" RepeatDirection="Horizontal" ID="lst_C7" runat="server">
                                        <asp:ListItem Value="S" Text=""></asp:ListItem>
                                        <asp:ListItem Value="AR" Text=""></asp:ListItem>
                                    </asp:RadioButtonList>
                                </div>
                                <div class="width60percent margintop5pixel">
                                    Base of Support
                                </div>
                            </div>
                        </div>
                        <div class=" container_01  lefttextalign">
                            <div class="width50percent">
                                <div class="width10percent margintop5pixel">
                                    C8
                                </div>
                                <div class="width30percent">
                                    <asp:RadioButtonList onmousedown="getSelected(this);" onClick="unselectkRest(this);"
                                        TextAlign="Left" RepeatDirection="Horizontal" ID="lst_C8" runat="server">
                                        <asp:ListItem Value="S" Text=""></asp:ListItem>
                                        <asp:ListItem Value="AR" Text=""></asp:ListItem>
                                    </asp:RadioButtonList>
                                </div>
                                <div class="width60percent margintop5pixel">
                                    Overextending
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="maindiv" style="width: 485px; height: 1150px; float: left; background: #fff;
                        display: block; border: solid #999 1px;">
                        <div class=" container_01  lefttextalign" style="padding-top: 35px">
                            <div class="width50percent fontbold">
                                <div class="width10percent">
                                    G
                                </div>
                                <div class="width30percent centertextalign">
                                    <div class="width32percent">
                                        S
                                    </div>
                                    <div class="width32percent">
                                        AR
                                    </div>
                                    <div class="width32percent">
                                    </div>
                                </div>
                                <div class="width60percent lefttextalign">
                                    PROCEDURE RELATED
                                </div>
                            </div>
                            <div class="width50percent  fontbold">
                                <div class="width10percent">
                                    H
                                </div>
                                <div class="width30percent centertextalign">
                                    <div class="width32percent">
                                        S
                                    </div>
                                    <div class="width32percent">
                                        AR
                                    </div>
                                    <div class="width32percent">
                                    </div>
                                </div>
                                <div class="width60percent lefttextalign">
                                    CHEMICALS /
                                    <br />
                                    ENVIRONMENTAL (CONT.)
                                </div>
                            </div>
                        </div>
                        <div class=" container_01  lefttextalign">
                            <div class="width50percent">
                                <div class="width10percent margintop5pixel">
                                    G1
                                </div>
                                <div class="width30percent">
                                    <asp:RadioButtonList onmousedown="getSelected(this);" onClick="unselectkRest(this);"
                                        TextAlign="Left" RepeatDirection="Horizontal" ID="lst_G1" runat="server">
                                        <asp:ListItem Value="S" Text=""></asp:ListItem>
                                        <asp:ListItem Value="AR" Text=""></asp:ListItem>
                                    </asp:RadioButtonList>
                                </div>
                                <div class="width60percent margintop5pixel">
                                    Pre/Post-Job Inspection
                                </div>
                            </div>
                            <div class="width50percent">
                                <div class="width10percent margintop5pixel">
                                    H6
                                </div>
                                <div class="width30percent">
                                    <asp:RadioButtonList onmousedown="getSelected(this);" onClick="unselectkRest(this);"
                                        TextAlign="Left" RepeatDirection="Horizontal" ID="lst_H6" runat="server">
                                        <asp:ListItem Value="S" Text=""></asp:ListItem>
                                        <asp:ListItem Value="AR" Text=""></asp:ListItem>
                                    </asp:RadioButtonList>
                                </div>
                                <div class="width60percent margintop5pixel">
                                    Pollution Prevention /Containment
                                </div>
                            </div>
                        </div>
                        <div class=" container_01  lefttextalign">
                            <div class="width50percent">
                                <div class="width10percent margintop5pixel">
                                    G2
                                </div>
                                <div class="width30percent">
                                    <asp:RadioButtonList onmousedown="getSelected(this);" onClick="unselectkRest(this);"
                                        TextAlign="Left" RepeatDirection="Horizontal" ID="lst_G2" runat="server">
                                        <asp:ListItem Value="S" Text=""></asp:ListItem>
                                        <asp:ListItem Value="AR" Text=""></asp:ListItem>
                                    </asp:RadioButtonList>
                                </div>
                                <div class="width60percent margintop5pixel">
                                    Communication
                                </div>
                            </div>
                            <div class="width50percent">
                                <div class="width10percent margintop5pixel">
                                    H7
                                </div>
                                <div class="width30percent">
                                    <asp:RadioButtonList onmousedown="getSelected(this);" onClick="unselectkRest(this);"
                                        TextAlign="Left" RepeatDirection="Horizontal" ID="lst_H7" runat="server">
                                        <asp:ListItem Value="S" Text=""></asp:ListItem>
                                        <asp:ListItem Value="AR" Text=""></asp:ListItem>
                                    </asp:RadioButtonList>
                                </div>
                                <div class="width60percent margintop5pixel">
                                    Control of Releases, Caps & Plugs
                                </div>
                            </div>
                        </div>
                        <div class=" container_01  lefttextalign">
                            <div class="width50percent">
                                <div class="width10percent margintop5pixel">
                                    G3
                                </div>
                                <div class="width30percent">
                                    <asp:RadioButtonList onmousedown="getSelected(this);" onClick="unselectkRest(this);"
                                        TextAlign="Left" RepeatDirection="Horizontal" ID="lst_G3" runat="server">
                                        <asp:ListItem Value="S" Text=""></asp:ListItem>
                                        <asp:ListItem Value="AR" Text=""></asp:ListItem>
                                    </asp:RadioButtonList>
                                </div>
                                <div class="width60percent margintop5pixel">
                                    Lockout / Tagout/Try
                                </div>
                            </div>
                            <div class="width50percent">
                                <div class="width10percent margintop5pixel">
                                    H8
                                </div>
                                <div class="width30percent">
                                    <asp:RadioButtonList onmousedown="getSelected(this);" onClick="unselectkRest(this);"
                                        TextAlign="Left" RepeatDirection="Horizontal" ID="lst_H8" runat="server">
                                        <asp:ListItem Value="S" Text=""></asp:ListItem>
                                        <asp:ListItem Value="AR" Text=""></asp:ListItem>
                                    </asp:RadioButtonList>
                                </div>
                                <div class="width60percent margintop5pixel">
                                    Energy Conservation
                                </div>
                            </div>
                        </div>
                        <div class=" container_01  lefttextalign">
                            <div class="width50percent  fontbold">
                                <div class="width10percent">
                                    H
                                </div>
                                <div class="width30percent centertextalign">
                                    <div class="width32percent">
                                        S
                                    </div>
                                    <div class="width32percent">
                                        AR
                                    </div>
                                    <div class="width32percent">
                                    </div>
                                </div>
                                <div class="width60percent lefttextalign">
                                    CHEMICALS /
                                    <br />
                                    ENVIRONMENTAL
                                </div>
                            </div>
                            <div class="width50percent  fontbold">
                                <div class="width10percent">
                                    J
                                </div>
                                <div class="width30percent centertextalign">
                                    <div class="width32percent">
                                        S
                                    </div>
                                    <div class="width32percent">
                                        AR
                                    </div>
                                    <div class="width32percent">
                                    </div>
                                </div>
                                <div class="width60percent lefttextalign">
                                    CHECK SIGNALS
                                </div>
                            </div>
                        </div>
                        <div class=" container_01  lefttextalign">
                            <div class="width50percent">
                                <div class="width10percent margintop5pixel">
                                    H1
                                </div>
                                <div class="width30percent">
                                    <asp:RadioButtonList onmousedown="getSelected(this);" onClick="unselectkRest(this);"
                                        TextAlign="Left" RepeatDirection="Horizontal" ID="lst_H1" runat="server">
                                        <asp:ListItem Value="S" Text=""></asp:ListItem>
                                        <asp:ListItem Value="AR" Text=""></asp:ListItem>
                                    </asp:RadioButtonList>
                                </div>
                                <div class="width60percent margintop5pixel">
                                    Chemical Use
                                </div>
                            </div>
                            <div class="width50percent">
                                <div class="width10percent margintop5pixel">
                                    J1
                                </div>
                                <div class="width30percent">
                                    <asp:RadioButtonList onmousedown="getSelected(this);" onClick="unselectkRest(this);"
                                        TextAlign="Left" RepeatDirection="Horizontal" ID="lst_J1" runat="server">
                                        <asp:ListItem Value="Y" Text=""></asp:ListItem>
                                        <asp:ListItem Value="N" Text=""></asp:ListItem>
                                    </asp:RadioButtonList>
                                </div>
                                <div class="width60percent margintop5pixel">
                                    Check Signals Performed
                                </div>
                            </div>
                        </div>
                        <div class=" container_01  lefttextalign">
                            <div class="width50percent">
                                <div class="width10percent margintop5pixel">
                                    H2
                                </div>
                                <div class="width30percent">
                                    <asp:RadioButtonList onmousedown="getSelected(this);" onClick="unselectkRest(this);"
                                        TextAlign="Left" RepeatDirection="Horizontal" ID="lst_H2" runat="server">
                                        <asp:ListItem Value="S" Text=""></asp:ListItem>
                                        <asp:ListItem Value="AR" Text=""></asp:ListItem>
                                    </asp:RadioButtonList>
                                </div>
                                <div class="width60percent margintop5pixel">
                                    Grounding/Ventilation
                                </div>
                            </div>
                            <div class="width50percent">
                                <div class="width10percent margintop5pixel">
                                    J2
                                </div>
                                <div class="width30percent">
                                    <asp:RadioButtonList onmousedown="getSelected(this);" onClick="unselectkRest(this);"
                                        TextAlign="Left" RepeatDirection="Horizontal" ID="lst_J2" runat="server">
                                        <asp:ListItem Value="Y" Text=""></asp:ListItem>
                                        <asp:ListItem Value="N" Text=""></asp:ListItem>
                                    </asp:RadioButtonList>
                                </div>
                                <div class="width60percent margintop5pixel">
                                    Focus-Start to Finish
                                </div>
                            </div>
                        </div>
                        <div class=" container_01  lefttextalign">
                            <div class="width50percent">
                                <div class="width10percent margintop5pixel">
                                    H3
                                </div>
                                <div class="width30percent">
                                    <asp:RadioButtonList onmousedown="getSelected(this);" onClick="unselectkRest(this);"
                                        TextAlign="Left" RepeatDirection="Horizontal" ID="lst_H3" runat="server">
                                        <asp:ListItem Value="S" Text=""></asp:ListItem>
                                        <asp:ListItem Value="AR" Text=""></asp:ListItem>
                                    </asp:RadioButtonList>
                                </div>
                                <div class="width60percent margintop5pixel">
                                    Labeling / Storage
                                </div>
                            </div>
                            <div class="width50percent  fontbold">
                                <div class="width10percent">
                                    K
                                </div>
                                <div class="width30percent centertextalign">
                                    <div class="width32percent">
                                        S
                                    </div>
                                    <div class="width32percent">
                                        AR
                                    </div>
                                    <div class="width32percent">
                                    </div>
                                </div>
                                <div class="width60percent lefttextalign">
                                    OTHER
                                </div>
                            </div>
                        </div>
                        <div class=" container_01  lefttextalign">
                            <div class="width50percent">
                                <div class="width10percent margintop5pixel">
                                    H4
                                </div>
                                <div class="width30percent">
                                    <asp:RadioButtonList onmousedown="getSelected(this);" onClick="unselectkRest(this);"
                                        TextAlign="Left" RepeatDirection="Horizontal" ID="lst_H4" runat="server">
                                        <asp:ListItem Value="S" Text=""></asp:ListItem>
                                        <asp:ListItem Value="AR" Text=""></asp:ListItem>
                                    </asp:RadioButtonList>
                                </div>
                                <div class="width60percent margintop5pixel">
                                    Transportation / Spill Prevention
                                </div>
                            </div>
                            <div class="width50percent">
                                <div class="width10percent margintop5pixel">
                                    K1
                                </div>
                                <div class="width30percent">
                                    <asp:RadioButtonList onmousedown="getSelected(this);" onClick="unselectkRest(this);"
                                        TextAlign="Left" RepeatDirection="Horizontal" ID="lst_K1" runat="server">
                                        <asp:ListItem Value="S" Text=""></asp:ListItem>
                                        <asp:ListItem Value="AR" Text=""></asp:ListItem>
                                    </asp:RadioButtonList>
                                </div>
                                <div class="width60percent margintop5pixel">
                                    Other and/or Changed Behavior
                                </div>
                            </div>
                        </div>
                        <div class=" container_01  lefttextalign">
                            <div class="width50percent">
                                <div class="width10percent margintop5pixel">
                                    H5
                                </div>
                                <div class="width30percent">
                                    <asp:RadioButtonList onmousedown="getSelected(this);" onClick="unselectkRest(this);"
                                        TextAlign="Left" RepeatDirection="Horizontal" ID="lst_H5" runat="server">
                                        <asp:ListItem Value="S" Text=""></asp:ListItem>
                                        <asp:ListItem Value="AR" Text=""></asp:ListItem>
                                    </asp:RadioButtonList>
                                </div>
                                <div class="width60percent margintop5pixel">
                                    Waste Disposal, Labelling, Recycling
                                </div>
                            </div>
                        </div>
                        <div class="Horizentalline" style="width: 467px; margin: 5px; padding-top: 15px">
                        </div>
                        <div class="leftdiv" style="width: 477px; margin: 5px 0 0 10px;">
                            <div class=" width100percent margintop10pixel floatLeft">
                                <cc2:OboutTextBox ID="txt_Item_1" runat="server" Width="40"></cc2:OboutTextBox>&nbsp;<label>Item#1</label>&nbsp;&nbsp;&nbsp;<label
                                    class="fontbold">WHAT WAS AT RISK, AND WHY WAS THE AT-RISK PERFORMED?</label><br />
                            </div>
                            <div class=" width100percent floatLeft margintop10pixel  centertextalign">
                                <asp:TextBox runat="server" ID="txt_Item_Text_1" Columns="68" Width="90%" Rows="4"
                                    Height="150px" TextMode="MultiLine"></asp:TextBox>
                            </div>
                            <div class=" width100percent  lefttextalign">
                                <div class="width90percent lefttextalign padding0px">
                                    <table style="width: 100%">
                                        <tr style="width: 100%">
                                            <td style="width: 15%">
                                                &nbsp;
                                            </td>
                                            <td style="width: 70%; font-size: 11px; text-align: right; font-weight: bold;">
                                                FOLLOW-UP NEEDED:
                                            </td>
                                            <td style="width: 15%">
                                                <cc2:OboutCheckBox ID="chk_FollowUp_Needed_1" runat="server" Text="Yes">
                                                </cc2:OboutCheckBox>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                            </div>
                        </div>
                        <div class="leftdiv" style="width: 477px; margin: 10px 0 0 10px;">
                            <div class=" width100percent margintop10pixel floatLeft">
                                <cc2:OboutTextBox ID="txt_Item_2" runat="server" Width="40"></cc2:OboutTextBox>&nbsp;<label>Item#2</label>&nbsp;&nbsp;&nbsp;<label
                                    class="fontbold">WHAT WAS AT RISK, AND WHY WAS THE AT-RISK PERFORMED?</label><br />
                            </div>
                            <div class=" width100percent floatLeft margintop10pixel  centertextalign">
                                <asp:TextBox runat="server" ID="txt_Item_Text_2" Columns="68" Width="90%" Rows="4"
                                    Height="150px" TextMode="MultiLine"></asp:TextBox>
                            </div>
                            <div class=" width100percent  lefttextalign">
                                <div class="width90percent lefttextalign padding0px">
                                    <table style="width: 100%">
                                        <tr style="width: 100%">
                                            <td style="width: 15%">
                                                &nbsp;
                                            </td>
                                            <td style="width: 70%; font-size: 11px; text-align: right; font-weight: bold;">
                                                FOLLOW-UP NEEDED:
                                            </td>
                                            <td style="width: 15%">
                                                <cc2:OboutCheckBox ID="chk_FollowUp_Needed_2" runat="server" Text="Yes">
                                                </cc2:OboutCheckBox>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                            </div>
                        </div>
                        <div class="leftdiv" style="width: 477px; margin: 10px 0 0 10px;">
                            <div class=" width100percent margintop10pixel floatLeft">
                                <cc2:OboutTextBox ID="txt_Item_3" runat="server" Width="40"></cc2:OboutTextBox>&nbsp;<label>Item#3</label>&nbsp;&nbsp;&nbsp;<label
                                    class="fontbold">WHAT WAS AT RISK, AND WHY WAS THE AT-RISK PERFORMED?</label><br />
                            </div>
                            <div class=" width100percent floatLeft margintop10pixel  centertextalign">
                                <asp:TextBox runat="server" ID="txt_Item_Text_3" Columns="68" Width="90%" Rows="4"
                                    Height="150px" TextMode="MultiLine"></asp:TextBox>
                            </div>
                            <div class=" width100percent  lefttextalign">
                                <div class="width90percent lefttextalign padding0px">
                                    <table style="width: 100%">
                                        <tr style="width: 100%">
                                            <td style="width: 15%">
                                                &nbsp;
                                            </td>
                                            <td style="width: 70%; font-size: 11px; text-align: right; font-weight: bold;">
                                                FOLLOW-UP NEEDED:
                                            </td>
                                            <td style="width: 15%">
                                                <cc2:OboutCheckBox ID="chk_FollowUp_Needed_3" runat="server" Text="Yes">
                                                </cc2:OboutCheckBox>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="maindiv" style="width: 964px; padding: 20px 0px; text-align: center;">
                        <asp:Button ID="Button1" runat="server" Text="Insert" OnClick="Button1_Click" Width="200px"
                            Height="50px" Font-Bold="true" Font-Size="Medium" CssClass="button01" OnClientClick="OnBeforeUpdate" />&nbsp;
                        <asp:Button ID="btnClaear" runat="server" Text="Clear" OnClick="Clear_Click" CausesValidation="false"
                            Width="200px" Height="50px" Font-Bold="true" Font-Size="Medium" />&nbsp;
                        <asp:Button ID="btnLogOut2" runat="server" Text="Log Out" OnClick="btnLogout_Click"
                            CausesValidation="false" Width="200px" Height="50px" Font-Bold="true" Font-Size="Medium" />
                    </div>
                </div>
            </div>
        </center>
    </div>
    <asp:SqlDataSource ID="SqlDataSourceArea" runat="server" ConnectionString="<%$ ConnectionStrings:pjengConnectionString1 %>"
        ProviderName="<%$ ConnectionStrings:pjengConnectionString1.ProviderName %>" SelectCommandType="StoredProcedure"
        SelectCommand="sp_JWT_GetCustomersAreaByUGID">
        <SelectParameters>
            <asp:QueryStringParameter Name="UGID" Type="String" QueryStringField="aff_key" />
        </SelectParameters>
    </asp:SqlDataSource>
    <input type='hidden' id='hdnAreaID' />
    <input type='hidden' id='hdnLocationID' />
    <input type='hidden' id='hdnEmployeeID' />
    <input type='hidden' id='hdnCompanyID' />
    <input type='hidden' id='hdnLocationsBlankID' />
    <input type='hidden' id='hdnEmployeesBlankID' />
    <input type='hidden' id='hdnCompanysBlankID' />
    <asp:HiddenField ID="hdnTimeOffSet" runat="server" />
    <asp:HiddenField ID="hdnDateTime" runat="server" />
    <input type="hidden" id='hdnSelectedIndex' />
    </form>
</body>
</html>
