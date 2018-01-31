From: Dave Jiang <dave.jiang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v4 0/4] add support for platform persistence capabilities
Date: Tue, 30 Jan 2018 17:21:16 -0700
Message-ID: <151735800899.47256.2204307128644539213.stgit@djiang5-desk3.ch.intel.com>
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
To: dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, ross.zwisler-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
Cc: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

ACPI 6.2a provides an NFIT sub-table that informs if the platform has
auto CPU flush and memory flush on unexpected power loss events. This series
propogates those attributes to nd_region and add sysfs attribute to show
those capabilities.

v4:
Fixed typos and added Reviewed-by tags from Ross.

v3:
Addressed Ross's comments
- fixed mask calculation for platform cap
- fixed nfit_test nfit_buf size calcuation
- fixed offset for test data structure

v2:
Per Dan's comments
- Added ADR cap flags propogation
- Added sysfs attribute

---

Dave Jiang (4):
      acpi: nfit: Add support for detect platform CPU cache flush on power loss
      acpi: nfit: add persistent memory control flag for nd_region
      libnvdimm: expose platform persistence attribute for nd_region
      nfit-test: Add platform cap support from ACPI 6.2a to test


 drivers/acpi/nfit/core.c         |   23 +++++++++++++++++++++++
 drivers/acpi/nfit/nfit.h         |    1 +
 drivers/nvdimm/pmem.c            |    4 +++-
 drivers/nvdimm/region_devs.c     |   13 +++++++++++++
 include/linux/libnvdimm.h        |   11 +++++++++++
 tools/testing/nvdimm/test/nfit.c |   14 ++++++++++++--
 6 files changed, 63 insertions(+), 3 deletions(-)

--
Signature
