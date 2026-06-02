Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3ECCA6B;
	Tue,  2 Jun 2026 07:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780384570; cv=none; b=bneY9mDswetf4tdUAFJm1YP5M2RAREc4JMOhmyiHRXZT2tSvi7TyIs9jS/e8HUETMBJm/aAQn8ARMp/oLPmU/5u7lWurB0TM6zxyHlbNulAMC3zevO9ajeiTAA6/09fGLt899E363Mrf27qb0X4rB06ofJvKJqt5g+tdWG5ljD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780384570; c=relaxed/simple;
	bh=An9KDj2M+K9eutYkfQ/1UTH5MdV8TP/xRRi2LTL0edY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tn8xYYZi39SrYmrElSad9VO7hRXeBBRzkMAqnyOAYR8Mg2fV1EoWM+1xshWEfjDAk1OlcAqrFdvjoBfZ5TRmOZprobezMzzsCD0epECo+QZ4qKlvFdnflJtaRcffLt/x/yXK3s8EqRkB3n0Opu8qN45TjxSYw8sBB+RH6kK5M+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=vQpV7CDF; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="vQpV7CDF"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1780384562; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=aiCdx3Q8seVVXlkwNhOkJDJdYZEvP8kG8HhMkkSmX6Q=;
	b=vQpV7CDF/IRM/YlA4QbknG1LJZEeyiY1EzJO/mBAa7QHoO299282QZi85IS9pYUWo+UX407rCTGwTqB40AaXh/6x2a8zlU7mHkUq2vhhgpZM9volKh3bx2JRZCKTF15cTk4G27earxfXuYD7oN7SRRYD9ce73cbabod/6/DYk3w=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=tianruidong@linux.alibaba.com;NM=1;PH=DS;RN=20;SR=0;TI=SMTPD_---0X43R2cW_1780384560;
