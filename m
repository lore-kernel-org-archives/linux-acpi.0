Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B3130C632;
	Tue,  5 May 2026 08:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777970911; cv=none; b=CQ2n1bQMu9kmn+0axJKYSWG+REdbt2070pBrzYTVTcizjfYhcZDdPdXejH60zgWj+meZXPIqPihJ8SmduDaK25smHpzgWT4fefrxBelEoGNht4q/vKyW08sIqIKiIlIaCfInfC56WXlgzLSB1NIRGaa0nAZJulMSiWB03AJBtPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777970911; c=relaxed/simple;
	bh=lYb15aU1e0WDlM7CvGHdWbcPeIz6jFU6BHSSKvofGbI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ehy9RjNSCSLFlqh6d+sgNwCHoWvRNF/o7DxFtNNXSEWRus6dhgdHhs5Zt4vAUh/MjO27bHyFUo60Y3k25Qi16S6+XbpErW8XwWzu8MPKytypzm/hZRF6NJCAtFJOAuFeCcEHitUD+cXQzI0HB8dg/0CCYd7cYfXJFab8WLwkkOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BiD/fTEJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BiD/fTEJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60D9CC2BCB4;
	Tue,  5 May 2026 08:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777970911;
	bh=lYb15aU1e0WDlM7CvGHdWbcPeIz6jFU6BHSSKvofGbI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=BiD/fTEJRny33il0QI0j4JUXU78uv59uS2arFn85qm/4Mhuk0M9VCOndsdRbcrMaq
	 1/FVqt93K8xwveKQcTusvJkcIQqN7APr0UcWBtrZXf+pF4wgNvEvktcPLX1eLeDWcR
	 DM2qDLpGHjQt79D4GjXn4U1v95XgKCdYzig9r1zezaUAa5TRgKDG16PMQETbRFsJjD
	 cQ8zaPQ89oCbAmHdwjA6ycG3bRJrtBEimbbtoY1+22jxac40XfG1HUGiyUKxPT1r8s
	 4BKLKZUsNeP9WwPOJkFpB5pIPhAVZfyAGNP84pzy/pa4bI9EMHkNa/xQIJK1PF/w01
	 KuDi9nVLGp3KQ==
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
Date: Tue, 05 May 2026 10:48:03 +0200
Subject: [PATCH 1/2] drivers/acpi: Move RISC-V interrupt controllers
 autodep to ACPI IRQ code
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260505-gic-v5-acpi-iwb-probe-deferral-v1-1-b37b85998362@kernel.org>
References: <20260505-gic-v5-acpi-iwb-probe-deferral-v1-0-b37b85998362@kernel.org>
In-Reply-To: <20260505-gic-v5-acpi-iwb-probe-deferral-v1-0-b37b85998362@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 Sunil V L <sunilvl@ventanamicro.com>, Marc Zyngier <maz@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>, Huacai Chen <chenhuacai@kernel.org>, 
 Anup Patel <anup@brainfault.org>, Hanjun Guo <guohanjun@huawei.com>, 
 Sudeep Holla <sudeep.holla@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 loongarch@lists.linux.dev, Lorenzo Pieralisi <lpieralisi@kernel.org>
X-Mailer: b4 0.15.2

RISC-V implements arch code to detect probe dependencies for devices and
the interrupt controller the devices GSIs are routed to.

The code itself is arch agnostic apart from an arch specific helper
function required to retrieve the acpi_handle of the interrupt controller
that manages the device GSI interrupt.

In order to enable IRQ probe dependencies detection on other
architectures, move RISC-V IRQ probe dependency detection code to
generic ACPI IRQ code.

RISC-V IRQ code detecting IRQ probe dependency has some limitations/latent
bugs:

- riscv_acpi_irq_get_dep() would force the loop in
  riscv_acpi_add_irq_dep() to stop at the first IRQ index that does not
  map to an interrupt controller handle (missing some possible
  dependencies)
- riscv_acpi_add_prt_dep() does not validate acpi_get_handle() output
- riscv_acpi_add_prt_dep() logic to handle memory allocation failure is
  forcing the loop to continue on the same PRT entry

Fix the above limitations along with the code move.

