<%@ Page Title="Mess Feedback" MasterPageFile="~/StudentLayout.master" Language="C#" AutoEventWireup="true" CodeBehind="MessFeedback.aspx.cs" Inherits="HostelHub.Student.MessFeedback" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <h1 class="page-title">Mess Feedback</h1>
    <p class="page-sub">Help us improve the dining experience by sharing your daily ratings.</p>

    <div class="row g-3">
        <div class="col-lg-5">
            <div class="panel">
                <h5 class="fw-bold"><i class="bi bi-star text-primary"></i> Rate Today's Meals</h5>
                <hr />

                <div class="rate-lbl">Taste</div>
                <div class="rate"><i class="bi bi-star-fill on"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><span class="rv">1/5</span></div>

                <div class="rate-lbl">Quality</div>
                <div class="rate"><i class="bi bi-star-fill on"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><span class="rv">1/5</span></div>

                <div class="rate-lbl">Hygiene</div>
                <div class="rate"><i class="bi bi-star-fill on"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><span class="rv">1/5</span></div>

                <div class="fgrp">
                    <div class="rate-lbl mb-2">Additional Comments</div>
                    <textarea class="form-control-hh" rows="3" placeholder="Share specific details (optional)..."></textarea>
                </div>
                <button type="button" class="btn-hh-dark btn-block">Submit Feedback ➤</button>
            </div>
        </div>

        <div class="col-lg-7">
            <div class="table-card h-100">
                <div class="panel-head" style="padding:16px"><h5><i class="bi bi-clock-history"></i> Feedback History</h5><span style="font-size:13px;font-weight:600;color:var(--hh-muted)">Last 30 Days</span></div>
                <table class="hh-table">
                    <thead><tr><th>Date</th><th>Taste</th><th>Quality</th><th>Hygiene</th><th>Comments</th></tr></thead>
                    <tbody>
                        <tr><td>Oct 24, 2023</td><td>3/5</td><td>3/5</td><td>3/5</td><td>Very Good</td></tr>
                        <tr><td>Oct 23, 2023</td><td>2/5</td><td>2/5</td><td>2/5</td><td><i>Good</i></td></tr>
                        <tr><td>Oct 22, 2023</td><td>4/5</td><td>4/5</td><td>4/5</td><td>Excellent</td></tr>
                    </tbody>
                </table>
                <div class="table-foot" style="justify-content:center"><a class="link-btn">View Full History →</a></div>
            </div>
        </div>
    </div>

    <script>
// Star rating: click karne par us tak ke stars bhar jaate hain
document.querySelectorAll('.rate').forEach(function (group) {
    var stars = group.querySelectorAll('i');
    var label = group.querySelector('.rv');
    stars.forEach(function (star, index) {
        star.addEventListener('click', function () {
            stars.forEach(function (s, i) { s.classList.toggle('on', i <= index); });
            label.textContent = (index + 1) + '/5';
        });
    });
});
</script>

</asp:Content>