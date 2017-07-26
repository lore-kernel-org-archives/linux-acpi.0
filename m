From: Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH v4 5/6] libnvdimm: fix potential deadlock while clearing errors
Date: Wed, 26 Jul 2017 17:35:45 -0600
Message-ID: <20170726233546.29052-6-vishal.l.verma@intel.com>
References: <20170726233546.29052-1-vishal.l.verma@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:21047 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751445AbdGZXho (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 26 Jul 2017 19:37:44 -0400
In-Reply-To: <20170726233546.29052-1-vishal.l.verma@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-nvdimm@lists.01.org
Cc: linux-acpi@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>, Jeff Moyer <jmoyer@redhat.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Toshi Kani <toshi.kani@hpe.com>, Vishal Verma <vishal.l.verma@intel.com>, Robert Moore <robert.moore@intel.com>

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

Cc: <linux-acpi@vger.kernel.org>
Cc: <linux-nvdimm@lists.01.org>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Robert Moore <robert.moore@intel.com>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
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