Received: from t50a05405.sqa.eu95.tbsite.net(mailfrom:tianruidong@linux.alibaba.com fp:SMTPD_---0X43R2cW_1780384560 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 02 Jun 2026 15:16:01 +0800
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
Subject: [PATCH v7 05/16] arm64: ras: Plumb AEST interrupts as platform IRQ resources
Date: Tue,  2 Jun 2026 15:15:28 +0800
Message-ID: <20260602071540.3711528-6-tianruidong@linux.alibaba.com>
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

AEST describes one or more interrupts per error source for delivering
Fault Handling (FHI) and Error Recovery (ERI) events.

This change keeps the existing front-end / back-end split:

  - The ACPI front-end is the only place that understands AEST
    interrupt encodings; it registers each GSI and exposes the
    resulting Linux IRQs as named platform resources
    ("AEST:FHI" / "AEST:ERI").

  - The back-end looks up its IRQs by name and requests them
    according to routing type. SPIs are device-shared and use a
    normal shared handler. PPIs are inherently per-CPU, so the node
    is cloned into a percpu ras_node and the handler is installed
    via request_percpu_irq() with that percpu cookie, ensuring each
    CPU services its own copy of the source.

Signed-off-by: Ruidong Tian <tianruidong@linux.alibaba.com>
---
 drivers/acpi/arm64/aest.c    |  56 +++++++++++++++++-
 drivers/ras/arm64/ras-core.c | 109 +++++++++++++++++++++++++++++++++++
 drivers/ras/arm64/ras.h      |   2 +
 include/linux/acpi_aest.h    |   7 +++
 4 files changed, 172 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/arm64/aest.c b/drivers/acpi/arm64/aest.c
index 868013498abb..af03f4365cfa 100644
--- a/drivers/acpi/arm64/aest.c
+++ b/drivers/acpi/arm64/aest.c
@@ -15,6 +15,40 @@
 #undef pr_fmt
 #define pr_fmt(fmt) "ACPI AEST: " fmt
 
+static int acpi_aest_parse_irqs(struct platform_device *pdev,
+				struct acpi_aest_hdr *aest_hdr,
+				struct resource *res, int *res_idx)
+{
+	int i;
+	struct acpi_aest_node_interrupt_v2 *interrupt;
+	int trigger, irq;
+
+	interrupt = ACPI_ADD_PTR(struct acpi_aest_node_interrupt_v2, aest_hdr,
+				aest_hdr->node_interrupt_offset);
+	for (i = 0; i < aest_hdr->node_interrupt_count; i++, interrupt++) {
+		trigger = (interrupt->flags & AEST_INTERRUPT_MODE) ?
+				  ACPI_LEVEL_SENSITIVE :
+				  ACPI_EDGE_SENSITIVE;
+
+		irq = acpi_register_gsi(&pdev->dev, interrupt->gsiv, trigger,
+					ACPI_ACTIVE_HIGH);
+		if (irq <= 0) {
+			pr_err("failed to map AEST GSI %d\n", interrupt->gsiv);
+			return irq ? irq : -EINVAL;
+		}
+
+		res[*res_idx].start = irq;
+		res[*res_idx].end = irq;
+		res[*res_idx].flags = IORESOURCE_IRQ;
+		res[*res_idx].name = interrupt->type ? AEST_ERI_NAME :
+						       AEST_FHI_NAME;
+
+		(*res_idx)++;
+	}
+
+	return 0;
+}
+
 /*
  * Fill the per-AEST-entry inner properties (node-type / interface-type /
  * group-format / record bitmaps / register bases ...).
@@ -25,9 +59,11 @@ aest_init_node_props(struct acpi_aest_hdr *hdr, struct property_entry *props,
 {
 	struct acpi_aest_node_interface_header *interface;
 	struct acpi_aest_node_interface_common *common = NULL;
+	struct acpi_aest_node_interrupt_v2 *interrupt;
 	u64 *record_implemented = NULL;
 	u64 *status_reporting = NULL;
 	u64 *addressing_mode = NULL;
+	u32 fhi_gsiv = 0, eri_gsiv = 0;
 	int group_len = 0, i;
 	size_t len;
 
@@ -72,6 +108,15 @@ aest_init_node_props(struct acpi_aest_hdr *hdr, struct property_entry *props,
 		return -EINVAL;
 	}
 
+	interrupt = ACPI_ADD_PTR(struct acpi_aest_node_interrupt_v2, hdr,
+				 hdr->node_interrupt_offset);
+	for (i = 0; i < hdr->node_interrupt_count; i++, interrupt++) {
+		if (interrupt->type == ACPI_AEST_NODE_FAULT_HANDLING)
+			fhi_gsiv = interrupt->gsiv;
+		else if (interrupt->type == ACPI_AEST_NODE_ERROR_RECOVERY)
+			eri_gsiv = interrupt->gsiv;
+	}
+
 	if (interface->flags & AEST_XFACE_FLAG_ERROR_DEVICE) {
 		struct acpi_device *companion;
 		char uid[16];
@@ -112,6 +157,8 @@ aest_init_node_props(struct acpi_aest_hdr *hdr, struct property_entry *props,
 					   common->error_group_register_base);
 	props[(*p)++] = PROPERTY_ENTRY_U64("arm,fault-inject-base",
 					   common->fault_inject_register_base);
+	props[(*p)++] = PROPERTY_ENTRY_U32("arm,fhi-gsiv", fhi_gsiv);
+	props[(*p)++] = PROPERTY_ENTRY_U32("arm,eri-gsiv", eri_gsiv);
 
 	len = hdr->node_interface_offset - hdr->node_specific_offset;
 	props[(*p)++] =
@@ -124,7 +171,7 @@ aest_init_node_props(struct acpi_aest_hdr *hdr, struct property_entry *props,
 static int __init
 aest_create_node_fwnode(struct acpi_aest_hdr *hdr, struct platform_device *pdev)
 {
-	struct property_entry props[12] = { };
+	struct property_entry props[14] = { };
 	int p = 0;
 	int ret;
 
@@ -163,7 +210,8 @@ acpi_aest_alloc_pdev(struct acpi_aest_hdr *aest_hdr)
 	if (!pdev)
 		return ERR_PTR(-ENOMEM);
 
-	res = kcalloc(1, sizeof(*res), GFP_KERNEL);
+	res = kcalloc(AEST_MAX_INTERRUPT_PER_NODE + 1, sizeof(*res),
+		      GFP_KERNEL);
 	if (!res)
 		return ERR_PTR(-ENOMEM);
 
@@ -177,6 +225,10 @@ acpi_aest_alloc_pdev(struct acpi_aest_hdr *aest_hdr)
 		j++;
 	}
 
+	ret = acpi_aest_parse_irqs(pdev, aest_hdr, res, &j);
+	if (ret)
+		return ERR_PTR(ret);
+
 	ret = platform_device_add_resources(pdev, res, j);
 	if (ret)
 		return ERR_PTR(ret);
diff --git a/drivers/ras/arm64/ras-core.c b/drivers/ras/arm64/ras-core.c
index 1dd471376449..9520415df8cb 100644
--- a/drivers/ras/arm64/ras-core.c
+++ b/drivers/ras/arm64/ras-core.c
@@ -5,6 +5,7 @@
  * Copyright (c) 2025, Alibaba Group.
  */
 
+#include <linux/interrupt.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/ras.h>
@@ -14,6 +15,8 @@
 #undef pr_fmt
 #define pr_fmt(fmt) "arm64_ras: " fmt
 
+static DEFINE_PER_CPU(struct ras_node, percpu_ras_node);
+
 static const char *const ras_node_name[] = {
 	[ACPI_AEST_PROCESSOR_ERROR_NODE] = "processor",
 	[ACPI_AEST_MEMORY_ERROR_NODE] = "memory",
@@ -42,6 +45,55 @@ const struct ras_group ras_group_config[] = {
 	},
 };
 
+static irqreturn_t ras_irq_func(int irq, void *input)
+{
+	struct ras_node *node = input;
+
+	return IRQ_HANDLED;
+}
+
+static int ras_register_irq(struct ras_node *node)
+{
+	int i, irq, ret;
+	char *irq_desc;
+
+	irq_desc = devm_kasprintf(node->dev, GFP_KERNEL, "%s.%s.",
+				  dev_driver_string(node->dev),
+				  node->name);
+	if (!irq_desc)
+		return -ENOMEM;
+
+	for (i = 0; i < AEST_MAX_INTERRUPT_PER_NODE; i++) {
+		irq = node->irq[i];
+
+		if (!irq)
+			continue;
+
+		if (irq_is_percpu_devid(irq)) {
+			ret = request_percpu_irq(irq, ras_irq_func, irq_desc,
+						 node->oncore_node);
+			if (ret)
+				goto free;
+		} else {
+			ret = devm_request_irq(node->dev, irq, ras_irq_func, IRQF_SHARED,
+					       irq_desc, node);
+			if (ret)
+				return ret;
+		}
+	}
+	return 0;
+
+free:
+	for (i = i - 1; i >= 0; i--) {
+		irq = node->irq[i];
+
+		if (irq_is_percpu_devid(irq))
+			free_percpu_irq(irq, node->oncore_node);
+	}
+
+	return ret;
+}
+
 static int ras_init_record(struct ras_record *record, int i, struct ras_node *node)
 {
 	record->name = devm_kasprintf(node->dev, GFP_KERNEL, "record%d", i);
@@ -249,6 +301,53 @@ static struct ras_node *ras_init_node(struct platform_device *pdev)
 	return node;
 }
 
+
+static int __setup_ppi(struct ras_node *node)
+{
+	int cpu;
+	struct ras_node *oncore_node;
+	size_t size;
+
+	node->oncore_node = &percpu_ras_node;
+	for_each_possible_cpu(cpu) {
+		oncore_node = per_cpu_ptr(&percpu_ras_node, cpu);
+		memcpy(oncore_node, node, sizeof(struct ras_node));
+
+		oncore_node->records = devm_kcalloc(
+			node->dev, oncore_node->record_count,
+			sizeof(struct ras_record), GFP_KERNEL);
+		if (!oncore_node->records)
+			return -ENOMEM;
+
+		size = oncore_node->record_count *
+			sizeof(struct ras_record);
+		memcpy(oncore_node->records, node->records, size);
+
+		ras_node_dbg(node, "Init node on CPU%d.\n", cpu);
+	}
+
+	return 0;
+}
+
+static int ras_setup_irq(struct platform_device *pdev, struct ras_node *node)
+{
+	int fhi_irq, eri_irq;
+
+	fhi_irq = platform_get_irq_byname_optional(pdev, AEST_FHI_NAME);
+	if (fhi_irq > 0)
+		node->irq[ACPI_AEST_NODE_FAULT_HANDLING] = fhi_irq;
+
+	eri_irq = platform_get_irq_byname_optional(pdev, AEST_ERI_NAME);
+	if (eri_irq > 0)
+		node->irq[ACPI_AEST_NODE_ERROR_RECOVERY] = eri_irq;
+
+	/* Allocate and initialise the percpu device pointer for PPI */
+	if (irq_is_percpu(fhi_irq) || irq_is_percpu(eri_irq))
+		return __setup_ppi(node);
+
+	return 0;
+}
+
 static int arm64_ras_probe(struct platform_device *pdev)
 {
 	int ret;
@@ -263,6 +362,16 @@ static int arm64_ras_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	ret = ras_setup_irq(pdev, node);
+	if (ret)
+		return ret;
+
+	ret = ras_register_irq(node);
+	if (ret) {
+		ras_node_err(node, "register irq failed\n");
+		return ret;
+	}
+
 	platform_set_drvdata(pdev, node);
 
 	return 0;
diff --git a/drivers/ras/arm64/ras.h b/drivers/ras/arm64/ras.h
index da03593e5f7f..b64eae59b6ac 100644
--- a/drivers/ras/arm64/ras.h
+++ b/drivers/ras/arm64/ras.h
@@ -85,6 +85,7 @@ struct ras_node {
 
 	struct device *dev;
 	const struct ras_group *group;
+	struct ras_node __percpu *oncore_node;
 
 	void __iomem *base;
 	void __iomem *errgsr;
@@ -124,6 +125,7 @@ struct ras_node {
 	u8 type;
 	u8 access_type;
 	u8 group_format;
+	u32 irq[AEST_MAX_INTERRUPT_PER_NODE];
 };
 
 #define CASE_READ(res, x)                           \
diff --git a/include/linux/acpi_aest.h b/include/linux/acpi_aest.h
index df6369bcc96b..a462895a7b5a 100644
--- a/include/linux/acpi_aest.h
+++ b/include/linux/acpi_aest.h
@@ -6,6 +6,13 @@
 
 /* AEST resource name */
 #define AEST_NODE_NAME "AEST:NODE"
+#define AEST_FHI_NAME "AEST:FHI"
+#define AEST_ERI_NAME "AEST:ERI"
+
+/* AEST interrupt */
+#define AEST_INTERRUPT_MODE BIT(0)
+
+#define AEST_MAX_INTERRUPT_PER_NODE 2
 
 /* AEST interface */
 #define AEST_XFACE_FLAG_SHARED		BIT(0)
-- 
2.51.2.612.gdc70283dfc

