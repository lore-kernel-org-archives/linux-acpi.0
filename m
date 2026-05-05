Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB42D38C427;
	Tue,  5 May 2026 08:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777970915; cv=none; b=eJ+zoh5Lyk5ETf/c53fqgvF76+Z7w637LKF3c3psU6dj78nWrb0uzWLkNAJglM2dR4mSf1Oppd/S9UL9C9rkut/4FuYdSqadsLOcmixe8p8aCwqXXyaB4XgJjapJyG5ciGgYw0K+AikkLFhc1TaYQMqE3luvIRguDwYYhhvq0ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777970915; c=relaxed/simple;
	bh=VoLG4om3LpMu6n/Rm19I44/U7HtIxq4nWFHci0mVcJQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M1aiZNfOAmXOwGwlkRnqW70audTLv1w6EKwJtudhKEKj5XMM4v9H5dD2B/WErRsI4SA+cLfIRz3FQ4LGItdBKP2RTnUR4aD8CRVDPd3Gg0q82MVLsLK0zf8T63jJki04wVVhm00r5CSL4G2gQdF73XCLyPld3OWsRjfaX7pdaIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OlAvh5mx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OlAvh5mx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C344FC2BCB4;
	Tue,  5 May 2026 08:48:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777970915;
	bh=VoLG4om3LpMu6n/Rm19I44/U7HtIxq4nWFHci0mVcJQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=OlAvh5mxETVWeOeQOP0cx2TPuQdar1Qo63oUGsyjgHBoL8WbHY9STto/vJjpy/WCm
	 MJ6hVp22pb6rw8eQMJdkyVvaLjSb77BnI2zyIYpKhAFjR66FvOTu6r+2etEWAlvHna
	 uFzHV6JVPdqW4vngVY8VZcih5KwShRRN87GSKxW/LqkYXkrKBh6K+eqNh/YnREUIWT
	 57s88b8/yrGPTgoRkp6pAAmPAcMy7/pgpadPwCKn25i4b3T2EB/m1RcUY4o5kI91h8
	 jdY9ReXyeitMWjG21T3Dz5By7JyUgK2wPIaTK7ReASdZGf3H3Y3BI6044rhduJ0m4j
	 Q1xl4tcE8RfLw==
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
Date: Tue, 05 May 2026 10:48:04 +0200
Subject: [PATCH 2/2] irqchip/gic-v5: Add IWB to ACPI probe dependency
 control
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260505-gic-v5-acpi-iwb-probe-deferral-v1-2-b37b85998362@kernel.org>
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

On Arm GICv5 systems, wired IRQs routed to an IWB may require resolving
probe dependencies to make sure drivers for devices whose IRQs are routed
to an IWB are probed after the IWB interrupt controller driver for the IWB
they are routed to has probed.

Implement an ACPI hook to retrieve an acpi_handle for a specific GSI (if
any, on GICv5 systems only the IWB is represented in firmware with an
ACPI device object), hook it into ACPI IRQ core (updating
acpi_set_irq_model()) and add the IWB to the list of devices whose
dependencies can be detected (and cleared) in ACPI core to guarantee that
probe dependencies for the IWB are satisfied.

Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Thomas Gleixner <tglx@kernel.org>
Cc: Hanjun Guo <guohanjun@huawei.com>
Cc: Sudeep Holla <sudeep.holla@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>
---
 drivers/acpi/arm64/iort.c        | 22 +++++++++++++++++++---
 drivers/acpi/scan.c              |  1 +
 drivers/irqchip/irq-gic-v5-iwb.c |  5 +++++
 drivers/irqchip/irq-gic-v5.c     | 13 +++++++++++--
 include/linux/acpi_iort.h        |  3 ++-
 5 files changed, 38 insertions(+), 6 deletions(-)

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
index 530547cda8b2..ba15da9058dc 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -856,6 +856,7 @@ static const char * const acpi_ignore_dep_ids[] = {
 
 /* List of HIDs for which we honor deps of matching ACPI devs, when checking _DEP lists. */
 static const char * const acpi_honor_dep_ids[] = {
+	"ARMH0003", /* ARM GICv5 IWB */
 	"INT3472", /* Camera sensor PMIC / clk and regulator info */
 	"INTC1059", /* IVSC (TGL) driver must be loaded to allow i2c access to camera sensors */
 	"INTC1095", /* IVSC (ADL) driver must be loaded to allow i2c access to camera sensors */
diff --git a/drivers/irqchip/irq-gic-v5-iwb.c b/drivers/irqchip/irq-gic-v5-iwb.c
index 9103feb70ce8..a02cb9537b15 100644
--- a/drivers/irqchip/irq-gic-v5-iwb.c
+++ b/drivers/irqchip/irq-gic-v5-iwb.c
@@ -269,6 +269,11 @@ static int gicv5_iwb_device_probe(struct platform_device *pdev)
 	if (IS_ERR(iwb_node))
 		return PTR_ERR(iwb_node);
 
+#ifdef CONFIG_ACPI
+	if (has_acpi_companion(&pdev->dev))
+		acpi_dev_clear_dependencies(ACPI_COMPANION(&pdev->dev));
+#endif
+
 	return 0;
 }
 
diff --git a/drivers/irqchip/irq-gic-v5.c b/drivers/irqchip/irq-gic-v5.c
index 03cc2830b260..26cfaea1af41 100644
--- a/drivers/irqchip/irq-gic-v5.c
+++ b/drivers/irqchip/irq-gic-v5.c
@@ -1217,11 +1217,19 @@ static struct fwnode_handle *gsi_domain_handle;
 static struct fwnode_handle *gic_v5_get_gsi_domain_id(u32 gsi)
 {
 	if (FIELD_GET(GICV5_GSI_IC_TYPE, gsi) == GICV5_GSI_IWB_TYPE)
-		return iort_iwb_handle(FIELD_GET(GICV5_GSI_IWB_FRAME_ID, gsi));
+		return iort_iwb_handle_fwnode(FIELD_GET(GICV5_GSI_IWB_FRAME_ID, gsi));
 
 	return gsi_domain_handle;
 }
 
+static acpi_handle gic_v5_get_gsi_handle(u32 gsi)
+{
+	if (FIELD_GET(GICV5_GSI_IC_TYPE, gsi) == GICV5_GSI_IWB_TYPE)
+		return iort_iwb_handle(FIELD_GET(GICV5_GSI_IWB_FRAME_ID, gsi));
+
+	return NULL;
+}
+
 static int __init gic_acpi_init(union acpi_subtable_headers *header, const unsigned long end)
 {
 	struct acpi_madt_gicv5_irs *irs = (struct acpi_madt_gicv5_irs *)header;
@@ -1242,7 +1250,8 @@ static int __init gic_acpi_init(union acpi_subtable_headers *header, const unsig
 	if (ret)
 		goto out_irs;
 
-	acpi_set_irq_model(ACPI_IRQ_MODEL_GIC_V5, gic_v5_get_gsi_domain_id, NULL);
+	acpi_set_irq_model(ACPI_IRQ_MODEL_GIC_V5, gic_v5_get_gsi_domain_id,
+			   gic_v5_get_gsi_handle);
 
 	return 0;
 
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
2.54.0

