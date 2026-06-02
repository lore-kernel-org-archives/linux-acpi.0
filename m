Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F8F230264;
	Tue,  2 Jun 2026 07:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780384562; cv=none; b=oKOigF81f7DeQRV/ZDzVAS3YPjgBO0XmL2gimkGdnj/5ONsKAx7HGxb3dsO8OA0mZr1+ww/xY3SLB6t+sC2XJgpUHxTcbUBouSUQOBUas+E9BEZF8IvvTB0ggRsETuNDra2GkaXf8eQCWixYbM4bZlCHPrVY88fU8TidHKrzOgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780384562; c=relaxed/simple;
	bh=HgyMTH/zffk+7pHCe6NYto1bA5KcvSFsyYjMSj035Jw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZyzVue7Zhs/fpD7u4C+mgvJPcb8VkqhnABhGI/FRY1cEbwhC7V3pbHuIPYZ+lNKQBKEwO0H5YO9tcBj2U4An8DcXUxbl4G6oBj6RLzKHPMbYRJ/QwXIgHAlrtZQEQuC1xBVCu4GwIVjVue+3i4jIm4hItTQ+ctCco1b17Hoi2ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=BzfJ+BSw; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="BzfJ+BSw"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1780384550; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=itObtE7tOGkEONQAFJ+mBj1BRHYMUlPupZz3p9rp7M0=;
	b=BzfJ+BSw4T2xhIfiroktiAspcUf9L/bkEGdPj9/3DH2KlCyaMszodHhkatnYiYSSr6bW1pnFVPb/tD8v+i5+jXJab88I75z9HkEZYRfi42TYD4G6xynXcHOynHEpYr9PkMyUt4W804KP6d5r9hPucqxl7nrTa1ksbLrdgOL01vU=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R231e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=tianruidong@linux.alibaba.com;NM=1;PH=DS;RN=20;SR=0;TI=SMTPD_---0X43R2YA_1780384546;
