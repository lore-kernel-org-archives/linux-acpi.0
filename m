Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD14376BC2;
	Tue,  2 Jun 2026 07:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780384574; cv=none; b=VHhNgSn05m3YWzvz1hw79n/yoBlGTJ31aHQJwOxOE1keXlrJQqjJHezpTQTYxxrXhQRQwSeFowSM7B841uJOKT2DKc2jsPCw+XVrFG1onswWZbgLEjQIihtaDbhp/JzTl33sJhNyQi65MCl30cHrqruE12pXFgManzLK9YhVvYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780384574; c=relaxed/simple;
	bh=CgcjcuPBxEx8U7Jt3cd3b1xIp0omNfWJVhkqvzvq26I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TnLNElUAEN1WETvAWZVPBCkMEijWmcf/b3AlsnoPnOVwvcM7ihOUBQQDYqsag4tWHCdAlOBEWeEeTduweNs3jdD/7ZtL6/UgZEziHpb4ozpcMCTEpcLtUInP8bkqvkWdVQr+y2g2r3gAS5VBD9zGMW+EIfJX4q+QxzZvCyxze6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=YKJ0sDQh; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="YKJ0sDQh"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1780384564; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=h3iv51PzsH25Ajqxiiu8MZp/L1z6wfeiwmy5WW7gSNI=;
	b=YKJ0sDQhSZsjSQCybnlrt8mOVnVeehcEqu47bijn4wMpzSsxuqxxqxjWmHW2Ig9MDNoQvxeK2UmdxHZS8UEy5dpq8t+f1UgAxD8DpZBJ5AFpTmB+gnGc7fYbGoye2AFuD3VC795VOni3sFayjtztzn1f5mTujjgAjhGB4SrPJjI=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=tianruidong@linux.alibaba.com;NM=1;PH=DS;RN=20;SR=0;TI=SMTPD_---0X43R2cw_1780384562;
