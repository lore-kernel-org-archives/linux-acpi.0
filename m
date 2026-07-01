Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59BFA3537F6;
	Wed,  1 Jul 2026 14:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782916774; cv=none; b=D0GNai+w7kRqvKmcPYGQ2bu8ifiKN2gkU+toAsDDhy0YCWnHU4OWVSxKgTtoxbmqpgo/2BU6oqK8jUDQN5kDpJifC8PJPQ7XC8OM54ryn2TVO0PncuMTc8zXKXuFZ1ef0yrKGziaWPP83jOlIToqWI9fRvUZBCc8dywBwxiales=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782916774; c=relaxed/simple;
	bh=zK88vSloOQeH6oTdkG5zq85DmnZOojlejI1uRHLC94g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ODd1EZz5q0qxF5P51BgrkJMwxcgbYp2m49y6h5tNl44szmnsVco+SE83Wvvl8SwqQlMZp5rVWV5ubLwJKH39grXcIqQclGvOo5T92lSh1AxZC76+XOR+bAAJrYyrWA95tj3nb1WidQ4pCgX8XzcL0dbbT6vi6hDqzqS4+JW8t2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IoAkyKCC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IoAkyKCC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCAA21F000E9;
	Wed,  1 Jul 2026 14:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782916771;
	bh=gZbe8dDzrobU1GpUf47INZqHOOZGfLshNlOdorjkLhw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=IoAkyKCCq75NvA45Pz7YjQLaCqzpKEPbSpYtW5CYQmgVcx6qDgqAIT8lfKCsScJIr
	 LaohRC+qGbSAZoVo28RXLGJqtv7egjoVQ9iSTBym9oCgGmjS5Ttl5rpqCyUq1YsLck
	 eNrhsS7sQQdTIbH5cjUxTnfs63qApFsJpRiMwF1s03ePCBbkpau7jWHE1VGDhDoMxJ
	 G4u6Im0HoEp6kUuyye+MzMMcxOzOoP921rRRkfY2APvpx2YXeGPWXQNTLLtldZunhT
	 u92OE7zwFC9wNz4BaBtbf49Ru4/L8RBeIiNSOtjARrK5phftKyYL/K/D/eWOkJd1f5
	 jqh9BWiv3yfrg==
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
Date: Wed, 01 Jul 2026 16:38:54 +0200
Subject: [PATCH v3 6/7] ACPI/IORT: Implement ACPI infrastructure to enable
 GICv5 IWB probe deferral
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260701-gic-v5-acpi-iwb-probe-deferral-v3-6-c5562cf0fe29@kernel.org>
References: <20260701-gic-v5-acpi-iwb-probe-deferral-v3-0-c5562cf0fe29@kernel.org>
In-Reply-To: <20260701-gic-v5-acpi-iwb-probe-deferral-v3-0-c5562cf0fe29@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 Sunil V L <sunilvl@ventanamicro.com>, Marc Zyngier <maz@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>, Huacai Chen <chenhuacai@kernel.org>, 
 Anup Patel <anup@brainfault.org>, Hanjun Guo <guohanjun@huawei.com>, 
 Sudeep Holla <sudeep.holla@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 loongarch@lists.linux.dev, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
X-Mailer: b4 0.15.2

Implement an IORT ACPI hook to retrieve the acpi_handle of the interrupt
controller handling a specific GSI (if any, on GICv5 systems only the IWB
is represented in firmware with an ACPI device object) and add the IWB to
the list of devices whose dependencies can be detected (and cleared) in
ACPI core to guarantee that probe dependencies for the IWB can be
satisfied.

Enable autodep detection for arm64 by adding the arch_acpi_add_auto_dep()
callback in the ACPI IORT driver.

Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Acked-by: "Rafael J. Wysocki" (Intel) <rafael@kernel.org> # ACPI: scan.c
Cc: Hanjun Guo <guohanjun@huawei.com>
Cc: Sudeep Holla <sudeep.holla@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
---
 drivers/acpi/arm64/iort.c    | 22 +++++++++++++++++++---
 drivers/acpi/scan.c          |  1 +
 drivers/irqchip/irq-gic-v5.c |  2 +-
 include/linux/acpi_iort.h    |  3 ++-
 4 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index af7a9b2fd5bc..34412cd697d8 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -789,11 +789,9 @@ struct irq_domain *iort_get_device_domain(struct device *dev, u32 id,
 	return irq_find_matching_fwnode(handle, bus_token);
 }
 
