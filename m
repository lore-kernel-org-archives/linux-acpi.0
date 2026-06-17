Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78D003BF68D;
	Wed, 17 Jun 2026 07:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781682526; cv=none; b=L9lqNmThOVRxOpnZPCQ3NpXPrkz6hjsXAK8+RqMXrulSgECJKmygzSNwA910reg6Eeu06UbpIhGOeGKbhv8TSuqtGp1mfz7DHo/ME2dAqu0sad++53VDAKp06W2Jnr2jXNKxVS3QUYn+blKFageU8sfnoHcRZo5hsJQU6x72+GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781682526; c=relaxed/simple;
	bh=SBpMSWTbObPyAj5WcMO43byY0/m+cs4fmAr2FpAnloA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eL+FBkXgQ5J9JRbzKfm1nE6XnnizyCzzVdXRGd+yOA9pzzSINiloBOFNkzGn7ie63nOYx2AV7eT3SwcQn+MQ6H7asfAbxIVzgD0wDKaIt/o+IhTjmNu580wRuvVCLoPspTm5Kaj69lrld1KhZ9chgSiabSnUMfYnnn6sHq5Cn1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8Dx8epXUTJq3Q4VAA--.55305S3;
	Wed, 17 Jun 2026 15:48:39 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by front1 (Coremail) with SMTP id qMiowJAxHMJVUTJqoAupAA--.58693S5;
	Wed, 17 Jun 2026 15:48:38 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>,
	Saket Dumbre <saket.dumbre@intel.com>,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	lixianglai@loongson.cn,
	bibo.mao@gmail.com
Subject: [PATCH 7/8] ACPI: scan: Add support for LoongArch in acpi_iommu_configure_id()
Date: Wed, 17 Jun 2026 15:48:28 +0800
Message-Id: <20260617074829.2396638-8-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20260617074829.2396638-1-maobibo@loongson.cn>
References: <20260617074829.2396638-1-maobibo@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJAxHMJVUTJqoAupAA--.58693S5
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==

acpi_iommu_configure_id() currently supports only IORT (ARM) and VIOT.
Add support for IOVT (LoongArch) as well.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 drivers/acpi/loongarch/iovt.c | 48 +++++++++++++++++++++++++++++++++++
 drivers/acpi/scan.c           |  3 +++
 include/linux/acpi_iovt.h     | 13 ++++++++++
 3 files changed, 64 insertions(+)
 create mode 100644 include/linux/acpi_iovt.h

diff --git a/drivers/acpi/loongarch/iovt.c b/drivers/acpi/loongarch/iovt.c
index 7deedb8219b2..c769cfc74310 100644
--- a/drivers/acpi/loongarch/iovt.c
+++ b/drivers/acpi/loongarch/iovt.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 
 #include <linux/acpi.h>
+#include <linux/acpi_iovt.h>
 #include <linux/pci.h>
 #include "init.h"
 
@@ -224,3 +225,50 @@ void __init acpi_iovt_late_init(void)
 	iovt_init_devices(hdr);
 	acpi_put_table(hdr);
 }
+
+static int iovt_pci_dev_iommu_init(struct pci_dev *pdev, u16 dev_id, void *data)
+{
+	u32 epid;
+	struct iovt_fwnode *np;
+	struct device *aliased_dev = data;
+	u32 domain = pci_domain_nr(pdev->bus);
+	struct iovt_device_entry *entry;
+
+	list_for_each_entry(np, &iovt_fwnode_list, list) {
+		if (domain != np->segment)
+			continue;
+
+		/* We're not translating ourself */
+		if (dev_id == np->devid)
+			return -EINVAL;
+
+		epid = (domain << 16) + dev_id;
+		if (np->flag & ACPI_IOVT_MAGAGE_BY_SEGMENT)
+			return acpi_iommu_fwspec_init(aliased_dev, epid, np->fwnode);
+
+		list_for_each_entry(entry, &np->ep_list, list) {
+			if (dev_id >= entry->start_devid && dev_id <= entry->end_devid)
+				return acpi_iommu_fwspec_init(aliased_dev, epid, np->fwnode);
+		}
+	}
+
+	return -ENODEV;
+}
+
+/*
+ * iovt_iommu_configure_id - Set-up IOMMU configuration for a device.
+ *
+ * @dev: device to configure
+ * @id_in: optional input id const value pointer
+ *
+ * Returns: 0 on success, <0 on failure
+ */
+int iovt_iommu_configure_id(struct device *dev, const u32 *id_in)
+{
+	int err = -ENODEV;
+
+	if (!dev_is_pci(dev))
+		return err;
+
+	return pci_for_each_dma_alias(to_pci_dev(dev), iovt_pci_dev_iommu_init, dev);
+}
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 9a7ac2eb9ce0..508575f25e10 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -13,6 +13,7 @@
 #include <linux/kernel.h>
 #include <linux/acpi.h>
 #include <linux/acpi_iort.h>
+#include <linux/acpi_iovt.h>
 #include <linux/acpi_rimt.h>
 #include <linux/acpi_viot.h>
 #include <linux/iommu.h>
@@ -1629,6 +1630,8 @@ static int acpi_iommu_configure_id(struct device *dev, const u32 *id_in)
 		err = rimt_iommu_configure_id(dev, id_in);
 	if (err && err != -EPROBE_DEFER)
 		err = viot_iommu_configure(dev);
+	if (err && err != -EPROBE_DEFER)
+		err = iovt_iommu_configure_id(dev, id_in);
 
 	mutex_unlock(&iommu_probe_device_lock);
 
diff --git a/include/linux/acpi_iovt.h b/include/linux/acpi_iovt.h
new file mode 100644
index 000000000000..25a846b96260
--- /dev/null
+++ b/include/linux/acpi_iovt.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef __ACPI_IOVT_H__
+#define __ACPI_IOVT_H__
+
+#if defined(CONFIG_IOMMU_API) && defined(CONFIG_ACPI_IOVT)
+int iovt_iommu_configure_id(struct device *dev, const u32 *id_in);
+#else
+static inline int iovt_iommu_configure_id(struct device *dev, const u32 *id_in)
+{ return -ENODEV; }
+#endif
+
+#endif
-- 
2.39.3

