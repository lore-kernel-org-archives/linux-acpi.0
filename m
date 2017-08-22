From: Vishal Verma <vishal.l.verma-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v6 5/6] libnvdimm: fix potential deadlock while clearing errors
Date: Tue, 22 Aug 2017 16:19:14 -0600
Message-ID: <20170822221915.1732-6-vishal.l.verma@intel.com>
References: <20170822221915.1732-1-vishal.l.verma@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
In-Reply-To: <20170822221915.1732-1-vishal.l.verma-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
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
Cc: "Rafael J . Wysocki" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Robert Moore <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

With the ACPI NFIT 'DSM' methods, acpi can be called from IO paths.
Specifically, the DSM to clear media errors is called during writes, so
that we can provide a writes-fix-errors model.

However it is easy to imagine a scenario like:
 -> write through the nvdimm driver
   -> acpi allocation
     -> writeback, causes more IO through the nvdimm driver
       -> deadlock

Fix this by using memalloc_noio_{save,restore}, which sets the GFP_NOIO
flag for the current scope when issuing commands/IOs that are expected
to clear errors.

Cc: <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: <linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
Cc: Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Robert Moore <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Rafael J. Wysocki <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Signed-off-by: Vishal Verma <vishal.l.verma-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 drivers/nvdimm/bus.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/nvdimm/bus.c b/drivers/nvdimm/bus.c
index 937fafa..a18c291 100644
--- a/drivers/nvdimm/bus.c
+++ b/drivers/nvdimm/bus.c
@@ -11,6 +11,7 @@
  * General Public License for more details.
  */
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+#include <linux/sched/mm.h>
 #include <linux/vmalloc.h>
 #include <linux/uaccess.h>
 #include <linux/module.h>
@@ -234,6 +235,7 @@ long nvdimm_clear_poison(struct device *dev, phys_addr_t phys,
 	struct nd_cmd_clear_error clear_err;
 	struct nd_cmd_ars_cap ars_cap;
 	u32 clear_err_unit, mask;
+	unsigned int noio_flag;
 	int cmd_rc, rc;
 
 	if (!nvdimm_bus)
@@ -250,8 +252,10 @@ long nvdimm_clear_poison(struct device *dev, phys_addr_t phys,
 	memset(&ars_cap, 0, sizeof(ars_cap));
 	ars_cap.address = phys;
 	ars_cap.length = len;
+	noio_flag = memalloc_noio_save();
 	rc = nd_desc->ndctl(nd_desc, NULL, ND_CMD_ARS_CAP, &ars_cap,
 			sizeof(ars_cap), &cmd_rc);
+	memalloc_noio_restore(noio_flag);
 	if (rc < 0)
 		return rc;
 	if (cmd_rc < 0)
@@ -266,8 +270,10 @@ long nvdimm_clear_poison(struct device *dev, phys_addr_t phys,
 	memset(&clear_err, 0, sizeof(clear_err));
 	clear_err.address = phys;
 	clear_err.length = len;
+	noio_flag = memalloc_noio_save();
 	rc = nd_desc->ndctl(nd_desc, NULL, ND_CMD_CLEAR_ERROR, &clear_err,
 			sizeof(clear_err), &cmd_rc);
+	memalloc_noio_restore(noio_flag);
 	if (rc < 0)
 		return rc;
 	if (cmd_rc < 0)
-- 
2.9.3