Received: from t50a05405.sqa.eu95.tbsite.net(mailfrom:tianruidong@linux.alibaba.com fp:SMTPD_---0X43R2YA_1780384546 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 02 Jun 2026 15:15:48 +0800
From: Ruidong Tian <tianruidong@linux.alibaba.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Tony Luck <tony.luck@intel.com>,
	Borislav Petkov <bp@alien8.de>,
	Thomas Gleixner <tglx@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Umang Chheda <umang.chheda@oss.qualcomm.com>
Cc: linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-edac@vger.kernel.org,
	zhuo.song@linux.alibaba.com,
	oliver.yang@linux.alibaba.com,
	Ruidong Tian <tianruidong@linux.alibaba.com>
Subject: [PATCH v7 01/16] ACPI/AEST: Register arm64_ras platform devices from AEST v2
Date: Tue,  2 Jun 2026 15:15:24 +0800
Message-ID: <20260602071540.3711528-2-tianruidong@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260602071540.3711528-1-tianruidong@linux.alibaba.com>
References: <20260602071540.3711528-1-tianruidong@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Parse the ARM Error Source Table (AEST) v2 [1] and present each
error-source node to the RAS subsystem as a generic platform device.

Rather than letting the RAS driver consume AEST-specific structures
directly, all per-node metadata (interface type, register bases,
group format, record bitmaps, GSIVs, vendor data) is conveyed via
fwnode software-node properties. This keeps every AEST encoding
detail in the ACPI front-end and lets the same back-end driver bind
unchanged when a Device Tree front-end is added later.

If the interface flags indicate an associated ACPI namespace device
(AEST_XFACE_FLAG_ERROR_DEVICE), the companion ACPI device is looked up
and attached so that downstream drivers can reach it.

[1]: https://developer.arm.com/documentation/den0085/0200/

Signed-off-by: Ruidong Tian <tianruidong@linux.alibaba.com>
---
 MAINTAINERS                 |   8 ++
 drivers/acpi/arm64/Kconfig  |  10 ++
 drivers/acpi/arm64/Makefile |   1 +
 drivers/acpi/arm64/aest.c   | 256 ++++++++++++++++++++++++++++++++++++
 include/linux/acpi_aest.h   |  19 +++
 5 files changed, 294 insertions(+)
 create mode 100644 drivers/acpi/arm64/aest.c
 create mode 100644 include/linux/acpi_aest.h

diff --git a/MAINTAINERS b/MAINTAINERS
index c3fe46d7c4bc..16c80a7ea72c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -344,6 +344,14 @@ S:	Maintained
 F:	drivers/acpi/arm64
 F:	include/linux/acpi_iort.h
 
+ACPI AEST
+M:	Ruidong Tian <tianruidong@linux.alibaba.com>
+L:	linux-acpi@vger.kernel.org
+L:	linux-arm-kernel@lists.infradead.org
+S:	Supported
+F:	drivers/acpi/arm64/aest.c
+F:	include/linux/acpi_aest.h
+
 ACPI FOR RISC-V (ACPI/riscv)
 M:	Sunil V L <sunilvl@ventanamicro.com>
 L:	linux-acpi@vger.kernel.org
diff --git a/drivers/acpi/arm64/Kconfig b/drivers/acpi/arm64/Kconfig
index f2fd79f22e7d..49b487bba928 100644
--- a/drivers/acpi/arm64/Kconfig
+++ b/drivers/acpi/arm64/Kconfig
@@ -24,3 +24,13 @@ config ACPI_APMT
 
 config ACPI_MPAM
 	bool
+
+config ACPI_AEST
+	bool "ARM Error Source Table Support"
+	depends on ARM64_RAS_EXTN
+	help
+	  The Arm Error Source Table (AEST) provides details on ACPI
+	  extensions that enable kernel-first handling of errors in a
+	  system that supports the Armv8 RAS extensions.
+
+	  If set, the kernel will report and log hardware errors.
diff --git a/drivers/acpi/arm64/Makefile b/drivers/acpi/arm64/Makefile
index 9390b57cb564..bad77fdbf8dd 100644
--- a/drivers/acpi/arm64/Makefile
+++ b/drivers/acpi/arm64/Makefile
@@ -7,5 +7,6 @@ obj-$(CONFIG_ACPI_IORT) 	+= iort.o
 obj-$(CONFIG_ACPI_MPAM) 	+= mpam.o
 obj-$(CONFIG_ACPI_PROCESSOR_IDLE) += cpuidle.o
 obj-$(CONFIG_ARM_AMBA)		+= amba.o
+obj-$(CONFIG_ACPI_AEST) 	+= aest.o
 obj-y				+= dma.o init.o
 obj-y				+= thermal_cpufreq.o
diff --git a/drivers/acpi/arm64/aest.c b/drivers/acpi/arm64/aest.c
new file mode 100644
index 000000000000..8cf24467d0c2
--- /dev/null
+++ b/drivers/acpi/arm64/aest.c
@@ -0,0 +1,256 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * ARM Error Source Table Support
+ *
+ * Copyright (c) 2025, Alibaba Group.
+ */
+
+#include <linux/cleanup.h>
+#include <linux/platform_device.h>
+#include <linux/property.h>
+#include <linux/acpi_aest.h>
+
+#include "init.h"
+
+#undef pr_fmt
+#define pr_fmt(fmt) "ACPI AEST: " fmt
+
+/*
+ * Fill the per-AEST-entry inner properties (node-type / interface-type /
+ * group-format / record bitmaps / register bases ...).
+ */
+static int __init
+aest_init_node_props(struct acpi_aest_hdr *hdr, struct property_entry *props,
+		     int *p, struct platform_device *pdev)
+{
+	struct acpi_aest_node_interface_header *interface;
+	struct acpi_aest_node_interface_common *common = NULL;
+	u64 *record_implemented = NULL;
+	u64 *status_reporting = NULL;
+	u64 *addressing_mode = NULL;
+	int group_len = 0, i;
+	size_t len;
+
+	interface = ACPI_ADD_PTR(struct acpi_aest_node_interface_header,
+				 hdr, hdr->node_interface_offset);
+	switch (interface->group_format) {
+	case ACPI_AEST_NODE_GROUP_FORMAT_4K: {
+		struct acpi_aest_node_interface_4k *itf =
+			(struct acpi_aest_node_interface_4k *)(interface + 1);
+
+		record_implemented = &itf->error_record_implemented;
+		status_reporting   = &itf->error_status_reporting;
+		addressing_mode    = &itf->addressing_mode;
+		group_len = 1;
+		common = &itf->common;
+		break;
+	}
+	case ACPI_AEST_NODE_GROUP_FORMAT_16K: {
+		struct acpi_aest_node_interface_16k *itf =
+			(struct acpi_aest_node_interface_16k *)(interface + 1);
+
+		record_implemented = itf->error_record_implemented;
+		status_reporting   = itf->error_status_reporting;
+		addressing_mode    = itf->addressing_mode;
+		group_len = 4;
+		common = &itf->common;
+		break;
+	}
+	case ACPI_AEST_NODE_GROUP_FORMAT_64K: {
+		struct acpi_aest_node_interface_64k *itf =
+			(struct acpi_aest_node_interface_64k *)(interface + 1);
+
+		record_implemented = itf->error_record_implemented;
+		status_reporting   = itf->error_status_reporting;
+		addressing_mode    = itf->addressing_mode;
+		group_len = 14;
+		common = &itf->common;
+		break;
+	}
+	default:
+		pr_err("invalid group format: %d\n", interface->group_format);
+		return -EINVAL;
+	}
+
+	if (interface->flags & AEST_XFACE_FLAG_ERROR_DEVICE) {
+		struct acpi_device *companion;
+		char uid[16];
+		int n;
+
+		n = snprintf(uid, sizeof(uid), "%u",
+			     common->error_node_device);
+		if (n > 0 && n < sizeof(uid)) {
+			companion = acpi_dev_get_first_match_dev("ARMHE000",
+								 uid, -1);
+			if (companion) {
+				ACPI_COMPANION_SET(&pdev->dev, companion);
+				acpi_dev_put(companion);
+			} else {
+				pr_debug("MSC.%u: missing namespace entry\n",
+					 common->error_node_device);
+			}
+		}
+	}
+
+	props[(*p)++] = PROPERTY_ENTRY_U8("arm,node-type", hdr->type);
+	props[(*p)++] = PROPERTY_ENTRY_U8("arm,group-format",
+					  interface->group_format);
+	props[(*p)++] = PROPERTY_ENTRY_U32("arm,error-records-count",
+					   interface->error_record_count);
+	props[(*p)++] = PROPERTY_ENTRY_U32("arm,error-records-index",
+					   interface->error_record_index);
+	props[(*p)++] = PROPERTY_ENTRY_U32("arm,interface-flags",
+					   interface->flags);
+	props[(*p)++] = PROPERTY_ENTRY_U64_ARRAY_LEN("arm,record-implemented",
+						     record_implemented,
+						     group_len);
+	props[(*p)++] = PROPERTY_ENTRY_U64_ARRAY_LEN("arm,status-reporting",
+						     status_reporting,
+						     group_len);
+	props[(*p)++] = PROPERTY_ENTRY_U64("arm,error-group-base",
+					   common->error_group_register_base);
+
+	len = hdr->node_interface_offset - hdr->node_specific_offset;
+	props[(*p)++] =
+		PROPERTY_ENTRY_U8_ARRAY_LEN("arm,node-specific-data",
+					    ACPI_ADD_PTR(u8, hdr, hdr->node_specific_offset), len);
+
+	return 0;
+}
+
+static int __init
+aest_create_node_fwnode(struct acpi_aest_hdr *hdr, struct platform_device *pdev)
+{
+	struct property_entry props[10] = { };
+	int p = 0;
+	int ret;
+
+	ret = aest_init_node_props(hdr, props, &p, pdev);
+	if (ret)
+		return ret;
+
+	return device_create_managed_software_node(&pdev->dev, props, NULL);
+}
+
+static int aest_node_mem_size(u8 group_format)
+{
+	switch (group_format) {
+	case ACPI_AEST_NODE_GROUP_FORMAT_4K:
+		return SZ_4K;
+	case ACPI_AEST_NODE_GROUP_FORMAT_16K:
+		return SZ_16K;
+	case ACPI_AEST_NODE_GROUP_FORMAT_64K:
+		return SZ_64K;
+	default:
+		return SZ_4K;
+	}
+}
+
+DEFINE_FREE(res, struct resource *, if (_T) kfree(_T))
+
+static struct platform_device *__init
+acpi_aest_alloc_pdev(struct acpi_aest_hdr *aest_hdr)
+{
+	struct platform_device *pdev __free(platform_device_put) =
+		platform_device_alloc("arm64_ras", PLATFORM_DEVID_AUTO);
+	struct resource *res __free(res) = NULL;
+	struct acpi_aest_node_interface_header *interface;
+	int ret, j = 0;
+
+	if (!pdev)
+		return ERR_PTR(-ENOMEM);
+
+	res = kcalloc(1, sizeof(*res), GFP_KERNEL);
+	if (!res)
+		return ERR_PTR(-ENOMEM);
+
+	interface = ACPI_ADD_PTR(struct acpi_aest_node_interface_header,
+				 aest_hdr, aest_hdr->node_interface_offset);
+	if (interface->type != ACPI_AEST_NODE_SYSTEM_REGISTER) {
+		res[j].name = AEST_NODE_NAME;
+		res[j].start = interface->address;
+		res[j].end = res[j].start + aest_node_mem_size(interface->group_format) - 1;
+		res[j].flags = IORESOURCE_MEM;
+		j++;
+	}
+
+	ret = platform_device_add_resources(pdev, res, j);
+	if (ret)
+		return ERR_PTR(ret);
+
+	return_ptr(pdev);
+}
+
+static int __init acpi_aest_init_node(struct acpi_aest_hdr *aest_hdr)
+{
+	struct platform_device *pdev __free(platform_device_put) = NULL;
+	int ret;
+
+	pdev = acpi_aest_alloc_pdev(aest_hdr);
+	if (IS_ERR(pdev))
+		return PTR_ERR(pdev);
+
+	ret = aest_create_node_fwnode(aest_hdr, pdev);
+	if (ret)
+		return ret;
+
+	ret = platform_device_add(pdev);
+	if (ret)
+		return ret;
+	pr_debug("Platform device added for AEST node: %s.%d\n",
+		 pdev->name, pdev->id);
+	retain_and_null_ptr(pdev);
+
+	return 0;
+}
+
+static int __init acpi_aest_init_nodes(struct acpi_table_header *aest_table)
+{
+	struct acpi_aest_hdr *aest_node, *aest_end;
+	struct acpi_table_aest *aest;
+	int rc;
+
+	aest = (struct acpi_table_aest *)aest_table;
+	aest_node = ACPI_ADD_PTR(struct acpi_aest_hdr, aest,
+				 sizeof(struct acpi_table_header));
+	aest_end = ACPI_ADD_PTR(struct acpi_aest_hdr, aest, aest_table->length);
+
+	while (aest_node < aest_end) {
+		if (((u64)aest_node + aest_node->length) > (u64)aest_end) {
+			pr_warn(FW_WARN
+				"AEST node pointer overflow, bad table.\n");
+			return -EINVAL;
+		}
+
+		rc = acpi_aest_init_node(aest_node);
+		if (rc)
+			return rc;
+
+		aest_node = ACPI_ADD_PTR(struct acpi_aest_hdr, aest_node,
+					 aest_node->length);
+	}
+
+	return 0;
+}
+
+static int __init acpi_aest_init(void)
+{
+	int ret;
+
+	if (acpi_disabled)
+		return 0;
+
+	struct acpi_table_header *aest_table __free(acpi_put_table) =
+		acpi_get_table_pointer(ACPI_SIG_AEST, 0);
+	if (IS_ERR(aest_table))
+		return 0;
+
+	ret = acpi_aest_init_nodes(aest_table);
+	if (ret) {
+		pr_err("Failed init aest node %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+subsys_initcall_sync(acpi_aest_init);
diff --git a/include/linux/acpi_aest.h b/include/linux/acpi_aest.h
new file mode 100644
index 000000000000..e485a6236891
--- /dev/null
+++ b/include/linux/acpi_aest.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ACPI_AEST_H__
+#define __ACPI_AEST_H__
+
+#include <linux/acpi.h>
+
+/* AEST resource name */
+#define AEST_NODE_NAME "AEST:NODE"
+
+/* AEST interface */
+#define AEST_XFACE_FLAG_SHARED		BIT(0)
+#define AEST_XFACE_FLAG_CLEAR_MISC	BIT(1)
+#define AEST_XFACE_FLAG_ERROR_DEVICE	BIT(2)
+#define AEST_XFACE_FLAG_AFFINITY	BIT(3)
+#define AEST_XFACE_FLAG_ERROR_GROUP	BIT(4)
+#define AEST_XFACE_FLAG_FAULT_INJECT	BIT(5)
+#define AEST_XFACE_FLAG_INT_CONFIG	BIT(6)
+
+#endif /* __ACPI_AEST_H__ */
-- 
2.51.2.612.gdc70283dfc

