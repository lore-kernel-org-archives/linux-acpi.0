Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B760A426405;
	Tue, 15 Sep 2026 03:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789443252; cv=none; b=fTYV8EqGUEpSMiK4r6iAU3mXxlc/fX1HAhE7d1ca4pXEW7a68oTvn2JZEtPo9EMwC1gpwuSPfqOfS8P5X/deFB3H41JtlP6zSL9FXb9FhThdNhBBPT6ARUYKCmj3YSTLVYkLU1hHzi6Ux34nARB/IhDLtO9xCVJLpqimobgV1Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789443252; c=relaxed/simple;
	bh=JzCgfgnjy2JPWalQK5IBYVVz1/aVwTTTxRwXSpwTo6c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NGy/vRbakmvPm5ZMtBdeXdZJ3wAo/Vb/H3o+nOPA5yk2o9zQOJNv/B3Amb9wnQJs4oJZXeEstwKk7093quDrCF0UmWtENFF+PZXUHf3vdpTeYJDs1AZv9KxYbDidGS07SoreYRy0y7qnFCH8aylVEfxqCQf41WQMeiBzNlj9aU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8Cx_9KjvKhqsBEMAA--.35208S3;
	Tue, 15 Sep 2026 11:33:55 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by front1 (Coremail) with SMTP id qMiowJAxHs+bvKhqkd0gAA--.36959S4;
	Tue, 15 Sep 2026 11:33:54 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Pawel Chmielewski <pawel.chmielewski@intel.com>
Cc: Len Brown <lenb@kernel.org>,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	lixianglai@loongson.cn
Subject: [PATCH v3 2/4] ACPI: LoongArch: Add acpi_arch_[late]_init()
Date: Tue, 15 Sep 2026 11:26:25 +0800
Message-Id: <20260915032627.2796747-3-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20260915032627.2796747-1-maobibo@loongson.cn>
References: <20260915032627.2796747-1-maobibo@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJAxHs+bvKhqkd0gAA--.36959S4
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==

LoongArch IOMMU scanning flow is similar with virtio-iommu,
there is early init and late_init. In early init function, PCI
ACS is enabled if there is IOMMU table, and late_init is called
after PCI device scanning, where IOVT table scanning function is
executed.

Here add acpi_arch_init() and acpi_arch_late_init() API on LoongArch,
function acpi_iovt_init() is to enable PCI ACS function if IOMMU device
exists in IOVT table, and function acpi_iovt_late_init() is to scan
IOVT table, add IOMMU devices.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 drivers/acpi/Kconfig            |   4 +
 drivers/acpi/Makefile           |   2 +-
 drivers/acpi/bus.c              |   2 +
 drivers/acpi/loongarch/Kconfig  |   7 +
 drivers/acpi/loongarch/Makefile |   3 +
 drivers/acpi/loongarch/init.c   |  16 +++
 drivers/acpi/loongarch/init.h   |   5 +
 drivers/acpi/loongarch/iovt.c   | 219 ++++++++++++++++++++++++++++++++
 include/linux/acpi.h            |   1 +
 9 files changed, 258 insertions(+), 1 deletion(-)
 create mode 100644 drivers/acpi/loongarch/Kconfig
 create mode 100644 drivers/acpi/loongarch/Makefile
 create mode 100644 drivers/acpi/loongarch/init.c
 create mode 100644 drivers/acpi/loongarch/init.h
 create mode 100644 drivers/acpi/loongarch/iovt.c

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index f165d14cf61a..192e6f18eda1 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -550,6 +550,10 @@ if ARM64
 source "drivers/acpi/arm64/Kconfig"
 endif
 
+if LOONGARCH
+source "drivers/acpi/loongarch/Kconfig"
+endif
+
 if RISCV
 source "drivers/acpi/riscv/Kconfig"
 endif
diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index d1b0affb844f..91584a3c1e01 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -131,6 +131,6 @@ obj-y				+= dptf/
 obj-$(CONFIG_ARM64)		+= arm64/
 
 obj-$(CONFIG_ACPI_VIOT)		+= viot.o
-
+obj-$(CONFIG_LOONGARCH)		+= loongarch/
 obj-$(CONFIG_RISCV)		+= riscv/
 obj-$(CONFIG_X86)		+= x86/
diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 808c6746be14..33d752eacde3 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -1465,6 +1465,7 @@ struct kobject *acpi_kobj;
 EXPORT_SYMBOL_GPL(acpi_kobj);
 
 void __weak __init acpi_arch_init(void) { }
+void __weak __init acpi_arch_late_init(void) { }
 
 static int __init acpi_init(void)
 {
@@ -1503,6 +1504,7 @@ static int __init acpi_init(void)
 	acpi_wakeup_device_init();
 	acpi_debugger_init();
 	acpi_setup_sb_notify_handler();
+	acpi_arch_late_init();
 	acpi_viot_init();
 	return 0;
 }
