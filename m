Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE20E3BF67A;
	Wed, 17 Jun 2026 07:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781682524; cv=none; b=AffGtfPFTuwPM+0xchhxvi388iSy52ha3ojY6JMoDYqovN8Ns1eSVzXUMvll+0Jl41/4HBgWy37Eu3fg1F/IsarbEGmaV40pkxL5e7vkT4jjxhRM9cwP65QrWLyJqRDatwAvXqfIWJxInsyjMqbUhCSsZmVK/qsX+34Zyr+f8Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781682524; c=relaxed/simple;
	bh=fRVvj90HNYQP7SImtdu0GyFBhLzDMGEhAniePa2aM9M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tn56OENOhKJhWcJRwc0uzFiCBeSrLUIZU2q0cYdAISNrdjT/OVIZcbQ7pIcLAjwVggT49UbHpcl9atTLnoPV8QJOQDYqLyx0zE13MSFHi23cVm3puc6SDxE12JZNeOVkKI3okI4Egy+QV2sPiZeqCQkJ1jB+bWQSlvXkUfVIeJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8BxdnhTUTJqyg4VAA--.30346S3;
	Wed, 17 Jun 2026 15:48:35 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by front1 (Coremail) with SMTP id qMiowJCxvsJOUTJqnQupAA--.58263S5;
	Wed, 17 Jun 2026 15:48:34 +0800 (CST)
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
Subject: [PATCH 3/8] ACPI: LoongArch: Enable pci acs function if acpi iovt tables exist
Date: Wed, 17 Jun 2026 15:48:24 +0800
Message-Id: <20260617074829.2396638-4-maobibo@loongson.cn>
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
X-CM-TRANSID:qMiowJCxvsJOUTJqnQupAA--.58263S5
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==

IOMMU requires pci acs function enabled, so that all the DMA transaction
of pci device is routed to upper PCI bridge and IOMMU device.

Here scan IOMMU iovt table in function acpi_iovt_init(), which is
executed before PCI device sanning, and enable pci acs function if
iovt tables exist.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 drivers/acpi/loongarch/iovt.c | 47 +++++++++++++++++++++++++++++++++++
 include/acpi/actbl2.h         |  3 +++
 2 files changed, 50 insertions(+)

diff --git a/drivers/acpi/loongarch/iovt.c b/drivers/acpi/loongarch/iovt.c
index 793ed13a2cef..5e3d866796a9 100644
--- a/drivers/acpi/loongarch/iovt.c
+++ b/drivers/acpi/loongarch/iovt.c
@@ -1,7 +1,54 @@
 // SPDX-License-Identifier: GPL-2.0-only
 
+#include <linux/acpi.h>
+#include <linux/pci.h>
 #include "init.h"
 
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
+		(iommu->flags & (ACPI_IOVT_PCI_DEVICE | ACPI_IOVT_MAGAGE_BY_SEGMENT))) {
+		pci_request_acs();
+		acs_enabled = true;
+	}
+}
+#else
+static inline void iovt_enable_acs(struct acpi_iovt_iommu *iommu) { }
+#endif
+
 void __init acpi_iovt_init(void)
 {
+	acpi_status status;
+	struct acpi_table_header *hdr;
+	struct acpi_table_iovt *iovt;
+	struct acpi_iovt_iommu *iommu;
+	int i;
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
+	iovt = (struct acpi_table_iovt *)&hdr;
+	iommu = ACPI_ADD_PTR(struct acpi_iovt_iommu, iovt, iovt->iommu_offset);
+	for (i = 0; i < iovt->iommu_count; i++) {
+		iovt_enable_acs(iommu);
+
+		iommu = ACPI_ADD_PTR(struct acpi_iovt_iommu, iommu, iommu->header.length);
+	}
+
+	acpi_put_table(hdr);
 }
diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index baef525367b5..acc51a42c3ed 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -892,6 +892,9 @@ struct acpi_iovt_header {
 
 /* Values for Type field above */
 
+#define ACPI_IOVT_PCI_DEVICE		BIT(0)
+#define ACPI_IOVT_PXM_VALID		BIT(1)
+#define ACPI_IOVT_MAGAGE_BY_SEGMENT	BIT(2)
 enum acpi_iovt_iommu_type {
 	ACPI_IOVT_IOMMU_V1 = 0x00,
 	ACPI_IOVT_IOMMU_RESERVED = 0x01	/* 1 and greater are reserved */
-- 
2.39.3

