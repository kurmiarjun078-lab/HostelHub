<%@ Page Title="My Room" MasterPageFile="~/StudentLayout.master" Language="C#" AutoEventWireup="true" CodeBehind="MyRoom.aspx.cs" Inherits="HostelHub.Student.MyRoom" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <div class="crumb">Dashboard &rsaquo; <b>My Room</b></div>

    <div class="panel mb-3">
        <div class="room-hero">
            <div>
                <h2>Room A-204 <span class="cat mess" style="font-size:12px">4-Seater</span></h2>
                <div class="page-sub" style="margin:6px 0 0"><i class="bi bi-geo-alt"></i> Block A • 2nd Floor • North Wing</div>
            </div>
            <div class="occ-box">
                <div><b>3</b>Occupied</div>
                <div class="blue"><b>1</b>Available</div>
            </div>
        </div>
    </div>

    <div class="row g-3 mb-3">
        <div class="col-lg-8">
            <div class="panel h-100">
                <div class="panel-head"><h5><i class="bi bi-diagram-3"></i> Room Layout</h5><a>Request Change</a></div>
                <hr />
                <div class="bed-grid">
                    <div class="bed"><span class="no">Bed 1</span><i class="bi bi-hospital"></i><div class="who">Rahul Sharma</div><span class="st">Occupied</span></div>
                    <div class="bed"><span class="no">Bed 2</span><i class="bi bi-hospital"></i><div class="who">Amit Kumar</div><span class="st">Occupied</span></div>
                    <div class="bed you"><span class="you-tag"><i class="bi bi-person"></i> You</span><span class="no">Bed 3</span><i class="bi bi-hospital"></i><div class="who">Jay Patel</div><span class="st">Occupied</span></div>
                    <div class="bed empty"><span class="no">Bed 4</span><i class="bi bi-hospital"></i><div class="who">Available</div><span class="st">Empty</span></div>
                </div>
            </div>
        </div>
        <div class="col-lg-4">
            <div class="panel h-100">
                <div class="panel-head"><h5><i class="bi bi-people"></i> Roommates</h5></div>
                <hr />
                <div class="mate"><div class="ph">RS</div><div class="flex-grow-1"><div class="nm">Rahul Sharma</div><div class="sb">B.Tech CS • 2nd Year</div></div><i class="bi bi-chat-left-text"></i></div>
                <div class="mate"><div class="ph">AK</div><div class="flex-grow-1"><div class="nm">Amit Kumar</div><div class="sb">BBA • 2nd Year</div></div><i class="bi bi-chat-left-text"></i></div>
                <div class="mate-empty"><i class="bi bi-person-plus" style="font-size:22px"></i><div><b>Bed 4 is empty</b><div style="font-size:12px">Awaiting assignment</div></div></div>
            </div>
        </div>
    </div>

    <div class="row g-3">
        <div class="col-lg-6">
            <div class="panel h-100">
                <div class="panel-head"><h5><i class="bi bi-archive"></i> Room Facilities</h5></div>
                <hr />
                <div class="fac-grid">
                    <div class="fac"><i class="bi bi-wifi"></i>High-Speed Wi-Fi</div>
                    <div class="fac"><i class="bi bi-fan"></i>Ceiling Fan</div>
                    <div class="fac"><i class="bi bi-table"></i>Study Tables (4)</div>
                    <div class="fac"><i class="bi bi-door-closed"></i>Wardrobes (4)</div>
                    <div class="fac"><i class="bi bi-plug"></i>Power Backup</div>
                    <div class="fac off"><i class="bi bi-snow"></i>AC (Not included)</div>
                </div>
            </div>
        </div>
        <div class="col-lg-6">
            <div class="panel h-100">
                <div class="panel-head"><h5><i class="bi bi-hammer"></i> Room Rules</h5><i class="bi bi-download"></i></div>
                <hr />
                <ul class="rules">
                    <li><i class="bi bi-check-circle"></i>Keep the room clean and maintain personal hygiene at all times.</li>
                    <li><i class="bi bi-volume-mute"></i>Maintain silence after 10:00 PM; respect roommates' study and sleep time.</li>
                    <li><i class="bi bi-lightning-charge"></i>High-wattage electrical appliances (heaters, hot plates) are strictly prohibited.</li>
                    <li><i class="bi bi-slash-circle"></i>Consumption of alcohol, smoking, or any illegal substances is strictly banned.</li>
                    <li><i class="bi bi-lock"></i>Always lock the door when leaving. Management is not responsible for lost valuables.</li>
                </ul>
            </div>
        </div>
    </div>

</asp:Content>