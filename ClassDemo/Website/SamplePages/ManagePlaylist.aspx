﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="ManagePlaylist.aspx.cs" Inherits="SamplePages_ManagePlaylist" %>

<%@ Register Src="~/UserControls/MessageUserControl.ascx" TagPrefix="uc1" TagName="MessageUserControl" %>


<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
    <div>
        <h1>Manage Playlists (UX TRX Sample)</h1>
    </div>
    <uc1:MessageUserControl runat="server" id="MessageUserControl" />
    <div class="row">
        <div class="col-sm-2">
            <asp:Label ID="Label1" runat="server" Text="Artist"></asp:Label><br />
            <asp:DropDownList ID="ArtistDDL" runat="server" 
                DataSourceID="ArtistDDLODS" 
                DataTextField="DisplayText" 
                DataValueField="IDValueField"></asp:DropDownList><br />
            <asp:Button ID="FetchArtist" runat="server" Text="Fetch" OnClick="FetchArtist_Click" />
            <br /><br />
             <asp:Label ID="Label2" runat="server" Text="Media"></asp:Label><br />
            <asp:DropDownList ID="MediaTypeDDL" runat="server" 
                DataSourceID="MediaTypeDDLODS" 
                DataTextField="DisplayText" 
                DataValueField="IDValueField"></asp:DropDownList><br />
            <asp:Button ID="MediaTypeFetch" runat="server" Text="Fetch" />
            <br /><br />
             <asp:Label ID="Label3" runat="server" Text="Genre"></asp:Label><br />
            <asp:DropDownList ID="GenreDDL" runat="server" DataSourceID="GenreDDLODS" DataTextField="DisplayText" DataValueField="IDValueField"></asp:DropDownList><br />
            <asp:Button ID="GenreFetch" runat="server" Text="Fetch" />
            <br /><br />
             <asp:Label ID="Label4" runat="server" Text="Album"></asp:Label><br />
            <asp:DropDownList ID="AlbumDDL" runat="server" DataSourceID="AlbumDDLODS" DataTextField="Title" DataValueField="AlbumId"></asp:DropDownList><br />
            <asp:Button ID="AlbumFetch" runat="server" Text="Fetch" />
            <br /><br />
        </div>
        <div class="col-sm-10">
            <asp:Label ID="Label5" runat="server" Text="Tracks"></asp:Label>&nbsp;&nbsp;
            <asp:Label ID="TracksBy" runat="server" Text=""></asp:Label>&nbsp;&nbsp;
            <asp:Label ID="SearchArgID" runat="server" Text="Label"></asp:Label><br />
            <asp:ListView ID="TrackSelectionList" runat="server" DataSourceID="TrackSelectionListODS">
                <AlternatingItemTemplate>
                    <tr style="">
                        <td>
                            <asp:Label Text='<%# Eval("TrackID") %>' runat="server" ID="TrackIDLabel" /></td>
                        <td>
                            <asp:Label Text='<%# Eval("Name") %>' runat="server" ID="NameLabel" /></td>
                        <td>
                            <asp:Label Text='<%# Eval("Title") %>' runat="server" ID="TitleLabel" /></td>
                        <td>
                            <asp:Label Text='<%# Eval("MediaName") %>' runat="server" ID="MediaNameLabel" /></td>
                        <td>
                            <asp:Label Text='<%# Eval("GenreName") %>' runat="server" ID="GenreNameLabel" /></td>
                        <td>
                            <asp:Label Text='<%# Eval("Composer") %>' runat="server" ID="ComposerLabel" /></td>
                        <td>
                            <asp:Label Text='<%# Eval("Milliseconds") %>' runat="server" ID="MillisecondsLabel" /></td>
                        <td>
                            <asp:Label Text='<%# Eval("Bytes") %>' runat="server" ID="BytesLabel" /></td>
                        <td>
                            <asp:Label Text='<%# Eval("UnitPrice") %>' runat="server" ID="UnitPriceLabel" /></td>
                    </tr>
                </AlternatingItemTemplate>
          
                <EmptyDataTemplate>
                    <table runat="server" style="">
                        <tr>
                            <td>No data was returned.</td>
                        </tr>
                    </table>
                </EmptyDataTemplate>
                
                <ItemTemplate>
                    <tr style="">
                        <td>
                            <asp:Label Text='<%# Eval("TrackID") %>' runat="server" ID="TrackIDLabel" /></td>
                        <td>
                            <asp:Label Text='<%# Eval("Name") %>' runat="server" ID="NameLabel" /></td>
                        <td>
                            <asp:Label Text='<%# Eval("Title") %>' runat="server" ID="TitleLabel" /></td>
                        <td>
                            <asp:Label Text='<%# Eval("MediaName") %>' runat="server" ID="MediaNameLabel" /></td>
                        <td>
                            <asp:Label Text='<%# Eval("GenreName") %>' runat="server" ID="GenreNameLabel" /></td>
                        <td>
                            <asp:Label Text='<%# Eval("Composer") %>' runat="server" ID="ComposerLabel" /></td>
                        <td>
                            <asp:Label Text='<%# Eval("Milliseconds") %>' runat="server" ID="MillisecondsLabel" /></td>
                        <td>
                            <asp:Label Text='<%# Eval("Bytes") %>' runat="server" ID="BytesLabel" /></td>
                        <td>
                            <asp:Label Text='<%# Eval("UnitPrice") %>' runat="server" ID="UnitPriceLabel" /></td>
                    </tr>
                </ItemTemplate>
                <LayoutTemplate>
                    <table runat="server">
                        <tr runat="server">
                            <td runat="server">
                                <table runat="server" id="itemPlaceholderContainer" style="" border="0">
                                    <tr runat="server" style="">
                                        <th runat="server">TrackID</th>
                                        <th runat="server">Name</th>
                                        <th runat="server">Title</th>
                                        <th runat="server">MediaName</th>
                                        <th runat="server">GenreName</th>
                                        <th runat="server">Composer</th>
                                        <th runat="server">Milliseconds</th>
                                        <th runat="server">Bytes</th>
                                        <th runat="server">UnitPrice</th>
                                    </tr>
                                    <tr runat="server" id="itemPlaceholder"></tr>
                                </table>
                            </td>
                        </tr>
                        <tr runat="server">
                            <td runat="server" style="">
                                <asp:DataPager runat="server" ID="DataPager1">
                                    <Fields>
                                        <asp:NextPreviousPagerField ButtonType="Button" ShowFirstPageButton="True" ShowLastPageButton="True"></asp:NextPreviousPagerField>
                                    </Fields>
                                </asp:DataPager>
                            </td>
                        </tr>
                    </table>
                </LayoutTemplate>
               
            </asp:ListView>

        </div>
    </div>
    <asp:ObjectDataSource ID="ArtistDDLODS" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="List_ArtistNames" TypeName="ChinookSystem.BLL.ArtistController"
        OnSelected="CheckForException"></asp:ObjectDataSource>
    <asp:ObjectDataSource ID="MediaTypeDDLODS" runat="server" SelectMethod="List_MediaTypes" TypeName="ChinookSystem.BLL.MediaController" OnSelected="CheckForException"></asp:ObjectDataSource>
    <asp:ObjectDataSource ID="GenreDDLODS" runat="server" SelectMethod="List_Genres" TypeName="ChinookSystem.BLL.GenreController" OnSelected="CheckForException"></asp:ObjectDataSource>
    <asp:ObjectDataSource ID="AlbumDDLODS" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="Albums_List" TypeName="ChinookSystem.BLL.AlbumController" OnSelected="CheckForException"></asp:ObjectDataSource>
    <asp:ObjectDataSource ID="TrackSelectionListODS" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="TracksForPlaylistSelection" TypeName="ChinookSystem.BLL.TrackController" OnSelected="CheckForException">
        <SelectParameters>
            <asp:ControlParameter ControlID="TracksBy" PropertyName="Text" Name="tracksby" Type="String"></asp:ControlParameter>
            <asp:ControlParameter ControlID="SearchArgID" PropertyName="Text" Name="argid" Type="Int32"></asp:ControlParameter>
        </SelectParameters>
    </asp:ObjectDataSource>
</asp:Content>

