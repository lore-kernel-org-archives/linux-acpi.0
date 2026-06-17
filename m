Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4F8B3C1F50;
	Wed, 17 Jun 2026 07:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781682527; cv=none; b=WmyZONzGIx9CfJUzY2dGwjXu2FT+RKXDpNXPZ1DZxype9Nytg2fPIOdOcWlnG1QjyJblBOfQZrdhHjs7G6V5pZsliLqT7NMSkrmzTg6MeP1JJDV5x7ZgULjIzGBkc7zc+Qfgbk1GeF8QVzN9eVb+n2egvGvRuKTb4O2SsuG7s8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781682527; c=relaxed/simple;
	bh=wcO7wgTZL5ELFNpa5ZhvsoQyj47g/zvGMEObycA99Uc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eYQOtU1OmplZeWwwsp1JFU3jhb/tLWYU4JL80sdkOGNOegW+wkqPRxGaDUe8DsG+xCCbjGm7QHdfhtIqnZkPXpoZnhjpmyq0YeXqq0YoOV+4KJf1ZbxzXJDWxhlTRNVo47vnzXuqYZAV6kYMhh8O8ZG5YGYpTqG8KrQEiP7W+NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8BxdnhWUTJq1A4VAA--.30348S3;
	Wed, 17 Jun 2026 15:48:38 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by front1 (Coremail) with SMTP id qMiowJAxHMJVUTJqoAupAA--.58693S3;
	Wed, 17 Jun 2026 15:48:37 +0800 (CST)
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
Subject: [PATCH 5/8] ACPI: LoongArch: Scan IOMMU devices in IOVT table
Date: Wed, 17 Jun 2026 15:48:26 +0800
Message-Id: <20260617074829.2396638-6-maobibo@loongson.cn>
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
X-CM-TRANSID:qMiowJAxHMJVUTJqoAupAA--.58693S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==

In function acpi_iovt_init(), IOMMU devices are parsed in IOVT table.
And these IOMMU devices can put in list iovt_fwnode_list.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 drivers/acpi/loongarch/init.c |   2 +
 drivers/acpi/loongarch/init.h |   1 +
 drivers/acpi/loongarch/iovt.c | 121 ++++++++++++++++++++++++++++++++++
 3 files changed, 124 insertions(+)

diff --git a/drivers/acpi/loongarch/init.c b/drivers/acpi/loongarch/init.c
index 1aa9bfa66e51..e7272ee197c7 100644
--- a/drivers/acpi/loongarch/init.c
+++ b/drivers/acpi/loongarch/init.c
@@ -11,4 +11,6 @@ void __init acpi_arch_init(void)
 
 void __init acpi_arch_late_init(void)
 {
+	if (IS_ENABLED(CONFIG_ACPI_IOVT))
+		acpi_iovt_late_init();
 }
diff --git a/drivers/acpi/loongarch/init.h b/drivers/acpi/loongarch/init.h
index 070ea187bfae..85e5197553ad 100644
--- a/drivers/acpi/loongarch/init.h
+++ b/drivers/acpi/loongarch/init.h
@@ -2,3 +2,4 @@
 #include <linux/init.h>
 
 void __init acpi_iovt_init(void);
+void __init acpi_iovt_late_init(void);
diff --git a/drivers/acpi/loongarch/iovt.c b/drivers/acpi/loongarch/iovt.c
index 5e3d866796a9..47d2ce20e3f5 100644
--- a/drivers/acpi/loongarch/iovt.c
+++ b/drivers/acpi/loongarch/iovt.c
@@ -4,6 +4,19 @@
 #include <linux/pci.h>
 #include "init.h"
 
+struct iovt_fwnode {
+	struct list_head list;
+	struct fwnode_handle *fwnode;
+	int flag;
+	int segment;
+	int devid;
+	int nid;
+};
+
+/* Root pointer to the mapped IOVT table */
+static LIST_HEAD(iovt_fwnode_list);
+static DEFINE_SPINLOCK(iovt_fwnode_lock);
+
 #ifdef CONFIG_PCI
 static void __init iovt_enable_acs(struct acpi_iovt_iommu *iommu)
 {
@@ -23,6 +36,94 @@ static void __init iovt_enable_acs(struct acpi_iovt_iommu *iommu)
 static inline void iovt_enable_acs(struct acpi_iovt_iommu *iommu) { }
 #endif
 
+static int __init iovt_get_pci_iommu_fwnode(struct iovt_fwnode *np, u16 segment, u16 bdf)
+{
+	struct pci_dev *pdev;
+	struct fwnode_handle *fwnode;
+
+	pdev = pci_get_domain_bus_and_slot(segment, PCI_BUS_NUM(bdf), bdf & 0xff);
+	if (!pdev) {
+		pr_err("Could not find PCI IOMMU\n");
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
+	if (np->flag & ACPI_IOVT_PXM_VALID)
+		set_dev_node(&pdev->dev, np->nid);
+	pci_dev_put(pdev);
+	return 0;
+}
+
+static int __init iovt_add_iommu(struct acpi_iovt_iommu *iommu)
+{
+	struct iovt_fwnode *np;
+	struct fwnode_handle *fwnode;
+	int ret;
+
+	np = kzalloc_obj(struct iovt_fwnode, GFP_ATOMIC);
+	if (WARN_ON(!np))
+		return -ENOMEM;
+
+	INIT_LIST_HEAD(&np->list);
+	np->flag = iommu->flags;
+	np->segment = iommu->segment;
+	if (np->flag & ACPI_IOVT_PXM_VALID)
+		np->nid = pxm_to_node(iommu->proximity_domain);
+
+	if (np->flag & ACPI_IOVT_PCI_DEVICE) {
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
+	iovt = (struct acpi_table_iovt *)header;
+
+	/* Get the first IOVT node */
+	iommu = ACPI_ADD_PTR(struct acpi_iovt_iommu, iovt, iovt->iommu_offset);
+	for (i = 0; i < iovt->iommu_count; i++) {
+		iovt_add_iommu(iommu);
+		iommu = ACPI_ADD_PTR(struct acpi_iovt_iommu, iommu, iommu->header.length);
+	}
+}
+
 void __init acpi_iovt_init(void)
 {
 	acpi_status status;
@@ -52,3 +153,23 @@ void __init acpi_iovt_init(void)
 
 	acpi_put_table(hdr);
 }
+
+void __init acpi_iovt_late_init(void)
+{
+	acpi_status status;
+	struct acpi_table_header *hdr;
+
+	status = acpi_get_table(ACPI_SIG_IOVT, 0, &hdr);
+	if (ACPI_FAILURE(status)) {
+		if (status != AE_NOT_FOUND) {
+			const char *msg = acpi_format_exception(status);
+
+			pr_err("Failed to get table, %s\n", msg);
+		}
+
+		return;
+	}
+
+	iovt_init_devices(hdr);
+	acpi_put_table(hdr);
+}
-- 
2.39.3