diff --git a/drivers/acpi/loongarch/Kconfig b/drivers/acpi/loongarch/Kconfig
new file mode 100644
index 000000000000..91ba3c35b9bf
--- /dev/null
+++ b/drivers/acpi/loongarch/Kconfig
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# ACPI Configuration for LOONGARCH
+#
+
+config ACPI_IOVT
+	bool
diff --git a/drivers/acpi/loongarch/Makefile b/drivers/acpi/loongarch/Makefile
new file mode 100644
index 000000000000..c338d3102fc1
--- /dev/null
+++ b/drivers/acpi/loongarch/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0-only
+obj-y					+= init.o
+obj-$(CONFIG_ACPI_IOVT)			+= iovt.o
diff --git a/drivers/acpi/loongarch/init.c b/drivers/acpi/loongarch/init.c
new file mode 100644
index 000000000000..e7272ee197c7
--- /dev/null
+++ b/drivers/acpi/loongarch/init.c
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/acpi.h>
+#include "init.h"
+
+void __init acpi_arch_init(void)
+{
+	if (IS_ENABLED(CONFIG_ACPI_IOVT))
+		acpi_iovt_init();
+}
+
+void __init acpi_arch_late_init(void)
+{
+	if (IS_ENABLED(CONFIG_ACPI_IOVT))
+		acpi_iovt_late_init();
+}
diff --git a/drivers/acpi/loongarch/init.h b/drivers/acpi/loongarch/init.h
new file mode 100644
index 000000000000..85e5197553ad
--- /dev/null
+++ b/drivers/acpi/loongarch/init.h
@@ -0,0 +1,5 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#include <linux/init.h>
+
+void __init acpi_iovt_init(void);
+void __init acpi_iovt_late_init(void);
diff --git a/drivers/acpi/loongarch/iovt.c b/drivers/acpi/loongarch/iovt.c
new file mode 100644
index 000000000000..302ca6a75905
--- /dev/null
+++ b/drivers/acpi/loongarch/iovt.c
@@ -0,0 +1,219 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/acpi.h>
+#include <linux/pci.h>
+#include "init.h"
+
+struct iovt_device_entry {
+	struct list_head list;
+	int start_devid;
+	int end_devid;
+};
+
+struct iovt_fwnode {
+	struct list_head list;
+	struct fwnode_handle *fwnode;
+	int flag;
+	int segment;
+	int devid;
+	int nid;
+	struct list_head ep_list;
+};
+
+/* Root pointer to the mapped IOVT table */
+static LIST_HEAD(iovt_fwnode_list);
+static DEFINE_SPINLOCK(iovt_fwnode_lock);
+
+#ifdef CONFIG_PCI
+static void __init iovt_enable_acs(struct acpi_iovt_iommu *iommu)
+{
+	static bool acs_enabled __initdata;
+
+	if (acs_enabled)
+		return;
+
+	/* IOMMU V1 only supports PCI device management */
+	if ((iommu->header.type == ACPI_IOVT_IOMMU_V1) ||
+	    (iommu->flags & (ACPI_IOVT_IOMMU_PCI_DEVICE | ACPI_IOVT_IOMMU_MAGAGE_BY_SEGMENT))) {
+		pci_request_acs();
+		acs_enabled = true;
+	}
+}
+#else
+static inline void iovt_enable_acs(struct acpi_iovt_iommu *iommu) { }
+#endif
+
+static int __init iovt_get_pci_iommu_fwnode(struct iovt_fwnode *np, u16 segment, u16 bdf)
+{
+	struct pci_dev *pdev;
+	struct fwnode_handle *fwnode;
+
+	pdev = pci_get_domain_bus_and_slot(segment, PCI_BUS_NUM(bdf), bdf & 0xff);
+	if (!pdev) {
+		pr_err("No PCI IOMMU found for segment 0x%x bdf 0x%x\n", segment, bdf);
+		return -ENODEV;
+	}
+
+	fwnode = dev_fwnode(&pdev->dev);
+	if (!fwnode) {
+		/*
+		 * PCI devices aren't necessarily described by ACPI. Create a
+		 * fwnode so the IOMMU subsystem can identify this device.
+		 */
+		fwnode = acpi_alloc_fwnode_static();
+		if (!fwnode) {
+			pci_dev_put(pdev);
+			return -ENOMEM;
+		}
+		set_primary_fwnode(&pdev->dev, fwnode);
+	}
+
+	np->fwnode = dev_fwnode(&pdev->dev);
+	if (np->flag & ACPI_IOVT_IOMMU_PXM_VALID)
+		set_dev_node(&pdev->dev, np->nid);
+	pci_dev_put(pdev);
+	return 0;
+}
+
+static int __init iovt_add_iommu(struct acpi_iovt_iommu *iommu)
+{
+	struct iovt_fwnode *np;
+	struct fwnode_handle *fwnode;
+	struct acpi_iovt_device_entry *ep;
+	struct iovt_device_entry *entry;
+	int i, ret, start_devid;
+	bool is_start = false;
+
+	np = kzalloc_obj(struct iovt_fwnode, GFP_ATOMIC);
+	if (WARN_ON(!np))
+		return -ENOMEM;
+
+	INIT_LIST_HEAD(&np->list);
+	np->flag = iommu->flags;
+	np->segment = iommu->segment;
+	if (np->flag & ACPI_IOVT_IOMMU_PXM_VALID)
+		np->nid = pxm_to_node(iommu->proximity_domain);
+
+	if (np->flag & ACPI_IOVT_IOMMU_PCI_DEVICE) {
+		np->devid = iommu->device_id;
+		ret = iovt_get_pci_iommu_fwnode(np, np->segment, np->devid);
+		if (ret) {
+			kfree(np);
+			return ret;
+		}
+
+	} else {
+		fwnode = acpi_alloc_fwnode_static();
+		if (!fwnode) {
+			kfree(np);
+			return -ENOMEM;
+		}
+
+		np->fwnode = fwnode;
+	}
+
+	/* All devices in the segment are managed by this IOMMU */
+	if (np->flag & ACPI_IOVT_IOMMU_MAGAGE_BY_SEGMENT)
+		goto skip;
+
+	INIT_LIST_HEAD(&np->ep_list);
+	ep = ACPI_ADD_PTR(struct acpi_iovt_device_entry, iommu, iommu->device_entry_offset);
+	for (i = 0; i < iommu->device_entry_num; i++) {
+		switch (ep->type) {
+		case ACPI_IOVT_DEVICE_ENTRY_START:
+			is_start = true;
+			start_devid = ep->device_id;
+			break;
+		case ACPI_IOVT_DEVICE_ENTRY_END:
+			if (!is_start)
+				break;
+
+			entry = kzalloc_obj(struct iovt_device_entry, GFP_ATOMIC);
+			if (!entry)
+				return -ENOMEM;
+
+			entry->start_devid = start_devid;
+			entry->end_devid = ep->device_id;
+			list_add_tail(&entry->list, &np->ep_list);
+			is_start = false;
+			break;
+		case ACPI_IOVT_DEVICE_ENTRY_SINGLE:
+			entry = kzalloc_obj(struct iovt_device_entry, GFP_ATOMIC);
+			if (!entry)
+				return -ENOMEM;
+
+			entry->start_devid = ep->device_id;
+			entry->end_devid = ep->device_id;
+			list_add_tail(&entry->list, &np->ep_list);
+			is_start = false;
+			break;
+		default:
+			break;
+		}
+		ep = ACPI_ADD_PTR(struct acpi_iovt_device_entry, ep, ep->length);
+	}
+
+skip:
+	spin_lock(&iovt_fwnode_lock);
+	list_add_tail(&np->list, &iovt_fwnode_list);
+	spin_unlock(&iovt_fwnode_lock);
+	return 0;
+}
+
+static void __init iovt_init_devices(struct acpi_table_header *header)
+{
+	struct acpi_iovt_iommu *iommu;
+	struct acpi_table_iovt *iovt;
+	int i;
+
+	/* Get the first IOVT node */
+	iovt = (struct acpi_table_iovt *)header;
+	iommu = ACPI_ADD_PTR(struct acpi_iovt_iommu, iovt, iovt->iommu_offset);
+	for (i = 0; i < iovt->iommu_count; i++) {
+		iovt_add_iommu(iommu);
+		iommu = ACPI_ADD_PTR(struct acpi_iovt_iommu, iommu, iommu->header.length);
+	}
+}
+
+void __init acpi_iovt_init(void)
+{
+	acpi_status status;
+	struct acpi_table_header *hdr;
+	struct acpi_table_iovt *iovt;
+	struct acpi_iovt_iommu *iommu;
+	int i;
+
+	status = acpi_get_table(ACPI_SIG_IOVT, 0, &hdr);
+	if (ACPI_FAILURE(status)) {
+		if (status != AE_NOT_FOUND)
+			pr_err("Failed to get table, %s\n", acpi_format_exception(status));
+
+		return;
+	}
+
+	iovt = (struct acpi_table_iovt *)&hdr;
+	iommu = ACPI_ADD_PTR(struct acpi_iovt_iommu, iovt, iovt->iommu_offset);
+	for (i = 0; i < iovt->iommu_count; i++) {
+		iovt_enable_acs(iommu);
+		iommu = ACPI_ADD_PTR(struct acpi_iovt_iommu, iommu, iommu->header.length);
+	}
+
+	acpi_put_table(hdr);
+}
+
+void __init acpi_iovt_late_init(void)
+{
+	acpi_status status;
+	struct acpi_table_header *hdr;
+
+	status = acpi_get_table(ACPI_SIG_IOVT, 0, &hdr);
+	if (ACPI_FAILURE(status)) {
+		if (status != AE_NOT_FOUND)
+			pr_err("Failed to get table, %s\n", acpi_format_exception(status));
+
+		return;
+	}
+
+	iovt_init_devices(hdr);
+	acpi_put_table(hdr);
+}
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index ddacac812094..2a621c095b8b 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -1642,6 +1642,7 @@ static inline int acpi_pptt_get_cpumask_from_cache_id(u32 cache_id,
 #endif
 
 void acpi_arch_init(void);
+void acpi_arch_late_init(void);
 
 #ifdef CONFIG_ACPI_PCC
 void acpi_init_pcc(void);
-- 
2.39.3

