From: Tony Luck <tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 3/5] acpi,
 nfit: Add function to look up nvdimm device and provide SMBIOS handle
Date: Thu, 22 Feb 2018 11:58:09 -0800
Message-ID: <20180222195811.27237-4-tony.luck@intel.com>
References: <20180222195811.27237-1-tony.luck@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
In-Reply-To: <20180222195811.27237-1-tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
List-Help: <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=subscribe>
Errors-To: linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
To: Borislav Petkov <bp-l3A5Bk7waGM@public.gmane.org>
Cc: Jean Delvare <jdelvare-IBi9RG/b67k@public.gmane.org>, linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org, Aristeu Rozanski <aris-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Qiuxu Zhuo <qiuxu.zhuo-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tony Luck <tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Borislav Petkov <bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org>, Lv Zheng <lv.zheng-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Mauro Carvalho Chehab <mchehab-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

EDAC driver needs to look up attributes of NVDIMMs provided in SMBIOS.

Provide a function that looks up an acpi_nfit_memory_map from a device
handle (node/socket/mc/channel/dimm) and returns the SMBIOS handle.
Also pass back the "flags" so we can see if the NVDIMM is OK.

Signed-off-by: Tony Luck <tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 drivers/acpi/nfit/core.c | 27 +++++++++++++++++++++++++++
 include/acpi/nfit.h      | 26 ++++++++++++++++++++++++++
 2 files changed, 53 insertions(+)
 create mode 100644 include/acpi/nfit.h

diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index bbe48ad20886..4d6eeb1793e6 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -23,6 +23,7 @@
 #include <linux/io.h>
 #include <linux/nd.h>
 #include <asm/cacheflush.h>
+#include <acpi/nfit.h>
 #include "nfit.h"
 
 /*
@@ -690,6 +691,32 @@ static bool add_memdev(struct acpi_nfit_desc *acpi_desc,
 	return true;
 }
 
+int nfit_get_smbios_id(u32 device_handle, u16 *flags)
+{
+	struct acpi_nfit_memory_map *memdev;
+	struct acpi_nfit_desc *acpi_desc;
+	struct nfit_mem *nfit_mem;
+
+	mutex_lock(&acpi_desc_lock);
+	list_for_each_entry(acpi_desc, &acpi_descs, list) {
+		mutex_lock(&acpi_desc->init_mutex);
+		list_for_each_entry(nfit_mem, &acpi_desc->dimms, list) {
+			memdev = __to_nfit_memdev(nfit_mem);
+			if (memdev->device_handle == device_handle) {
+				mutex_unlock(&acpi_desc->init_mutex);
+				mutex_unlock(&acpi_desc_lock);
+				*flags = memdev->flags;
+				return memdev->physical_id;
+			}
+		}
+		mutex_unlock(&acpi_desc->init_mutex);
+	}
+	mutex_unlock(&acpi_desc_lock);
+
+	return -ENODEV;
+}
+EXPORT_SYMBOL_GPL(nfit_get_smbios_id);
+
 /*
  * An implementation may provide a truncated control region if no block windows
  * are defined.
diff --git a/include/acpi/nfit.h b/include/acpi/nfit.h
new file mode 100644
index 000000000000..6ccc6eacd855
--- /dev/null
+++ b/include/acpi/nfit.h
@@ -0,0 +1,26 @@
+/*
+ * Copyright(c) 2017 Intel Corporation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of version 2 of the GNU General Public License as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ */
+
+#ifndef __ACPI_NFIT_H
+#define __ACPI_NFIT_H
+
+#if IS_ENABLED(CONFIG_ACPI_NFIT)
+int nfit_get_smbios_id(u32 device_handle, u16 *flags);
+#else
+static inline int nfit_get_smbios_id(u32 device_handle, u16 *flags)
+{
+	return -EOPNOTSUPP;
+}
+#endif
+
+#endif /* __ACPI_NFIT_H */
-- 
2.14.1
