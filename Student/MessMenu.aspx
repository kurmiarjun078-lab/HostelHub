<%@ Page Title="Mess Menu" MasterPageFile="~/StudentLayout.master" Language="C#" AutoEventWireup="true" CodeBehind="MessMenu.aspx.cs" Inherits="HostelHub.Student.MessMenu" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <div class="page-head">
        <div>
            <h1 class="page-title">Mess Menu</h1>
            <p class="page-sub">Manage daily meals and review student feedback.</p>
        </div>
        <div class="page-actions"><a class="btn-sm-hh"><i class="bi bi-calendar3"></i> Current Week</a></div>
    </div>

    <div class="row g-3 mb-3">
        <div class="col-lg-8">
            <h5 class="fw-bold mb-3"><i class="bi bi-calendar-event text-primary"></i> Today's Menu</h5>
            <div class="row g-3">
                <div class="col-md-4"><div class="menu-card">
                    <div class="hd"><div class="ico"><i class="bi bi-brightness-high"></i></div><div><b>Breakfast</b><small>07:30 AM - 09:30 AM</small></div></div>
                    <ul><li><i class="bi bi-check-circle"></i>Idli Sambar</li><li><i class="bi bi-check-circle"></i>Coconut Chutney</li><li><i class="bi bi-check-circle"></i>Boiled Eggs / Banana</li><li><i class="bi bi-check-circle"></i>Tea &amp; Coffee</li></ul>
                </div></div>
                <div class="col-md-4"><div class="menu-card now">
                    <div class="hd"><div class="ico"><i class="bi bi-egg-fried"></i></div><div><b>Lunch</b><small>12:30 PM - 02:30 PM</small></div></div>
                    <ul><li><i class="bi bi-check-circle"></i>Paneer Butter Masala</li><li><i class="bi bi-check-circle"></i>Dal Tadka</li><li><i class="bi bi-check-circle"></i>Jeera Rice &amp; Roti</li><li><i class="bi bi-check-circle"></i>Mixed Salad &amp; Curd</li></ul>
                </div></div>
                <div class="col-md-4"><div class="menu-card">
                    <div class="hd"><div class="ico"><i class="bi bi-moon-stars"></i></div><div><b>Dinner</b><small>07:30 PM - 09:30 PM</small></div></div>
                    <ul><li><i class="bi bi-check-circle"></i>Chicken Curry / Soya Chaap</li><li><i class="bi bi-check-circle"></i>Mixed Veg</li><li><i class="bi bi-check-circle"></i>Steamed Rice &amp; Roti</li><li><i class="bi bi-check-circle"></i>Gulab Jamun</li></ul>
                </div></div>
            </div>
        </div>

        <div class="col-lg-4">
            <h5 class="fw-bold mb-3"><i class="bi bi-chat-square-text text-primary"></i> Feedback Overview</h5>
            <div class="panel">
                <div class="d-flex justify-content-between align-items-center mb-3">
                    <div><b style="font-size:17px">Today's Rating</b><div style="font-size:12px;color:var(--hh-muted)">Based on 142 reviews</div></div>
                    <span class="rating-pill"><i class="bi bi-star-fill text-primary"></i> 4.2</span>
                </div>
                <div class="rate-row"><div class="top"><span>Taste</span><span>4.5/5</span></div><div class="bar"><div class="bar-fill" style="width:90%"></div></div></div>
                <div class="rate-row"><div class="top"><span>Quality</span><span>4.0/5</span></div><div class="bar"><div class="bar-fill" style="width:80%"></div></div></div>
                <div class="rate-row"><div class="top"><span>Hygiene</span><span>4.2/5</span></div><div class="bar"><div class="bar-fill" style="width:84%"></div></div></div>
                <hr />
                <a class="btn-sm-hh" style="width:100%;justify-content:center">View Detailed Feedback →</a>
            </div>
        </div>
    </div>

    <div class="table-card">
        <div class="panel-head" style="padding:16px"><h5>Weekly Menu Schedule</h5><i class="bi bi-download text-primary"></i></div>
        <table class="hh-table">
            <thead><tr><th>Day</th><th>Breakfast</th><th>Lunch</th><th>Dinner</th></tr></thead>
            <tbody>
                <tr><td><b>Monday</b></td><td>Poha, Jalebi, Tea/Coffee</td><td>Rajma, Rice, Roti, Salad</td><td>Aloo Gobi, Dal, Roti, Kheer</td></tr>
                <tr><td><b>Tuesday</b></td><td>Idli Sambar, Chutney, Tea</td><td>Paneer Masala, Dal, Rice, Roti</td><td>Chicken/Soya, Veg, Rice, Roti</td></tr>
                <tr><td><b>Wednesday</b></td><td>Aloo Paratha, Curd, Pickle</td><td>Kadi Pakora, Rice, Roti, Papad</td><td>Mix Veg, Dal Tadka, Roti, Rice</td></tr>
                <tr><td><b>Thursday</b></td><td>Upma, Sev, Tea/Coffee</td><td>Chole Bhature, Lassi, Salad</td><td>Egg Curry/Paneer, Rice, Roti</td></tr>
                <tr><td><b>Friday</b></td><td>Puri Sabzi, Tea/Coffee</td><td>Veg Biryani, Raita, Salan</td><td>Dal Makhani, Naan, Rice, Ice Cream</td></tr>
            </tbody>
        </table>
    </div>

</asp:Content>