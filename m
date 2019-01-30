From: Dexuan Cui <decui-0li6OtcxBFHby3iVrkZq2A@public.gmane.org>
Subject: [PATCH] nfit: Collect shutdown status for NVDIMM_FAMILY_HYPERV
Date: Wed, 30 Jan 2019 18:48:40 +0000
Message-ID: <PU1P153MB01691690696D8F83FC1872C7BF900@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
List-Help: <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=subscribe>
Errors-To: linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
To: Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Ross Zwisler <zwisler-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Vishal Verma <vishal.l.verma-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Dave Jiang <dave.jiang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org" <linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>, "linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Josh Poulson <jopoulso-0li6OtcxBFHby3iVrkZq2A@public.gmane.org>, Stephen Hemminger <sthemmin-0li6OtcxBFHby3iVrkZq2A@public.gmane.org>, Haiyang Zhang <haiyangz-0li6OtcxBFHby3iVrkZq2A@public.gmane.org>, "driverdev-devel-tBiZLqfeLfOHmIFyCCdPziST3g8Odh+X@public.gmane.org" <driverdev-devel-tBiZLqfeLfOHmIFyCCdPziST3g8Odh+X@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Michael Kelley <mikelley-0li6OtcxBFHby3iVrkZq2A@public.gmane.org>, Sasha Levin <Alexander.Levin-0li6OtcxBFHby3iVrkZq2A@public.gmane.org>, KY Srinivasan <kys-0li6OtcxBFHby3iVrkZq2A@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


See http://www.uefi.org/RFIC_LIST ("Virtual NVDIMM 0x1901"):
"Get Unsafe Shutdown Count (Function Index 2)".

Let's expose the info to the userspace (e.g. ntctl) via sysfs.

Signed-off-by: Dexuan Cui <decui-0li6OtcxBFHby3iVrkZq2A@public.gmane.org>
---
 drivers/acpi/nfit/core.c   | 51 ++++++++++++++++++++++++++++++++++++++
 drivers/acpi/nfit/hyperv.h | 26 +++++++++++++++++++
 2 files changed, 77 insertions(+)
 create mode 100644 drivers/acpi/nfit/hyperv.h

diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index d5a164b6833a..d504da34ce34 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -25,6 +25,7 @@
 #include <asm/cacheflush.h>
 #include <acpi/nfit.h>
 #include "intel.h"
+#include "hyperv.h"
 #include "nfit.h"
 
 /*
@@ -1802,6 +1803,54 @@ __weak void nfit_intel_shutdown_status(struct nfit_mem *nfit_mem)
 	}
 }
 
+__weak void nfit_hyperv_shutdown_status(struct nfit_mem *nfit_mem)
+{
+	struct device *dev = &nfit_mem->adev->dev;
+	struct nd_hyperv_shutdown_status status;
+	union acpi_object in_buf = {
+		.buffer.type = ACPI_TYPE_BUFFER,
+		.buffer.length = 0,
+	};
+	union acpi_object in_obj = {
+		.package.type = ACPI_TYPE_PACKAGE,
+		.package.count = 1,
+		.package.elements = &in_buf,
+	};
+	const u8 func = ND_HYPERV_GET_UNSAFE_SHUTDOWN_COUNT;
+	const guid_t *guid = to_nfit_uuid(nfit_mem->family);
+	u8 revid = nfit_dsm_revid(nfit_mem->family, func);
+	struct acpi_device *adev = nfit_mem->adev;
+	acpi_handle handle = adev->handle;
+	union acpi_object *out_obj;
+
+	if ((nfit_mem->dsm_mask & BIT(func)) == 0)
+		return;
+
+	out_obj = acpi_evaluate_dsm(handle, guid, revid, func, &in_obj);
+	if (!out_obj || out_obj->type != ACPI_TYPE_BUFFER
+		     || out_obj->buffer.length < sizeof(status)) {
+		dev_dbg(dev->parent,
+			"%s: failed to get Unsafe Shutdown Count\n",
+			dev_name(dev));
+		ACPI_FREE(out_obj);
+		return;
+	}
+
+	memcpy(&status, out_obj->buffer.pointer, sizeof(status));
+	ACPI_FREE(out_obj);
+
+	if (status.general_err != 0) {
+		dev_dbg(dev->parent,
+			"%s: failed to get Unsafe Shutdown Count: err=0x%x\n",
+			dev_name(dev), status.status);
+		return;
+	}
+
+	set_bit(NFIT_MEM_DIRTY_COUNT, &nfit_mem->flags);
+	nfit_mem->dirty_shutdown = status.shutdown_count;
+}
+
+
 static void populate_shutdown_status(struct nfit_mem *nfit_mem)
 {
 	/*
@@ -1811,6 +1860,8 @@ static void populate_shutdown_status(struct nfit_mem *nfit_mem)
 	 */
 	if (nfit_mem->family == NVDIMM_FAMILY_INTEL)
 		nfit_intel_shutdown_status(nfit_mem);
+	else if (nfit_mem->family == NVDIMM_FAMILY_HYPERV)
+		nfit_hyperv_shutdown_status(nfit_mem);
 }
 
 static int acpi_nfit_add_dimm(struct acpi_nfit_desc *acpi_desc,
diff --git a/drivers/acpi/nfit/hyperv.h b/drivers/acpi/nfit/hyperv.h
new file mode 100644
index 000000000000..c4a25b8624cc
--- /dev/null
+++ b/drivers/acpi/nfit/hyperv.h
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright(c) 2019 Microsoft Corporation. All rights reserved.
+ * Hyper-V specific definitions for _DSM of Hyper-V Virtual NVDIMM
+ *
+ * See http://www.uefi.org/RFIC_LIST (Virtual NVDIMM 0x1901)
+ */
+#ifndef _NFIT_HYPERV_H_
+#define _NFIT_HYPERV_H_
+
+#define ND_HYPERV_GET_UNSAFE_SHUTDOWN_COUNT 2
+
+struct nd_hyperv_shutdown_status {
+	union {
+		u32 status;
+		struct {
+			u16 general_err;
+			u8  func_err;
+			u8  vendor_err;
+		};
+	};
+	u32 shutdown_count;
+} __packed;
+
+
+#endif
-- 
2.19.1
