Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DB12541E72;
	Tue, 22 Sep 2026 12:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790079509; cv=none; b=rpn5TztFuC2ed9sdjsqTbIzFK7XCPe3ulLIPaQRdbVqeTRWra/9dTrjzNPPDaNJMrxuBzq8Z2rfdzAa7gRulXDJaX3vee8Jcn9a1ldhuwpp9PdSQAGcz3erp3Fhn76W9R/MXaC/wU4re6AlonmL0g6R2pFDfpIq7m/CkvWWhFb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790079509; c=relaxed/simple;
	bh=pLW252z9yEnMHMKpqlmSUn5bSCY4r+q8VwadCnjyVHo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HVXo+bBPf2mKoR/r0GR36N44ZNCoD/s45hD7NzZ0w2OLzGPKKPJGoY/j8Yood/2pyQkrP7S3vQDS6SEc3Iktk5/W/M+s5537FW5afhHPSw/+7orco3DeiCkYF5j2a7m0mtHtri4e8sunjkcyD2aSUNl3oPgu8Bp1YnLFctXDLQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8DxjdIQcrJqUaAOAA--.42497S3;
	Tue, 22 Sep 2026 20:18:24 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by front1 (Coremail) with SMTP id qMiowJBx6c0LcrJqysAjAA--.44690S5;
	Tue, 22 Sep 2026 20:18:24 +0800 (CST)
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
Subject: [PATCH v4 3/4] ACPI: scan: Add support for LoongArch in acpi_iommu_configure_id()
Date: Tue, 22 Sep 2026 20:10:57 +0800
Message-Id: <20260922121058.972734-4-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20260922121058.972734-1-maobibo@loongson.cn>
References: <20260922121058.972734-1-maobibo@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJBx6c0LcrJqysAjAA--.44690S5
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==

acpi_iommu_configure_id() currently supports only IORT and VIOT. Add
support for IOVT as well.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Acked-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>
---
 drivers/acpi/loongarch/iovt.c | 61 +++++++++++++++++++++++++++++++++++
 drivers/acpi/scan.c           |  3 ++
 include/linux/acpi_iovt.h     | 13 ++++++++
 3 files changed, 77 insertions(+)
 create mode 100644 include/linux/acpi_iovt.h

diff --git a/drivers/acpi/loongarch/iovt.c b/drivers/acpi/loongarch/iovt.c
index 302ca6a75905..df14ce48eac6 100644
--- a/drivers/acpi/loongarch/iovt.c
+++ b/drivers/acpi/loongarch/iovt.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 
 #include <linux/acpi.h>
+#include <linux/acpi_iovt.h>
 #include <linux/pci.h>
 #include "init.h"
 
@@ -217,3 +218,63 @@ void __init acpi_iovt_late_init(void)
 	iovt_init_devices(hdr);
 	acpi_put_table(hdr);
 }
+
+static int iovt_pci_dev_iommu_init(struct pci_dev *pdev, u16 dev_id, void *data)
+{
+	u32 sbdf;
+	struct iovt_fwnode *np;
+	struct device *aliased_dev = data;
+	u32 domain = pci_domain_nr(pdev->bus);
+	struct iovt_device_entry *entry;
+	bool found = false;
+
+	list_for_each_entry(np, &iovt_fwnode_list, list) {
+		if (domain != np->segment)
+			continue;
+
+		/* We're not translating ourself */
+		if (dev_id == np->devid)
+			return -EINVAL;
+
+		if (np->flag & ACPI_IOVT_IOMMU_MAGAGE_BY_SEGMENT) {
+			found = true;
+			break;
+		}
+
+		list_for_each_entry(entry, &np->ep_list, list) {
+			if (dev_id < entry->start_devid)
+				continue;
+
+			if (dev_id > entry->end_devid)
+				continue;
+
+			found = true;
+			break;
+		}
+
+		if (found)
+			break;
+	}
+
+	if (!found)
+		return -ENODEV;
+
+	sbdf = (domain << 16) + dev_id;
+	return acpi_iommu_fwspec_init(aliased_dev, sbdf, np->fwnode);
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
+	if (!dev_is_pci(dev))
+		return -ENODEV;
+
+	return pci_for_each_dma_alias(to_pci_dev(dev), iovt_pci_dev_iommu_init, dev);
+}
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 163a3cccf197..827cd526a099 100644
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
@@ -1626,6 +1627,8 @@ static int acpi_iommu_configure_id(struct device *dev, const u32 *id_in)
 	err = iort_iommu_configure_id(dev, id_in);
 	if (err && err != -EPROBE_DEFER)
 		err = rimt_iommu_configure_id(dev, id_in);
+	if (err && err != -EPROBE_DEFER)
+		err = iovt_iommu_configure_id(dev, id_in);
 	if (err && err != -EPROBE_DEFER)
 		err = viot_iommu_configure(dev);
 
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

