using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace HostelHub.Admin
{
    [Serializable]
    public class RoomRecord
    {
        public int Id { get; set; }
        public string RoomNumber { get; set; }
        public string Block { get; set; }
        public int Floor { get; set; }
        public int Capacity { get; set; }
        public int Occupied { get; set; }

        public int Available
        {
            get { return Capacity - Occupied; }
        }

        public string Status
        {
            get
            {
                if (Occupied == 0)
                    return "Empty";

                if (Occupied >= Capacity)
                    return "Full";

                if (Occupied < Capacity)
                    return "Available";

                return "Partial";
            }
        }
    }

    public partial class RoomManagement : Page
    {
        private const string SessionKey = "HostelHub_Rooms";
        private const int PageSize = 5;

        private List<RoomRecord> Rooms
        {
            get
            {
                if (Session[SessionKey] == null)
                {
                    Session[SessionKey] = new List<RoomRecord>
                    {
                        new RoomRecord { Id = 1, RoomNumber = "A-101", Block = "Block A", Floor = 1, Capacity = 4, Occupied = 4 },
                        new RoomRecord { Id = 2, RoomNumber = "A-102", Block = "Block A", Floor = 1, Capacity = 4, Occupied = 3 },
                        new RoomRecord { Id = 3, RoomNumber = "B-204", Block = "Block B", Floor = 2, Capacity = 4, Occupied = 2 },
                        new RoomRecord { Id = 4, RoomNumber = "C-305", Block = "Block C", Floor = 3, Capacity = 4, Occupied = 0 },
                        new RoomRecord { Id = 5, RoomNumber = "B-205", Block = "Block B", Floor = 2, Capacity = 3, Occupied = 1 },
                        new RoomRecord { Id = 6, RoomNumber = "C-306", Block = "Block C", Floor = 3, Capacity = 2, Occupied = 2 }
                    };
                }

                return (List<RoomRecord>)Session[SessionKey];
            }
            set
            {
                Session[SessionKey] = value;
            }
        }

        private int CurrentPage
        {
            get { return ViewState["RoomPage"] == null ? 0 : (int)ViewState["RoomPage"]; }
            set { ViewState["RoomPage"] = value; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
                BindRooms();
        }

        private void BindRooms()
        {
            List<RoomRecord> allRooms = Rooms;

            lblTotalRooms.Text = allRooms.Count.ToString();
            lblOccupiedBeds.Text = allRooms.Sum(r => r.Occupied).ToString();
            lblAvailableBeds.Text = allRooms.Sum(r => r.Available).ToString();

            IEnumerable<RoomRecord> query = allRooms;

            string search = (txtSearch.Text ?? "").Trim();
            string block = ddlBlockFilter.SelectedValue;
            string status = ddlStatusFilter.SelectedValue;

            if (!string.IsNullOrWhiteSpace(search))
            {
                query = query.Where(r =>
                    (r.RoomNumber ?? "").IndexOf(search, StringComparison.OrdinalIgnoreCase) >= 0 ||
                    (r.Block ?? "").IndexOf(search, StringComparison.OrdinalIgnoreCase) >= 0);
            }

            if (!string.IsNullOrWhiteSpace(block))
                query = query.Where(r => r.Block == block);

            if (!string.IsNullOrWhiteSpace(status))
                query = query.Where(r => r.Status == status);

            List<RoomRecord> filteredRooms = query
                .OrderBy(r => r.Block)
                .ThenBy(r => r.RoomNumber)
                .ToList();

            int totalPages = Math.Max(
                1,
                (int)Math.Ceiling(filteredRooms.Count / (double)PageSize));

            if (CurrentPage >= totalPages)
                CurrentPage = totalPages - 1;

            if (CurrentPage < 0)
                CurrentPage = 0;

            List<RoomRecord> pageRooms = filteredRooms
                .Skip(CurrentPage * PageSize)
                .Take(PageSize)
                .ToList();

            rptRooms.DataSource = pageRooms;
            rptRooms.DataBind();

            trNoRooms.Visible = pageRooms.Count == 0;

            lblPageInfo.Text = "Page " + (CurrentPage + 1) +
                               " of " + totalPages;

            btnPrevious.Enabled = CurrentPage > 0;
            btnNext.Enabled = CurrentPage < totalPages - 1;
        }

        protected string GetStatusCss(string status)
        {
            switch (status)
            {
                case "Full":
                    return "status-full";

                case "Empty":
                    return "status-empty";

                case "Partial":
                    return "status-partial";

                default:
                    return "status-available";
            }
        }

        protected void btnAddRoom_Click(object sender, EventArgs e)
        {
            ClearForm();
            lblFormTitle.Text = "Add Room";
            btnSaveRoom.Text = "Save Room";
            SetFormReadOnly(false);
            pnlRoomForm.Visible = true;

            lblMessage.CssClass = "text-success";
            lblMessage.Text = "";
        }

        protected void btnSaveRoom_Click(object sender, EventArgs e)
        {
            string roomNumber = txtRoomNumber.Text.Trim();
            string block = ddlBlock.SelectedValue;

            int floor;
            int capacity;
            int occupied;
            int id;

            if (string.IsNullOrWhiteSpace(roomNumber))
            {
                ShowError("Please enter a room number.");
                return;
            }

            if (!int.TryParse(txtFloor.Text, out floor) || floor < 0)
            {
                ShowError("Please enter a valid floor number.");
                return;
            }

            if (!int.TryParse(txtCapacity.Text, out capacity) || capacity <= 0)
            {
                ShowError("Capacity must be greater than zero.");
                return;
            }

            if (!int.TryParse(txtOccupied.Text, out occupied) ||
                occupied < 0 || occupied > capacity)
            {
                ShowError("Occupied beds must be between 0 and the room capacity.");
                return;
            }

            int.TryParse(hfRoomId.Value, out id);

            bool duplicate = Rooms.Any(r =>
                r.Id != id &&
                string.Equals(r.RoomNumber, roomNumber,
                    StringComparison.OrdinalIgnoreCase));

            if (duplicate)
            {
                ShowError("This room number already exists.");
                return;
            }

            if (id == 0)
            {
                int nextId = Rooms.Count == 0 ? 1 : Rooms.Max(r => r.Id) + 1;

                Rooms.Add(new RoomRecord
                {
                    Id = nextId,
                    RoomNumber = roomNumber,
                    Block = block,
                    Floor = floor,
                    Capacity = capacity,
                    Occupied = occupied
                });

                lblMessage.CssClass = "text-success";
                lblMessage.Text = "Room added successfully.";
            }
            else
            {
                RoomRecord room = Rooms.FirstOrDefault(r => r.Id == id);

                if (room == null)
                {
                    ShowError("Room record was not found.");
                    BindRooms();
                    return;
                }

                room.RoomNumber = roomNumber;
                room.Block = block;
                room.Floor = floor;
                room.Capacity = capacity;
                room.Occupied = occupied;

                lblMessage.CssClass = "text-success";
                lblMessage.Text = "Room updated successfully.";
            }

            HideForm();
            CurrentPage = 0;
            BindRooms();
        }

        protected void btnCancelRoom_Click(object sender, EventArgs e)
        {
            HideForm();
            lblMessage.Text = "";
            BindRooms();
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            CurrentPage = 0;
            BindRooms();
        }

        protected void btnPrevious_Click(object sender, EventArgs e)
        {
            if (CurrentPage > 0)
                CurrentPage--;

            BindRooms();
        }

        protected void btnNext_Click(object sender, EventArgs e)
        {
            CurrentPage++;
            BindRooms();
        }

        protected void rptRooms_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            int id;

            if (!int.TryParse(Convert.ToString(e.CommandArgument), out id))
                return;

            RoomRecord room = Rooms.FirstOrDefault(r => r.Id == id);

            if (room == null)
            {
                ShowError("Room record was not found.");
                BindRooms();
                return;
            }

            if (e.CommandName == "DeleteRoom")
            {
                Rooms.Remove(room);

                lblMessage.CssClass = "text-success";
                lblMessage.Text = "Room deleted successfully.";

                BindRooms();
            }
            else if (e.CommandName == "EditRoom")
            {
                LoadRoomIntoForm(room);
                lblFormTitle.Text = "Edit Room";
                btnSaveRoom.Text = "Update Room";
                SetFormReadOnly(false);
                pnlRoomForm.Visible = true;

                lblMessage.Text = "";
            }
            else if (e.CommandName == "ViewRoom")
            {
                LoadRoomIntoForm(room);
                lblFormTitle.Text = "Room Details";
                SetFormReadOnly(true);
                pnlRoomForm.Visible = true;

                lblMessage.Text = "";
            }
        }

        private void LoadRoomIntoForm(RoomRecord room)
        {
            hfRoomId.Value = room.Id.ToString();
            txtRoomNumber.Text = room.RoomNumber;
            ddlBlock.SelectedValue = room.Block;
            txtFloor.Text = room.Floor.ToString();
            txtCapacity.Text = room.Capacity.ToString();
            txtOccupied.Text = room.Occupied.ToString();
        }

        private void ClearForm()
        {
            hfRoomId.Value = "";
            txtRoomNumber.Text = "";
            ddlBlock.SelectedValue = "Block A";
            txtFloor.Text = "1";
            txtCapacity.Text = "4";
            txtOccupied.Text = "0";
        }

        private void SetFormReadOnly(bool readOnly)
        {
            txtRoomNumber.ReadOnly = readOnly;
            ddlBlock.Enabled = !readOnly;
            txtFloor.ReadOnly = readOnly;
            txtCapacity.ReadOnly = readOnly;
            txtOccupied.ReadOnly = readOnly;

            btnSaveRoom.Visible = !readOnly;
        }

        private void HideForm()
        {
            pnlRoomForm.Visible = false;
            SetFormReadOnly(false);
            ClearForm();
        }

        private void ShowError(string message)
        {
            lblMessage.CssClass = "text-danger";
            lblMessage.Text = message;
            pnlRoomForm.Visible = true;
        }
    }
}