Allow interrupt controller drivers to register an arch specific
function to determine the acpi_handle for a specific GSI number to use
the mechanism if needed by the respective interrupt controller drivers.

Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Huacai Chen <chenhuacai@kernel.org>
Cc: Thomas Gleixner <tglx@kernel.org>
Cc: Anup Patel <anup@brainfault.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Sunil V L <sunilvl@ventanamicro.com>
Cc: Marc Zyngier <maz@kernel.org>
---
 arch/riscv/include/asm/acpi.h       |   1 +
 drivers/acpi/irq.c                  | 172 +++++++++++++++++++++++++++++++++++-
 drivers/acpi/riscv/irq.c            | 141 +----------------------------
 drivers/irqchip/irq-gic-v3.c        |   2 +-
 drivers/irqchip/irq-gic-v5.c        |   2 +-
 drivers/irqchip/irq-gic.c           |   2 +-
 drivers/irqchip/irq-loongarch-cpu.c |   2 +-
 drivers/irqchip/irq-riscv-intc.c    |   3 +-
 include/linux/acpi.h                |   5 +-
 9 files changed, 181 insertions(+), 149 deletions(-)

diff --git a/arch/riscv/include/asm/acpi.h b/arch/riscv/include/asm/acpi.h
index 26ab37c171bc..f598520ac903 100644
--- a/arch/riscv/include/asm/acpi.h
+++ b/arch/riscv/include/asm/acpi.h
@@ -67,6 +67,7 @@ int acpi_get_riscv_isa(struct acpi_table_header *table,
 
 void acpi_get_cbo_block_size(struct acpi_table_header *table, u32 *cbom_size,
 			     u32 *cboz_size, u32 *cbop_size);
+acpi_handle acpi_get_riscv_gsi_handle(u32 gsi);
 #else
 static inline void acpi_init_rintc_map(void) { }
 static inline struct acpi_madt_rintc *acpi_cpu_get_madt_rintc(int cpu)
diff --git a/drivers/acpi/irq.c b/drivers/acpi/irq.c
index d1595156c86a..e4293458bf61 100644
--- a/drivers/acpi/irq.c
+++ b/drivers/acpi/irq.c
@@ -13,6 +13,7 @@
 enum acpi_irq_model_id acpi_irq_model;
 
 static acpi_gsi_domain_disp_fn acpi_get_gsi_domain_id;
+static acpi_gsi_handle_disp_fn acpi_get_gsi_handle;
 static u32 (*acpi_gsi_to_irq_fallback)(u32 gsi);
 
 /**
@@ -321,15 +322,19 @@ const struct cpumask *acpi_irq_get_affinity(acpi_handle handle,
 
 /**
  * acpi_set_irq_model - Setup the GSI irqdomain information
- * @model: the value assigned to acpi_irq_model
- * @fn: a dispatcher function that will return the domain fwnode
- *	for a given GSI
+ * @model:	the value assigned to acpi_irq_model
+ * @fn:		a dispatcher function that will return the domain fwnode
+ *		for a given GSI
+ * @gsi_dep_fn: a function to retrieve the acpi_handle a GSI interrupt is
+ *		dependent on
+ *
  */
 void __init acpi_set_irq_model(enum acpi_irq_model_id model,
-			       acpi_gsi_domain_disp_fn fn)
+			       acpi_gsi_domain_disp_fn fn, acpi_gsi_handle_disp_fn gsi_dep_fn)
 {
 	acpi_irq_model = model;
 	acpi_get_gsi_domain_id = fn;
+	acpi_get_gsi_handle = gsi_dep_fn;
 }
 
 /*
@@ -385,3 +390,162 @@ struct irq_domain *acpi_irq_create_hierarchy(unsigned int flags,
 					   host_data);
 }
 EXPORT_SYMBOL_GPL(acpi_irq_create_hierarchy);
+
+struct acpi_irq_dep_ctx {
+	int		rc;
+	unsigned int	index;
+	acpi_handle	handle;
+};
+
+static acpi_status acpi_irq_get_parent(struct acpi_resource *ares, void *context)
+{
+	struct acpi_irq_dep_ctx *ctx = context;
+	struct acpi_resource_irq *irq;
+	struct acpi_resource_extended_irq *eirq;
+
+	switch (ares->type) {
+	case ACPI_RESOURCE_TYPE_IRQ:
+		irq = &ares->data.irq;
+		if (ctx->index >= irq->interrupt_count) {
+			ctx->index -= irq->interrupt_count;
+			return AE_OK;
+		}
+		ctx->handle = acpi_get_gsi_handle(irq->interrupts[ctx->index]);
+		ctx->rc = 0;
+		return AE_CTRL_TERMINATE;
+	case ACPI_RESOURCE_TYPE_EXTENDED_IRQ:
+		eirq = &ares->data.extended_irq;
+		if (eirq->producer_consumer == ACPI_PRODUCER)
+			return AE_OK;
+
+		if (ctx->index >= eirq->interrupt_count) {
+			ctx->index -= eirq->interrupt_count;
+			return AE_OK;
+		}
+
+		/* Support GSIs only */
+		if (eirq->resource_source.string_length)
+			return AE_OK;
+
+		ctx->handle = acpi_get_gsi_handle(eirq->interrupts[ctx->index]);
+		ctx->rc = 0;
+		return AE_CTRL_TERMINATE;
+	}
+
+	return AE_OK;
+}
+
+static int acpi_irq_get_dep(acpi_handle handle, unsigned int index, acpi_handle *gsi_handle)
+{
+	struct acpi_irq_dep_ctx ctx = {-EINVAL, index, NULL};
+
+	if (!gsi_handle)
+		return -EINVAL;
+
+	acpi_walk_resources(handle, METHOD_NAME__CRS, acpi_irq_get_parent, &ctx);
+	*gsi_handle = ctx.handle;
+
+	return ctx.rc;
+}
+
+static bool acpi_prt_entry_valid(void *prt_entry)
+{
+	struct acpi_pci_routing_table *entry = prt_entry;
+
+	return entry && entry->length > 0;
+}
+
+static void *acpi_prt_next_entry(void *prt_entry)
+{
+	struct acpi_pci_routing_table *entry = prt_entry;
+
+	return prt_entry + entry->length;
+}
+
+static u32 acpi_add_prt_dep(acpi_handle handle)
+{
+	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
+	struct acpi_pci_routing_table *entry;
+	struct acpi_handle_list dep_devices;
+	acpi_handle gsi_handle;
+	acpi_handle link_handle;
+	acpi_status status;
+	u32 count = 0;
+
+	status = acpi_get_irq_routing_table(handle, &buffer);
+	if (ACPI_FAILURE(status)) {
+		acpi_handle_err(handle, "failed to get IRQ routing table\n");
+		kfree(buffer.pointer);
+		return 0;
+	}
+
+	entry = buffer.pointer;
+	for (; acpi_prt_entry_valid(entry); entry = acpi_prt_next_entry(entry)) {
+		if (entry->source[0]) {
+			status = acpi_get_handle(handle, entry->source, &link_handle);
+			if (ACPI_FAILURE(status))
+				continue;
+			dep_devices.count = 1;
+			dep_devices.handles = kcalloc(1, sizeof(*dep_devices.handles), GFP_KERNEL);
+			if (!dep_devices.handles) {
+				acpi_handle_err(handle, "failed to allocate memory\n");
+				continue;
+			}
+
+			dep_devices.handles[0] = link_handle;
+			count += acpi_scan_add_dep(handle, &dep_devices);
+		} else {
+			gsi_handle = acpi_get_gsi_handle(entry->source_index);
+			if (!gsi_handle)
+				continue;
+			dep_devices.count = 1;
+			dep_devices.handles = kcalloc(1, sizeof(*dep_devices.handles), GFP_KERNEL);
+			if (!dep_devices.handles) {
+				acpi_handle_err(handle, "failed to allocate memory\n");
+				continue;
+			}
+
+			dep_devices.handles[0] = gsi_handle;
+			count += acpi_scan_add_dep(handle, &dep_devices);
+		}
+	}
+
+	kfree(buffer.pointer);
+	return count;
+}
+
+static u32 acpi_add_irq_dep(acpi_handle handle)
+{
+	struct acpi_handle_list dep_devices;
+	acpi_handle gsi_handle;
+	u32 count = 0;
+	int i;
+
+	for (i = 0; !acpi_irq_get_dep(handle, i, &gsi_handle); i++) {
+		if (!gsi_handle)
+			continue;
+
+		dep_devices.count = 1;
+		dep_devices.handles = kcalloc(1, sizeof(*dep_devices.handles), GFP_KERNEL);
+		if (!dep_devices.handles) {
+			acpi_handle_err(handle, "failed to allocate memory\n");
+			continue;
+		}
+
+		dep_devices.handles[0] = gsi_handle;
+		count += acpi_scan_add_dep(handle, &dep_devices);
+	}
+
+	return count;
+}
+
+u32 acpi_irq_add_auto_dep(acpi_handle handle)
+{
+	if (!acpi_get_gsi_handle)
+		return 0;
+
+	if (acpi_has_method(handle, "_PRT"))
+		return acpi_add_prt_dep(handle);
+
+	return acpi_add_irq_dep(handle);
+}
diff --git a/drivers/acpi/riscv/irq.c b/drivers/acpi/riscv/irq.c
index 9b88d0993e88..da2c42e0ebfd 100644
--- a/drivers/acpi/riscv/irq.c
+++ b/drivers/acpi/riscv/irq.c
@@ -23,12 +23,6 @@ struct riscv_ext_intc_list {
 	struct list_head	list;
 };
 
