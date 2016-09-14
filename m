From: Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 0/2] nfit: fail DSMs that return an unknown status value
Date: Tue, 13 Sep 2016 18:28:47 -0700
Message-ID: <147381652762.13555.2547727388390513900.stgit@dwillia2-desk3.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
List-Help: <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=subscribe>
Errors-To: linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
To: linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org
Cc: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

When the kernel knows the format of a DSM and is consuming the data
internal to the kernel, it needs to be careful to fail DSMs that return
an error.  Recall that DSMs, ACPI Device Specific Methods, are used by
the kernel to manipulate namespace label data, and scan for media
errors.  For example, if a namespace label read command fails the
returned data is undefined and should not be consumed by the libnvdimm
core to make namespace provisioning decisions.

Also, add new unit test capability to allow dynamic failure injection
for DSMs sent to nfit_test devices.

---

Dan Williams (2):
      nfit: fail DSMs that return non-zero status by default
      tools/testing/nvdimm: test get_config_size DSM failures


 drivers/acpi/nfit/core.c         |   48 +++++++++++++----------
 tools/testing/nvdimm/test/nfit.c |   79 +++++++++++++++++++++++++++++++++++++-
 2 files changed, 105 insertions(+), 22 deletions(-)
