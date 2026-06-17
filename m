Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE13C3BED75;
	Wed, 17 Jun 2026 07:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781682525; cv=none; b=Di/7NcyvSuBZisYLUSOCkvlWSIUhEn+8Aibe8uFE9w2Xk8PegoSAqr9kpfQ8spdZADbguCewnlTNuMEr75TuBpIRru4A89VaK0BefYFMFpFzvOXva3ZDQVi4JzDQ2TxFOXYvxuvxsg8/mnlc5SAjqKIO8vG5RBMXN2cQYvEK1yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781682525; c=relaxed/simple;
	bh=DRHuHHOgXubk8Y/CUORpqlqZzU1jLk88krXJ/gZe+d4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FJlv4gjNjWxKuBozt+HgRwIwgbnccYpuDlDpone1sXsfWvkGpuZOzdZs/76A/No/kuuyZnHAUxpcwM5jTDQ8Y6dyz2bC83Bb1NXB0Qi5FTwBxh54QYpK3X08Oc6coEbAY5KXaT7QR3nLj6ajLiYjt77JZTp9RfMgoQJVAab1ujM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8BxzelXUTJq3w4VAA--.53389S3;
	Wed, 17 Jun 2026 15:48:39 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by front1 (Coremail) with SMTP id qMiowJAxHMJVUTJqoAupAA--.58693S4;
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
Subject: [PATCH 6/8] ACPI: LoongArch: Add iovt device entry table scanning
Date: Wed, 17 Jun 2026 15:48:27 +0800
Message-Id: <20260617074829.2396638-7-maobibo@loongson.cn>
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
X-CM-TRANSID:qMiowJAxHMJVUTJqoAupAA--.58693S4
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==

Iovt device entry table are device entry lists which are managed by
IOMMU device, each IOMMU device has its ownd device entry table.

Here add iovt device entry table scanning function in function
iovt_add_iommu().

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 drivers/acpi/loongarch/iovt.c | 53 ++++++++++++++++++++++++++++++++++-
 1 file changed, 52 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/loongarch/iovt.c b/drivers/acpi/loongarch/iovt.c
index 47d2ce20e3f5..7deedb8219b2 100644
--- a/drivers/acpi/loongarch/iovt.c
+++ b/drivers/acpi/loongarch/iovt.c
@@ -4,6 +4,12 @@
 #include <linux/pci.h>
 #include "init.h"
 
+struct iovt_device_entry {
+	struct list_head list;
+	int start_devid;
+	int end_devid;
+};
+
 struct iovt_fwnode {
 	struct list_head list;
 	struct fwnode_handle *fwnode;
@@ -11,6 +17,7 @@ struct iovt_fwnode {
 	int segment;
 	int devid;
 	int nid;
+	struct list_head ep_list;
 };
 
 /* Root pointer to the mapped IOVT table */
@@ -72,7 +79,10 @@ static int __init iovt_add_iommu(struct acpi_iovt_iommu *iommu)
 {
 	struct iovt_fwnode *np;
 	struct fwnode_handle *fwnode;
-	int ret;
+	struct acpi_iovt_device_entry *ep;
+	struct iovt_device_entry *entry;
+	int i, ret, start_devid;
+	bool is_start = false;
 
 	np = kzalloc_obj(struct iovt_fwnode, GFP_ATOMIC);
 	if (WARN_ON(!np))
@@ -102,6 +112,47 @@ static int __init iovt_add_iommu(struct acpi_iovt_iommu *iommu)
 		np->fwnode = fwnode;
 	}
 
+	if (np->flag & ACPI_IOVT_MAGAGE_BY_SEGMENT)
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
 	spin_lock(&iovt_fwnode_lock);
 	list_add_tail(&np->list, &iovt_fwnode_list);
 	spin_unlock(&iovt_fwnode_lock);
-- 
2.39.3