-struct acpi_irq_dep_ctx {
-	int		rc;
-	unsigned int	index;
-	acpi_handle	handle;
-};
-
 LIST_HEAD(ext_intc_list);
 
 static int irqchip_cmp_func(const void *in0, const void *in1)
@@ -254,7 +248,7 @@ void __init riscv_acpi_init_gsi_mapping(void)
 	acpi_get_devices("RSCV0006", riscv_acpi_create_gsi_map_smsi, NULL, NULL);
 }
 
-static acpi_handle riscv_acpi_get_gsi_handle(u32 gsi)
+acpi_handle acpi_get_riscv_gsi_handle(u32 gsi)
 {
 	struct riscv_ext_intc_list *ext_intc_element;
 	struct list_head *i;
@@ -269,138 +263,7 @@ static acpi_handle riscv_acpi_get_gsi_handle(u32 gsi)
 	return NULL;
 }
 
-static acpi_status riscv_acpi_irq_get_parent(struct acpi_resource *ares, void *context)
-{
-	struct acpi_irq_dep_ctx *ctx = context;
-	struct acpi_resource_irq *irq;
-	struct acpi_resource_extended_irq *eirq;
-
-	switch (ares->type) {
-	case ACPI_RESOURCE_TYPE_IRQ:
-		irq = &ares->data.irq;
-		if (ctx->index >= irq->interrupt_count) {
-			ctx->index -= irq->interrupt_count;
-			return AE_OK;
-		}
-		ctx->handle = riscv_acpi_get_gsi_handle(irq->interrupts[ctx->index]);
-		return AE_CTRL_TERMINATE;
-	case ACPI_RESOURCE_TYPE_EXTENDED_IRQ:
-		eirq = &ares->data.extended_irq;
-		if (eirq->producer_consumer == ACPI_PRODUCER)
-			return AE_OK;
-
-		if (ctx->index >= eirq->interrupt_count) {
-			ctx->index -= eirq->interrupt_count;
-			return AE_OK;
-		}
-
-		/* Support GSIs only */
-		if (eirq->resource_source.string_length)
-			return AE_OK;
-
-		ctx->handle = riscv_acpi_get_gsi_handle(eirq->interrupts[ctx->index]);
-		return AE_CTRL_TERMINATE;
-	}
-
-	return AE_OK;
-}
-
-static int riscv_acpi_irq_get_dep(acpi_handle handle, unsigned int index, acpi_handle *gsi_handle)
-{
-	struct acpi_irq_dep_ctx ctx = {-EINVAL, index, NULL};
-
-	if (!gsi_handle)
-		return 0;
-
-	acpi_walk_resources(handle, METHOD_NAME__CRS, riscv_acpi_irq_get_parent, &ctx);
-	*gsi_handle = ctx.handle;
-	if (*gsi_handle)
-		return 1;
-
-	return 0;
-}
-
-static u32 riscv_acpi_add_prt_dep(acpi_handle handle)
-{
-	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
-	struct acpi_pci_routing_table *entry;
-	struct acpi_handle_list dep_devices;
-	acpi_handle gsi_handle;
-	acpi_handle link_handle;
-	acpi_status status;
-	u32 count = 0;
-
-	status = acpi_get_irq_routing_table(handle, &buffer);
-	if (ACPI_FAILURE(status)) {
-		acpi_handle_err(handle, "failed to get IRQ routing table\n");
-		kfree(buffer.pointer);
-		return 0;
-	}
-
-	entry = buffer.pointer;
-	while (entry && (entry->length > 0)) {
-		if (entry->source[0]) {
-			acpi_get_handle(handle, entry->source, &link_handle);
-			dep_devices.count = 1;
-			dep_devices.handles = kzalloc_objs(*dep_devices.handles,
-							   1);
-			if (!dep_devices.handles) {
-				acpi_handle_err(handle, "failed to allocate memory\n");
-				continue;
-			}
-
-			dep_devices.handles[0] = link_handle;
-			count += acpi_scan_add_dep(handle, &dep_devices);
-		} else {
-			gsi_handle = riscv_acpi_get_gsi_handle(entry->source_index);
-			dep_devices.count = 1;
-			dep_devices.handles = kzalloc_objs(*dep_devices.handles,
-							   1);
-			if (!dep_devices.handles) {
-				acpi_handle_err(handle, "failed to allocate memory\n");
-				continue;
-			}
-
-			dep_devices.handles[0] = gsi_handle;
-			count += acpi_scan_add_dep(handle, &dep_devices);
-		}
-
-		entry = (struct acpi_pci_routing_table *)
-			((unsigned long)entry + entry->length);
-	}
-
-	kfree(buffer.pointer);
-	return count;
-}
-
-static u32 riscv_acpi_add_irq_dep(acpi_handle handle)
-{
-	struct acpi_handle_list dep_devices;
-	acpi_handle gsi_handle;
-	u32 count = 0;
-	int i;
-
-	for (i = 0;
-	     riscv_acpi_irq_get_dep(handle, i, &gsi_handle);
-	     i++) {
-		dep_devices.count = 1;
-		dep_devices.handles = kzalloc_objs(*dep_devices.handles, 1);
-		if (!dep_devices.handles) {
-			acpi_handle_err(handle, "failed to allocate memory\n");
-			continue;
-		}
-
-		dep_devices.handles[0] = gsi_handle;
-		count += acpi_scan_add_dep(handle, &dep_devices);
-	}
-
-	return count;
-}
-
 u32 arch_acpi_add_auto_dep(acpi_handle handle)
 {
-	if (acpi_has_method(handle, "_PRT"))
-		return riscv_acpi_add_prt_dep(handle);
-
-	return riscv_acpi_add_irq_dep(handle);
+	return acpi_irq_add_auto_dep(handle);
 }
diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 99444a1b2ffa..2673954d4577 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -2588,7 +2588,7 @@ gic_acpi_init(union acpi_subtable_headers *header, const unsigned long end)
 	if (err)
 		goto out_fwhandle_free;
 
-	acpi_set_irq_model(ACPI_IRQ_MODEL_GIC, gic_v3_get_gsi_domain_id);
+	acpi_set_irq_model(ACPI_IRQ_MODEL_GIC, gic_v3_get_gsi_domain_id, NULL);
 
 	if (static_branch_likely(&supports_deactivate_key))
 		gic_acpi_setup_kvm_info();
diff --git a/drivers/irqchip/irq-gic-v5.c b/drivers/irqchip/irq-gic-v5.c
index 6b0903be8ebf..03cc2830b260 100644
--- a/drivers/irqchip/irq-gic-v5.c
+++ b/drivers/irqchip/irq-gic-v5.c
@@ -1242,7 +1242,7 @@ static int __init gic_acpi_init(union acpi_subtable_headers *header, const unsig
 	if (ret)
 		goto out_irs;
 
-	acpi_set_irq_model(ACPI_IRQ_MODEL_GIC_V5, gic_v5_get_gsi_domain_id);
+	acpi_set_irq_model(ACPI_IRQ_MODEL_GIC_V5, gic_v5_get_gsi_domain_id, NULL);
 
 	return 0;
 
diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index ec70c84e9f91..f6bc29f515fb 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -1690,7 +1690,7 @@ static int __init gic_v2_acpi_init(union acpi_subtable_headers *header,
 		return ret;
 	}
 
-	acpi_set_irq_model(ACPI_IRQ_MODEL_GIC, gic_v2_get_gsi_domain_id);
+	acpi_set_irq_model(ACPI_IRQ_MODEL_GIC, gic_v2_get_gsi_domain_id, NULL);
 
 	if (IS_ENABLED(CONFIG_ARM_GIC_V2M))
 		gicv2m_init(NULL, gic_data[0].domain);
diff --git a/drivers/irqchip/irq-loongarch-cpu.c b/drivers/irqchip/irq-loongarch-cpu.c
index 950bc087e388..84ce24889488 100644
--- a/drivers/irqchip/irq-loongarch-cpu.c
+++ b/drivers/irqchip/irq-loongarch-cpu.c
@@ -168,7 +168,7 @@ static int __init cpuintc_acpi_init(union acpi_subtable_headers *header,
 		panic("Failed to add irqdomain for LoongArch CPU");
 
 	set_handle_irq(&handle_cpu_irq);
-	acpi_set_irq_model(ACPI_IRQ_MODEL_LPIC, lpic_get_gsi_domain_id);
+	acpi_set_irq_model(ACPI_IRQ_MODEL_LPIC, lpic_get_gsi_domain_id, NULL);
 	acpi_set_gsi_to_irq_fallback(lpic_gsi_to_irq);
 	ret = acpi_cascade_irqdomain_init();
 
diff --git a/drivers/irqchip/irq-riscv-intc.c b/drivers/irqchip/irq-riscv-intc.c
index 84418dbd5a27..0595144116e2 100644
--- a/drivers/irqchip/irq-riscv-intc.c
+++ b/drivers/irqchip/irq-riscv-intc.c
@@ -384,7 +384,8 @@ static int __init riscv_intc_acpi_init(union acpi_subtable_headers *header,
 	if (rc)
 		irq_domain_free_fwnode(fn);
 	else
-		acpi_set_irq_model(ACPI_IRQ_MODEL_RINTC, riscv_acpi_get_gsi_domain_id);
+		acpi_set_irq_model(ACPI_IRQ_MODEL_RINTC, riscv_acpi_get_gsi_domain_id,
+				   acpi_get_riscv_gsi_handle);
 
 	return rc;
 }
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 67effb91fa98..468fc6a54651 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -360,9 +360,10 @@ int acpi_gsi_to_irq (u32 gsi, unsigned int *irq);
 int acpi_isa_irq_to_gsi (unsigned isa_irq, u32 *gsi);
 
 typedef struct fwnode_handle *(*acpi_gsi_domain_disp_fn)(u32);
+typedef acpi_handle (*acpi_gsi_handle_disp_fn)(u32);
 
 void acpi_set_irq_model(enum acpi_irq_model_id model,
-			acpi_gsi_domain_disp_fn fn);
+			acpi_gsi_domain_disp_fn fn, acpi_gsi_handle_disp_fn gsi_dep_fn);
 acpi_gsi_domain_disp_fn acpi_get_gsi_dispatcher(void);
 void acpi_set_gsi_to_irq_fallback(u32 (*)(u32));
 
@@ -372,6 +373,8 @@ struct irq_domain *acpi_irq_create_hierarchy(unsigned int flags,
 					     const struct irq_domain_ops *ops,
 					     void *host_data);
 
+u32 acpi_irq_add_auto_dep(acpi_handle handle);
+
 #ifdef CONFIG_X86_IO_APIC
 extern int acpi_get_override_irq(u32 gsi, int *trigger, int *polarity);
 #else

-- 
2.54.0

