﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class SamplePages_ManagePlaylist : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void CheckForException(object sender, ObjectDataSourceStatusEventArgs e)
    {
        MessageUserControl.HandleDataBoundException(e);
    }


    protected void ArtistFetch_Click(object sender, EventArgs e)
    {
        MessageUserControl.TryRun(() =>
        {
            TracksBy.Text = "Artist";
            SearchArgID.Text = ArtistDDL.SelectedValue;
            TracksSelectionList.DataBind();//will force the ODS to execute
        });
    }
}