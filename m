From: Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 0/3] libvdimm: Support namespace enumeration while locked
Date: Thu, 14 Jun 2018 17:37:14 -0700
Message-ID: <152902303439.10541.13027910074116606464.stgit@dwillia2-desk3.amr.corp.intel.com>
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

The NVDIMM_FAMILY_INTEL DSM path for manipulating labels explicitly
allows reading the namespace label area while the DIMM is locked. In
contrast the ACPI _LSR method for reading labels only indicates if the
label area is locked and returns no data.

It naturally follows that if the namespace label area is locked, the
DIMM is locked since the driver is prevented from discovering namespace
boundaries.

On platforms where both mechanisms are available, prefer the
NVDIMM_FAMILY_INTEL implementation and support enumerating namespace
boundaries while the DIMM is locked.

In addition to ACPI capability detection and the libnvdimm core change
to fail probe of locked namespaces, provide a capability to inject this
semantic difference via nfit_test.

---

Dan Williams (3):
      libnvdimm: Introduce locked DIMM capacity support
      acpi, nfit: Prefer _DSM over _LSR for namespace label reads
      tools/testing/nvdimm: Make DSM failure code injection an override


 drivers/acpi/nfit/core.c         |   12 +++++++++
 drivers/nvdimm/dimm.c            |   24 +++++++++++++++++--
 drivers/nvdimm/namespace_devs.c  |   23 ++++++++++++++++++
 drivers/nvdimm/nd.h              |    1 +
 tools/testing/nvdimm/test/nfit.c |   49 +++++++++++++++++++++++++-------------
 5 files changed, 89 insertions(+), 20 deletions(-)