Received: from t50a05405.sqa.eu95.tbsite.net(mailfrom:tianruidong@linux.alibaba.com fp:SMTPD_---0X43R2cw_1780384562 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 02 Jun 2026 15:16:03 +0800
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
Subject: [PATCH v7 06/16] arm64: ras: Enable error reporting
Date: Tue,  2 Jun 2026 15:15:29 +0800
Message-ID: <20260602071540.3711528-7-tianruidong@linux.alibaba.com>
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

Until now, AEST nodes were registered but never had interrupt routing
programmed, so probe finished without actually arming any error source.
Both shared and PE (oncore) nodes need this bring-up; the difference
is only that oncore state is percpu and must follow CPU online/offline.

Signed-off-by: Ruidong Tian <tianruidong@linux.alibaba.com>
---
 arch/arm64/include/asm/ras.h |  10 +++
 drivers/acpi/arm64/aest.c    |   4 +-
 drivers/ras/arm64/ras-core.c | 159 ++++++++++++++++++++++++++++++++++-
 drivers/ras/arm64/ras.h      |  32 +++++++
 include/linux/cpuhotplug.h   |   1 +
 5 files changed, 204 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/ras.h b/arch/arm64/include/asm/ras.h
index b6640b9972bf..a992610d7755 100644
--- a/arch/arm64/include/asm/ras.h
+++ b/arch/arm64/include/asm/ras.h
@@ -2,8 +2,18 @@
 #ifndef __ASM_RAS_H
 #define __ASM_RAS_H
 
+#include <linux/bits.h>
 #include <linux/types.h>
 
+/* ERR<n>CTLR */
+#define ERR_CTLR_CFI			BIT(8)
+#define ERR_CTLR_FI			BIT(3)
+#define ERR_CTLR_UI			BIT(2)
+
+/* ERRIRQCR<n> */
+#define ERRFHICR0_OFFSET		0x0
+#define ERRERICR0_OFFSET		0x10
+
 struct ras_ext_regs {
 	u64 err_fr;
 	u64 err_ctlr;
diff --git a/drivers/acpi/arm64/aest.c b/drivers/acpi/arm64/aest.c
index af03f4365cfa..5733c91c8e0d 100644
--- a/drivers/acpi/arm64/aest.c
+++ b/drivers/acpi/arm64/aest.c
@@ -157,6 +157,8 @@ aest_init_node_props(struct acpi_aest_hdr *hdr, struct property_entry *props,
 					   common->error_group_register_base);
 	props[(*p)++] = PROPERTY_ENTRY_U64("arm,fault-inject-base",
 					   common->fault_inject_register_base);
+	props[(*p)++] = PROPERTY_ENTRY_U64("arm,interrupt-config-base",
+					   common->interrupt_config_register_base);
 	props[(*p)++] = PROPERTY_ENTRY_U32("arm,fhi-gsiv", fhi_gsiv);
 	props[(*p)++] = PROPERTY_ENTRY_U32("arm,eri-gsiv", eri_gsiv);
 
@@ -171,7 +173,7 @@ aest_init_node_props(struct acpi_aest_hdr *hdr, struct property_entry *props,
 static int __init
 aest_create_node_fwnode(struct acpi_aest_hdr *hdr, struct platform_device *pdev)
 {
-	struct property_entry props[14] = { };
+	struct property_entry props[15] = { };
 	int p = 0;
 	int ret;
 
diff --git a/drivers/ras/arm64/ras-core.c b/drivers/ras/arm64/ras-core.c
index 9520415df8cb..98f274b9731d 100644
--- a/drivers/ras/arm64/ras-core.c
+++ b/drivers/ras/arm64/ras-core.c
@@ -5,6 +5,7 @@
  * Copyright (c) 2025, Alibaba Group.
  */
 
+#include <linux/cpu.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
@@ -45,6 +46,21 @@ const struct ras_group ras_group_config[] = {
 	},
 };
 
+static void ras_node_foreach_record(void (*func)(struct ras_record *, void *),
+				    struct ras_node *node, void *data,
+				    unsigned long *bitmap)
+{
+	int i;
+
+	for_each_clear_bit(i, bitmap, node->record_count) {
+		ras_select_record(node, i);
+
+		func(&node->records[i], data);
+
+		ras_sync(node);
+	}
+	}
+
 static irqreturn_t ras_irq_func(int irq, void *input)
 {
 	struct ras_node *node = input;
@@ -52,6 +68,23 @@ static irqreturn_t ras_irq_func(int irq, void *input)
 	return IRQ_HANDLED;
 }
 
+static void ras_config_irq(struct ras_node *node)
+{
+	u32 fhi_gsi, eri_gsi;
+
+	if (!node->irq_config)
+		return;
+
+	if (!device_property_read_u32(node->dev, "arm,fhi-gsiv", &fhi_gsi))
+		writeq_relaxed(fhi_gsi, node->irq_config + ERRFHICR0_OFFSET);
+
+	if (!device_property_read_u32(node->dev, "arm,eri-gsiv", &eri_gsi))
+		writeq_relaxed(eri_gsi, node->irq_config + ERRERICR0_OFFSET);
+
+	ras_node_dbg(node, "config irq fhi_gsi %u eri_gsi %u at %pK",
+		     fhi_gsi, eri_gsi, node->irq_config);
+}
+
 static int ras_register_irq(struct ras_node *node)
 {
 	int i, irq, ret;
@@ -94,6 +127,21 @@ static int ras_register_irq(struct ras_node *node)
 	return ret;
 }
 
+static void ras_enable_irq(struct ras_record *record)
+{
+	struct ras_node *node = record->node;
+	u64 err_ctlr;
+
+	err_ctlr = record_read(record, ERXCTLR);
+
+	if (node->irq[0])
+		err_ctlr |= (ERR_CTLR_FI | ERR_CTLR_CFI);
+	if (node->irq[1])
+		err_ctlr |= ERR_CTLR_UI;
+
+	record_write(record, ERXCTLR, err_ctlr);
+}
+
 static int ras_init_record(struct ras_record *record, int i, struct ras_node *node)
 {
 	record->name = devm_kasprintf(node->dev, GFP_KERNEL, "record%d", i);
@@ -110,6 +158,85 @@ static int ras_init_record(struct ras_record *record, int i, struct ras_node *no
 	return 0;
 }
 
+static void ras_online_record(struct ras_record *record, void *data)
+{
+	ras_enable_irq(record);
+}
+
+static void ras_online_node(struct ras_node *node)
+{
+	if (!node->name)
+		return;
+
+	ras_config_irq(node);
+
+	ras_node_foreach_record(ras_online_record, node, NULL,
+				node->record_implemented);
+}
+
+static void ras_online_oncore_dev(void *data)
+{
+	int fhi_irq, eri_irq;
+	struct ras_node *node = this_cpu_ptr(data);
+
+	ras_online_node(node);
+
+	fhi_irq = node->irq[ACPI_AEST_NODE_FAULT_HANDLING];
+	if (fhi_irq > 0)
+		enable_percpu_irq(fhi_irq, IRQ_TYPE_NONE);
+	eri_irq = node->irq[ACPI_AEST_NODE_ERROR_RECOVERY];
+	if (eri_irq > 0)
+		enable_percpu_irq(eri_irq, IRQ_TYPE_NONE);
+}
+
+static void ras_offline_oncore_dev(void *data)
+{
+	int fhi_irq, eri_irq;
+	struct ras_node *node = this_cpu_ptr(data);
+
+	fhi_irq = node->irq[ACPI_AEST_NODE_FAULT_HANDLING];
+	if (fhi_irq > 0)
+		disable_percpu_irq(fhi_irq);
+	eri_irq = node->irq[ACPI_AEST_NODE_ERROR_RECOVERY];
+	if (eri_irq > 0)
+		disable_percpu_irq(eri_irq);
+}
+
+static int ras_starting_cpu(unsigned int cpu)
+{
+	pr_debug("CPU%d starting\n", cpu);
+	ras_online_oncore_dev(&percpu_ras_node);
+
+	return 0;
+}
+
+static int ras_dying_cpu(unsigned int cpu)
+{
+	pr_debug("CPU%d dying\n", cpu);
+	ras_offline_oncore_dev(&percpu_ras_node);
+
+	return 0;
+}
+
+static void arm64_ras_remove(struct platform_device *pdev)
+{
+	struct ras_node *node = platform_get_drvdata(pdev);
+	int i;
+
+	platform_set_drvdata(pdev, NULL);
+
+	if (node->type != ACPI_AEST_PROCESSOR_ERROR_NODE)
+		return;
+
+	cpuhp_remove_state(CPUHP_AP_ARM_RAS_STARTING);
+	on_each_cpu(ras_offline_oncore_dev, node->oncore_node, 1);
+
+	for (i = 0; i < AEST_MAX_INTERRUPT_PER_NODE; i++) {
+		if (node->irq[i])
+			free_percpu_irq(node->irq[i], node->oncore_node);
+	}
+}
+
 static char *alloc_ras_node_name(struct ras_node *node)
 {
 	char *name;
@@ -208,6 +335,23 @@ static int ras_node_set_inj_base(struct ras_node *node, phys_addr_t base)
 	return 0;
 }
 
+static int ras_node_set_irq_base(struct ras_node *node, phys_addr_t base)
+{
+	phys_addr_t irq_base;
+	int ret;
+
+	if (!(node->flags & AEST_XFACE_FLAG_INT_CONFIG))
+		return 0;
+
+	ret = device_property_read_u64(node->dev, "arm,interrupt-config-base",
+				       &irq_base);
+	if (ret || !irq_base)
+		return 0;
+
+	node->irq_config = irq_base - base + node->base;
+	return 0;
+}
+
 static struct ras_node *ras_init_node(struct platform_device *pdev)
 {
 	int i, ret = 0;
@@ -276,6 +420,9 @@ static struct ras_node *ras_init_node(struct platform_device *pdev)
 		ret = ras_node_set_inj_base(node, mem->start);
 		if (ret)
 			return ERR_PTR(ret);
+		ret = ras_node_set_irq_base(node, mem->start);
+		if (ret)
+			return ERR_PTR(ret);
 	} else if (node->access_type == ACPI_AEST_NODE_MEMORY_MAPPED) {
 		return ERR_PTR(-EINVAL);
 	}
@@ -372,6 +519,15 @@ static int arm64_ras_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	if (ras_node_is_oncore(node))
+		ret = cpuhp_setup_state(CPUHP_AP_ARM_RAS_STARTING,
+					"drivers/ras/arm64/ras:starting",
+					ras_starting_cpu, ras_dying_cpu);
+	else
+		ras_online_node(node);
+	if (ret)
+		return ret;
+
 	platform_set_drvdata(pdev, node);
 
 	return 0;
@@ -381,7 +537,8 @@ static struct platform_driver arm64_ras_driver = {
 	.driver	= {
 		.name	= "arm64_ras",
 	},
-	.probe	= arm64_ras_probe,
+	.probe		= arm64_ras_probe,
+	.remove		= arm64_ras_remove,
 };
 
 static int __init arm64_ras_init(void)
diff --git a/drivers/ras/arm64/ras.h b/drivers/ras/arm64/ras.h
index b64eae59b6ac..c26a0aae26c5 100644
--- a/drivers/ras/arm64/ras.h
+++ b/drivers/ras/arm64/ras.h
@@ -90,6 +90,7 @@ struct ras_node {
 	void __iomem *base;
 	void __iomem *errgsr;
 	void __iomem *inj;
+	void __iomem *irq_config;
 	phys_addr_t addr;
 
 	u8 *specific_data;
@@ -126,6 +127,7 @@ struct ras_node {
 	u8 access_type;
 	u8 group_format;
 	u32 irq[AEST_MAX_INTERRUPT_PER_NODE];
+	u32 gsi[AEST_MAX_INTERRUPT_PER_NODE];
 };
 
 #define CASE_READ(res, x)                           \
@@ -207,4 +209,34 @@ static const struct ras_access ras_access[] = {
 	},
 };
 
+static inline bool ras_node_is_oncore(struct ras_node *node)
+{
+	/*
+	 * A processor node is "on-core" (uses PPI + cpuhp) only when its
+	 * interrupt is a per-CPU PPI.  A shared processor node (e.g. cluster
+	 * L3 cache, DSU) uses an SPI and must follow the non-oncore path
+	 * (aest_online_dev) so that aest_config_irq and aest_online_dev are
+	 * called instead of cpuhp_setup_state.
+	 */
+	if (node->type != ACPI_AEST_PROCESSOR_ERROR_NODE)
+		return false;
+	return irq_is_percpu(node->irq[ACPI_AEST_NODE_FAULT_HANDLING]) ||
+	       irq_is_percpu(node->irq[ACPI_AEST_NODE_ERROR_RECOVERY]);
+}
+
+static inline void ras_select_record(struct ras_node *node, int index)
+{
+	if (node->type == ACPI_AEST_PROCESSOR_ERROR_NODE) {
+		write_sysreg_s(index, SYS_ERRSELR_EL1);
+		isb();
+	}
+}
+
+/* Ensure all writes has taken effect. */
+static inline void ras_sync(struct ras_node *node)
+{
+	if (node->type == ACPI_AEST_PROCESSOR_ERROR_NODE)
+		isb();
+}
+
 #endif /* _DRIVERS_RAS_ARM64_RAS_H_ */
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index 62cd7b35a29c..ef55c10f6c71 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -179,6 +179,7 @@ enum cpuhp_state {
 	CPUHP_AP_HYPERV_TIMER_STARTING,
 	/* Must be the last timer callback */
 	CPUHP_AP_DUMMY_TIMER_STARTING,
+	CPUHP_AP_ARM_RAS_STARTING,
 	CPUHP_AP_ARM_XEN_STARTING,
 	CPUHP_AP_ARM_XEN_RUNSTATE_STARTING,
 	CPUHP_AP_ARM_CORESIGHT_STARTING,
-- 
2.51.2.612.gdc70283dfc

