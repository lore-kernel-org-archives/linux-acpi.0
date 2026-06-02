Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048C5357CF5;
	Tue,  2 Jun 2026 07:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780384619; cv=none; b=qqG84szpyP7mZaiL3sGzP3IwcAqdN1kr3N9eh5Txc8xlGskQiEVPBhDhTUJP0xs1XfLQZJPdwwGb6vb6O2IyA2g2ODbN+ten+F/P2ooQrpcHYAVEX7vCsmFxDkpvNGQyITilMnGqAqDE1U2ROM5aSaWTYovPALadDYmEwc05TCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780384619; c=relaxed/simple;
	bh=gADpYitvE/7Oyw0mK8pa3fgtuYfNMZ1aQai+GgQXS/A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d3sH+nHHIUFkTlU6qmkBMvM1u+x3z8ZmAncA9AlxYMYxLVxBIQy+KiTxHmHHUtoSKhxGXAaVi5Bco5cNEhddrs818BY/giY6hYHLBxzHfEwmcjnRezzw8OWlmiuPtwFaNrcbd5O5sgubn+BFh/ElMpTHuvxt6ZqLPtWZf3Ach30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Jd5TXOMq; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Jd5TXOMq"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1780384553; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=kbx4Eivf9wzreQZFZq4e6akKl81b9F+2yXP+5FfPTTs=;
	b=Jd5TXOMqMDNAe/pknxq8COYeBjr/Sb+OsdT7Z/pAPyRJuGJFvWhEhE7TAxhQalFmqd+4hJNLOrvDiJOmQKbiTMZFDP0po+zib1rgg/oJFMwRR8D6q41bzcbt1Fz4lxLDd6V9qi1micBTjqXzbWrIDxO/oSeSPhc75f/QjR/7DUs=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=tianruidong@linux.alibaba.com;NM=1;PH=DS;RN=20;SR=0;TI=SMTPD_---0X43R2ZE_1780384549;