-struct fwnode_handle *iort_iwb_handle(u32 iwb_id)
+acpi_handle iort_iwb_handle(u32 iwb_id)
 {
-	struct fwnode_handle *fwnode;
 	struct acpi_iort_node *node;
-	struct acpi_device *device;
 	struct acpi_iort_iwb *iwb;
 	acpi_status status;
 	acpi_handle handle;
@@ -808,6 +806,19 @@ struct fwnode_handle *iort_iwb_handle(u32 iwb_id)
 	if (ACPI_FAILURE(status))
 		return NULL;
 
+	return handle;
+}
+
+struct fwnode_handle *iort_iwb_handle_fwnode(u32 iwb_id)
+{
+	struct fwnode_handle *fwnode;
+	struct acpi_device *device;
+	acpi_handle handle;
+
+	handle = iort_iwb_handle(iwb_id);
+	if (!handle)
+		return NULL;
+
 	device = acpi_get_acpi_dev(handle);
 	if (!device)
 		return NULL;
@@ -2090,6 +2101,11 @@ static void __init iort_init_platform_devices(void)
 	}
 }
 
+u32 arch_acpi_add_auto_dep(acpi_handle handle)
+{
+	return acpi_irq_add_auto_dep(handle);
+}
+
 void __init acpi_iort_init(void)
 {
 	acpi_status status;
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 9a7ac2eb9ce0..25d09474f889 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -854,6 +854,7 @@ static const char * const acpi_ignore_dep_ids[] = {
 
 /* List of HIDs for which we honor deps of matching ACPI devs, when checking _DEP lists. */
 static const char * const acpi_honor_dep_ids[] = {
+	"ARMH0003", /* ARM GICv5 IWB */
 	"INT3472", /* Camera sensor PMIC / clk and regulator info */
 	"INTC1059", /* IVSC (TGL) driver must be loaded to allow i2c access to camera sensors */
 	"INTC1095", /* IVSC (ADL) driver must be loaded to allow i2c access to camera sensors */
diff --git a/drivers/irqchip/irq-gic-v5.c b/drivers/irqchip/irq-gic-v5.c
index b9f648d8e0f0..7ea39cb19f75 100644
--- a/drivers/irqchip/irq-gic-v5.c
+++ b/drivers/irqchip/irq-gic-v5.c
@@ -1226,7 +1226,7 @@ static struct fwnode_handle *gsi_domain_handle;
 static struct fwnode_handle *gic_v5_get_gsi_domain_id(u32 gsi)
 {
 	if (FIELD_GET(GICV5_GSI_IC_TYPE, gsi) == GICV5_GSI_IWB_TYPE)
-		return iort_iwb_handle(FIELD_GET(GICV5_GSI_IWB_FRAME_ID, gsi));
+		return iort_iwb_handle_fwnode(FIELD_GET(GICV5_GSI_IWB_FRAME_ID, gsi));
 
 	return gsi_domain_handle;
 }
diff --git a/include/linux/acpi_iort.h b/include/linux/acpi_iort.h
index 17bb3374f4ca..931eaa7bbf6a 100644
--- a/include/linux/acpi_iort.h
+++ b/include/linux/acpi_iort.h
@@ -27,7 +27,8 @@ int iort_register_domain_token(int trans_id, phys_addr_t base,
 			       struct fwnode_handle *fw_node);
 void iort_deregister_domain_token(int trans_id);
 struct fwnode_handle *iort_find_domain_token(int trans_id);
-struct fwnode_handle *iort_iwb_handle(u32 iwb_id);
+acpi_handle iort_iwb_handle(u32 iwb_id);
+struct fwnode_handle *iort_iwb_handle_fwnode(u32 iwb_id);
 
 #ifdef CONFIG_ACPI_IORT
 u32 iort_msi_map_id(struct device *dev, u32 id);

-- 
2.34.1

