using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using CrystalDecisions.CrystalReports.Engine;

namespace ToaThuoc
{
    public partial class FormXemDonThuoc : Form
    {
        private ReportDocument _report;

        public FormXemDonThuoc(ReportDocument report)
        {
            InitializeComponent();
            _report = report;
        }

        private void FormXemDonThuoc_Load(object sender, EventArgs e)
        {
            crystalReportViewer1.ReportSource = _report;
            crystalReportViewer1.Refresh();
            crystalReportViewer1.Padding = new Padding(200, 0, 200, 0);
        }
    }
}