Received: from t50a05405.sqa.eu95.tbsite.net(mailfrom:tianruidong@linux.alibaba.com fp:SMTPD_---0X43R2ZE_1780384549 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 02 Jun 2026 15:15:52 +0800
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
Subject: [PATCH v7 02/16] arm64: ras: Add probe/remove for arm64_ras driver
Date: Tue,  2 Jun 2026 15:15:25 +0800
Message-ID: <20260602071540.3711528-3-tianruidong@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260602071540.3711528-1-tianruidong@linux.alibaba.com>
References: <20260602071540.3711528-1-tianruidong@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Introduce the back-end platform driver that binds to the devices
created by the AEST front-end. Driver input is taken exclusively from
fwnode properties, so the same probe path serves any future front-end
(DT, hand-rolled) without conditional code.

The probe builds two layers of state:

  - struct ras_node:   one AEST error source
  - struct ras_record: one error record inside a node

This split mirrors the hardware: a node owns the shared MMIO/ERRGSR
window and policy, while records are the unit at which errors are
reported, masked and polled. Later patches plug interrupts, decoding,
storm mitigation and userspace ABI onto these two objects without
touching the front-end.

Signed-off-by: Umang Chheda <umang.chheda@oss.qualcomm.com>
Signed-off-by: Ruidong Tian <tianruidong@linux.alibaba.com>
---
 MAINTAINERS                  |   2 +
 arch/arm64/include/asm/ras.h |  15 ++
 drivers/ras/Kconfig          |   1 +
 drivers/ras/Makefile         |   1 +
 drivers/ras/arm64/Kconfig    |  16 +++
 drivers/ras/arm64/Makefile   |   5 +
 drivers/ras/arm64/ras-core.c | 266 +++++++++++++++++++++++++++++++++++
 drivers/ras/arm64/ras.h      | 104 ++++++++++++++
 include/linux/acpi_aest.h    |   3 +
 9 files changed, 413 insertions(+)
 create mode 100644 arch/arm64/include/asm/ras.h
 create mode 100644 drivers/ras/arm64/Kconfig
 create mode 100644 drivers/ras/arm64/Makefile
 create mode 100644 drivers/ras/arm64/ras-core.c
 create mode 100644 drivers/ras/arm64/ras.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 16c80a7ea72c..766d1240b465 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -349,7 +349,9 @@ M:	Ruidong Tian <tianruidong@linux.alibaba.com>
 L:	linux-acpi@vger.kernel.org
 L:	linux-arm-kernel@lists.infradead.org
 S:	Supported
+F:	arch/arm64/include/asm/ras.h
 F:	drivers/acpi/arm64/aest.c
+F:	drivers/ras/arm64/
 F:	include/linux/acpi_aest.h
 
 ACPI FOR RISC-V (ACPI/riscv)
diff --git a/arch/arm64/include/asm/ras.h b/arch/arm64/include/asm/ras.h
new file mode 100644
index 000000000000..b6640b9972bf
--- /dev/null
+++ b/arch/arm64/include/asm/ras.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ASM_RAS_H
+#define __ASM_RAS_H
+
+#include <linux/types.h>
+
+struct ras_ext_regs {
+	u64 err_fr;
+	u64 err_ctlr;
+	u64 err_status;
+	u64 err_addr;
+	u64 err_misc[4];
+};
+
+#endif /* __ASM_RAS_H */
diff --git a/drivers/ras/Kconfig b/drivers/ras/Kconfig
index fc4f4bb94a4c..61e545993609 100644
--- a/drivers/ras/Kconfig
+++ b/drivers/ras/Kconfig
@@ -33,6 +33,7 @@ if RAS
 
 source "arch/x86/ras/Kconfig"
 source "drivers/ras/amd/atl/Kconfig"
+source "drivers/ras/arm64/Kconfig"
 
 config RAS_FMPM
 	tristate "FRU Memory Poison Manager"
diff --git a/drivers/ras/Makefile b/drivers/ras/Makefile
index 11f95d59d397..1b62a3017fa3 100644
--- a/drivers/ras/Makefile
+++ b/drivers/ras/Makefile
@@ -5,3 +5,4 @@ obj-$(CONFIG_RAS_CEC)	+= cec.o
 
 obj-$(CONFIG_RAS_FMPM)	+= amd/fmpm.o
 obj-y			+= amd/atl/
+obj-$(CONFIG_ARM64_RAS_DRIVER)	+= arm64/
diff --git a/drivers/ras/arm64/Kconfig b/drivers/ras/arm64/Kconfig
new file mode 100644
index 000000000000..dcdeaa216d67
--- /dev/null
+++ b/drivers/ras/arm64/Kconfig
@@ -0,0 +1,16 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# ARM Error Source Table Support
+#
+# Copyright (c) 2025, Alibaba Group.
+#
+
+config ARM64_RAS_DRIVER
+	tristate "ARM64 RAS Driver"
+	depends on ARM64 && ACPI_AEST && RAS
+	help
+	  This is the RAS driver for the arm64 architecture. It depends on
+	  the Arm Error Source Table (AEST) to provide basic register and
+	  interrupt information.
+
+	  If set, the kernel will report and process hardware errors.
diff --git a/drivers/ras/arm64/Makefile b/drivers/ras/arm64/Makefile
new file mode 100644
index 000000000000..c5387f05a067
--- /dev/null
+++ b/drivers/ras/arm64/Makefile
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+obj-$(CONFIG_ARM64_RAS_DRIVER) 	+= arm64_ras.o
+
+arm64_ras-y		:= ras-core.o
diff --git a/drivers/ras/arm64/ras-core.c b/drivers/ras/arm64/ras-core.c
new file mode 100644
index 000000000000..b5448f4a841f
--- /dev/null
+++ b/drivers/ras/arm64/ras-core.c
@@ -0,0 +1,266 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * ARM Error Source Table Support
+ *
+ * Copyright (c) 2025, Alibaba Group.
+ */
+
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/ras.h>
+
+#include "ras.h"
+
+#undef pr_fmt
+#define pr_fmt(fmt) "arm64_ras: " fmt
+
+static const char *const ras_node_name[] = {
+	[ACPI_AEST_PROCESSOR_ERROR_NODE] = "processor",
+	[ACPI_AEST_MEMORY_ERROR_NODE] = "memory",
+	[ACPI_AEST_SMMU_ERROR_NODE] = "smmu",
+	[ACPI_AEST_VENDOR_ERROR_NODE] = "vendor",
+	[ACPI_AEST_GIC_ERROR_NODE] = "gic",
+	[ACPI_AEST_PCIE_ERROR_NODE] = "pcie",
+	[ACPI_AEST_PROXY_ERROR_NODE] = "proxy",
+};
+
+const struct ras_group ras_group_config[] = {
+	[ACPI_AEST_NODE_GROUP_FORMAT_4K] = {
+		.errgsr_num = ERXGROUP_4K_ERRGSR_NUM,
+		.size = ERXGROUP_4K_SIZE,
+		.errgsr_offset = ERXGROUP_4K_OFFSET,
+	},
+	[ACPI_AEST_NODE_GROUP_FORMAT_16K] = {
+		.errgsr_num = ERXGROUP_16K_ERRGSR_NUM,
+		.size = ERXGROUP_16K_SIZE,
+		.errgsr_offset = ERXGROUP_16K_OFFSET,
+	},
+	[ACPI_AEST_NODE_GROUP_FORMAT_64K] = {
+		.errgsr_num = ERXGROUP_64K_ERRGSR_NUM,
+		.size = ERXGROUP_64K_SIZE,
+		.errgsr_offset = ERXGROUP_64K_OFFSET,
+	},
+};
+
+static int ras_init_record(struct ras_record *record, int i, struct ras_node *node)
+{
+	record->name = devm_kasprintf(node->dev, GFP_KERNEL, "record%d", i);
+	if (!record->name)
+		return -ENOMEM;
+
+	if (node->base)
+		record->regs_base = node->base + sizeof(struct ras_ext_regs) * i;
+
+	record->index = i;
+	record->node = node;
+
+	return 0;
+}
+
+static char *alloc_ras_node_name(struct ras_node *node)
+{
+	char *name;
+	struct acpi_aest_processor *processor = NULL;
+
+	switch (node->type) {
+	case ACPI_AEST_PROCESSOR_ERROR_NODE:
+		processor = (struct acpi_aest_processor *)node->specific_data;
+
+		/*
+		 * Shared/global processor nodes (e.g. cluster L3 cache, DSU)
+		 * have processor_id=0 and use smp_processor_id() at error-log
+		 * time — using processor_id in the name would produce the same
+		 * "processor.0" string for every shared node and every CPU0
+		 * per-PE node, making logs ambiguous.
+		 *
+		 * For shared/global nodes, build the name from the resource
+		 * type and the device id so each node gets a unique, meaningful
+		 * name (e.g. "processor.cache.1", "processor.tlb.2").
+		 *
+		 * For per-PE nodes, keep the original "processor.<mpidr>" form.
+		 */
+		if (processor->flags &
+		    (ACPI_AEST_PROC_FLAG_SHARED | ACPI_AEST_PROC_FLAG_GLOBAL)) {
+			static const char *const res_name[] = {
+				[ACPI_AEST_CACHE_RESOURCE]   = "cache",
+				[ACPI_AEST_TLB_RESOURCE]     = "tlb",
+				[ACPI_AEST_GENERIC_RESOURCE] = "generic",
+			};
+			u8 rtype = processor->resource_type;
+			const char *rstr = (rtype < ARRAY_SIZE(res_name) &&
+				res_name[rtype]) ? res_name[rtype] : "unknown";
+
+			name = devm_kasprintf(node->dev, GFP_KERNEL,
+					      "%s.%s.%x",
+					      ras_node_name[node->type],
+					      rstr,
+					      *(u32 *)(processor + 1));
+		} else {
+			name = devm_kasprintf(node->dev, GFP_KERNEL,
+					      "%s.%d",
+					      ras_node_name[node->type],
+					      processor->processor_id);
+		}
+		break;
+	case ACPI_AEST_MEMORY_ERROR_NODE:
+	case ACPI_AEST_SMMU_ERROR_NODE:
+	case ACPI_AEST_VENDOR_ERROR_NODE:
+	case ACPI_AEST_GIC_ERROR_NODE:
+	case ACPI_AEST_PCIE_ERROR_NODE:
+	case ACPI_AEST_PROXY_ERROR_NODE:
+		name = devm_kasprintf(node->dev, GFP_KERNEL, "%s.%llx",
+				      ras_node_name[node->type], node->addr);
+		break;
+	default:
+		dev_warn(node->dev, "unknown AEST node type %u\n", node->type);
+		return NULL;
+	}
+
+	return name;
+}
+
+static int ras_node_set_errgsr(struct ras_node *node, phys_addr_t base)
+{
+	phys_addr_t errgsr_base;
+	int ret;
+
+	if (!(node->flags & AEST_XFACE_FLAG_ERROR_GROUP)) {
+		node->errgsr = node->base + node->group->errgsr_offset;
+		return 0;
+	}
+
+	ret = device_property_read_u64(node->dev, "arm,error-group-base",
+				       &errgsr_base);
+	if (ret || !errgsr_base)
+		return -EINVAL;
+
+	node->errgsr = errgsr_base - base + node->base;
+	return 0;
+}
+
+static struct ras_node *ras_init_node(struct platform_device *pdev)
+{
+	int i, ret = 0;
+	struct device *dev = &pdev->dev;
+	struct resource *mem;
+	struct ras_node *node;
+
+	node = devm_kzalloc(&pdev->dev, sizeof(*node), GFP_KERNEL);
+	if (!node)
+		return ERR_PTR(-ENOMEM);
+
+	node->dev = &pdev->dev;
+
+	ret = ret ?: device_property_read_u8(dev, "arm,node-type", &node->type);
+	ret = ret ?: device_property_read_u8(dev, "arm,group-format", &node->group_format);
+	ret = ret ?: device_property_read_u32(dev, "arm,interface-flags", &node->flags);
+	ret = ret ?: device_property_read_u32(dev, "arm,error-records-count", &node->record_count);
+	ret = ret ?: device_property_read_u32(dev, "arm,error-records-index", &node->record_index);
+	if (ret)
+		return ERR_PTR(ret);
+	node->group = &ras_group_config[node->group_format];
+
+	node->record_implemented = devm_bitmap_zalloc(dev,
+					node->group->errgsr_num * BITS_PER_TYPE(u64),
+					GFP_KERNEL);
+	if (!node->record_implemented)
+		return ERR_PTR(-ENOMEM);
+	node->status_reporting = devm_bitmap_zalloc(dev,
+					node->group->errgsr_num * BITS_PER_TYPE(u64),
+					GFP_KERNEL);
+	if (!node->status_reporting)
+		return ERR_PTR(-ENOMEM);
+
+	ret = device_property_read_u64_array(dev, "arm,record-implemented",
+					     (u64 *)node->record_implemented,
+					     node->group->errgsr_num);
+	ret = ret ?: device_property_read_u64_array(dev, "arm,status-reporting",
+						    (u64 *)node->status_reporting,
+						    node->group->errgsr_num);
+	if (ret)
+		return ERR_PTR(ret);
+
+	node->specific_data_size = device_property_count_u8(dev, "arm,node-specific-data");
+	if (node->specific_data_size > 0) {
+		node->specific_data = devm_kzalloc(dev, node->specific_data_size, GFP_KERNEL);
+		if (!node->specific_data)
+			return ERR_PTR(-ENOMEM);
+		ret = device_property_read_u8_array(dev, "arm,node-specific-data",
+						    node->specific_data,
+						    node->specific_data_size);
+		if (ret)
+			return ERR_PTR(ret);
+	}
+
+	mem = platform_get_resource(to_platform_device(dev), IORESOURCE_MEM, 0);
+	if (mem) {
+		node->addr = mem->start;
+		node->base = devm_ioremap(node->dev, mem->start, resource_size(mem));
+		if (!node->base)
+			return ERR_PTR(-ENOMEM);
+
+		ret = ras_node_set_errgsr(node, mem->start);
+		if (ret)
+			return ERR_PTR(ret);
+	}
+
+	node->name = alloc_ras_node_name(node);
+	if (!node->name)
+		return ERR_PTR(-ENOMEM);
+
+	node->records = devm_kcalloc(node->dev, node->record_count,
+				     sizeof(struct ras_record), GFP_KERNEL);
+	if (!node->records)
+		return ERR_PTR(-ENOMEM);
+
+	for (i = 0; i < node->record_count; i++) {
+		ret = ras_init_record(&node->records[i],
+				      i + node->record_index, node);
+		if (ret)
+			return ERR_PTR(ret);
+	}
+	ras_node_dbg(node, "base: %llx\n", node->addr);
+	return node;
+}
+
+static int arm64_ras_probe(struct platform_device *pdev)
+{
+	int ret;
+	struct ras_node *node;
+
+	node = ras_init_node(pdev);
+	if (IS_ERR(node))
+		return PTR_ERR(node);
+
+	ret = dev_set_name(&pdev->dev, "%s%d", ras_node_name[node->type],
+			   pdev->id);
+	if (ret)
+		return ret;
+
+	platform_set_drvdata(pdev, node);
+
+	return 0;
+}
+
+static struct platform_driver arm64_ras_driver = {
+	.driver	= {
+		.name	= "arm64_ras",
+	},
+	.probe	= arm64_ras_probe,
+};
+
+static int __init arm64_ras_init(void)
+{
+	return platform_driver_register(&arm64_ras_driver);
+}
+module_init(arm64_ras_init);
+
+static void __exit arm64_ras_exit(void)
+{
+	platform_driver_unregister(&arm64_ras_driver);
+}
+module_exit(arm64_ras_exit);
+
+MODULE_DESCRIPTION("ARM RAS Driver");
+MODULE_AUTHOR("Ruidong Tian <tianruidong@linux.alibaba.com>");
+MODULE_LICENSE("GPL");
diff --git a/drivers/ras/arm64/ras.h b/drivers/ras/arm64/ras.h
new file mode 100644
index 000000000000..3d83f8b26da7
--- /dev/null
+++ b/drivers/ras/arm64/ras.h
@@ -0,0 +1,104 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * ARM Error Source Table Support
+ *
+ * Copyright (c) 2025, Alibaba Group.
+ */
+
+#ifndef _DRIVERS_RAS_ARM64_RAS_H_
+#define _DRIVERS_RAS_ARM64_RAS_H_
+
+#include <linux/acpi_aest.h>
+#include <asm/ras.h>
+
+#define ras_node_err(__node, format, ...)                          \
+	dev_err((__node)->dev, "%s: " format, (__node)->name, \
+		##__VA_ARGS__)
+#define ras_node_info(__node, format, ...)                          \
+	dev_info((__node)->dev, "%s: " format, (__node)->name, \
+		 ##__VA_ARGS__)
+#define ras_node_dbg(__node, format, ...)                          \
+	dev_dbg((__node)->dev, "%s: " format, (__node)->name, \
+		##__VA_ARGS__)
+
+#define ras_record_err(__record, format, ...)                  \
+	dev_err((__record)->node->dev, "%s: %s: " format, \
+		(__record)->node->name, (__record)->name, ##__VA_ARGS__)
+#define ras_record_info(__record, format, ...)                  \
+	dev_info((__record)->node->dev, "%s: %s: " format, \
+		 (__record)->node->name, (__record)->name, ##__VA_ARGS__)
+#define ras_record_dbg(__record, format, ...)                  \
+	dev_dbg((__record)->node->dev, "%s: %s: " format, \
+		(__record)->node->name, (__record)->name, ##__VA_ARGS__)
+
+#define ERXGROUP_4K_OFFSET		0xE00
+#define ERXGROUP_16K_OFFSET		0x3800
+#define ERXGROUP_64K_OFFSET		0xE000
+#define ERXGROUP_4K_SIZE		SZ_4K
+#define ERXGROUP_16K_SIZE		SZ_16K
+#define ERXGROUP_64K_SIZE		SZ_64K
+#define ERXGROUP_4K_ERRGSR_NUM		1
+#define ERXGROUP_16K_ERRGSR_NUM		4
+#define ERXGROUP_64K_ERRGSR_NUM		14
+
+struct ras_record {
+	char *name;
+	void __iomem *regs_base;
+	struct ras_node *node;
+
+	int index;
+};
+
+struct ras_group {
+	int errgsr_num;
+	size_t size;
+	u64 errgsr_offset;
+};
+
+extern const struct ras_group ras_group_config[];
+
+struct ras_node {
+	char *name;
+
+	struct device *dev;
+	const struct ras_group *group;
+
+	void __iomem *base;
+	void __iomem *errgsr;
+	phys_addr_t addr;
+
+	u8 *specific_data;
+	/*
+	 * This bitmap indicates which of the error records within this error
+	 * node must be polled for error status.
+	 * Bit[n] of this field pertains to error record corresponding to
+	 * index n in this error group.
+	 * Bit[n] = 0b: Error record at index n needs to be polled.
+	 * Bit[n] = 1b: Error record at index n does not need to be polled.
+	 */
+	unsigned long *record_implemented;
+	/*
+	 * This bitmap indicates which of the error records within this error
+	 * node support error status reporting using ERRGSR register.
+	 * Bit[n] of this field pertains to error record corresponding to
+	 * index n in this error group.
+	 * Bit[n] = 0b: Error record at index n supports error status reporting
+	 *              through ERRGSR.S.
+	 * Bit[n] = 1b: Error record at index n does not support error reporting
+	 *              through the ERRGSR.S bit. If this error record is
+	 *              implemented, then it must be polled explicitly for
+	 *              error events.
+	 */
+	unsigned long *status_reporting;
+	struct ras_record *records;
+
+	u32 specific_data_size;
+	u32 record_count;
+	u32 record_index;
+	u32 flags;
+
+	u8 type;
+	u8 group_format;
+};
+
+#endif /* _DRIVERS_RAS_ARM64_RAS_H_ */
diff --git a/include/linux/acpi_aest.h b/include/linux/acpi_aest.h
index e485a6236891..df6369bcc96b 100644
--- a/include/linux/acpi_aest.h
+++ b/include/linux/acpi_aest.h
@@ -16,4 +16,7 @@
 #define AEST_XFACE_FLAG_FAULT_INJECT	BIT(5)
 #define AEST_XFACE_FLAG_INT_CONFIG	BIT(6)
 
+#define ACPI_AEST_PROC_FLAG_GLOBAL	BIT(0)
+#define ACPI_AEST_PROC_FLAG_SHARED	BIT(1)
+
 #endif /* __ACPI_AEST_H__ */
-- 
2.51.2.612.gdc70283dfc

