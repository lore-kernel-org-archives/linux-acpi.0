Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 678B1421EE8;
	Wed,  3 Jun 2026 08:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780474914; cv=none; b=a3+ViAjs2fQ1bS5ThbwEbmm2REqWRox2UVD5bR9HinUZarEEF6/U0KcmxZRF78yY6rPG0Oj1/k3FNPg5VW8davEeYZkHriNNyKUVzCQ2pnsuNW/jVtK1DQ3aathPQ5TPZ9UZ5KA094c5VHV8J98H2OHGRQV9W846noV3/zHr4Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780474914; c=relaxed/simple;
	bh=b+ZGB8vRP3G0qYMMdpOjw19Lv1GxCd0pMHceXbBcwq0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f5GYbfjusQQRe5InwRvQ7/K/EiN3S6V7K2hGw7lRXM8SRkp8ei16sfj5YUomQs/WwsEQyRxz5zRbQHJM2IudB5upRz/H0NuwxlRNk2FeQ/qvXhKRI/UIaeZWKvUkVL5RcpDLW7QebQVTlnVl8UW3WLRK0lD7MQEvaYeyyhUmWzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ABBhZrjq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ABBhZrjq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46AE91F00893;
	Wed,  3 Jun 2026 08:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780474913;
	bh=ZXGjepFLBlF5CYmJKu9nzonog+TjUvQLSqr6dGfFK2E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=ABBhZrjqOU3o537lh2MnRYUpYMrAMI0ROn0RsyvtsI8PXipIkR061ks9udXEF2C0h
	 If3i0UetpaEvv3OrWUZmz4KSy5bQw4ttj0XV5p8H3AqqM7/KgXEDY/YmOhiUrI0GAG
	 FN2f8lQQNU9nuQTNyBN9u8N2HfgXpZt7imZnGJlYPEtqXYUr5W7wh+S2eDopa987I1
	 3kIHecyEJsrk3xPW9OyOuJhGNieglEb8tZX+2QzifZQckprT5MvOTYLMMSHNJ5HZY2
	 EF0ucrZb2UKmy77Rp6L4/gRBiE0L2kZZYsmUHc16Urh7rw7/dKM50uBu4pQ+7nM77Y
	 aucxO+nLtV0rQ==
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
Date: Wed, 03 Jun 2026 10:21:01 +0200
Subject: [PATCH v2 5/6] ACPI/IORT: Implement ACPI infrastructure to enable
 GICv5 IWB probe deferral
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260603-gic-v5-acpi-iwb-probe-deferral-v2-5-23ffa16b6ebb@kernel.org>
References: <20260603-gic-v5-acpi-iwb-probe-deferral-v2-0-23ffa16b6ebb@kernel.org>
In-Reply-To: <20260603-gic-v5-acpi-iwb-probe-deferral-v2-0-23ffa16b6ebb@kernel.org>
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

Implement an IORT ACPI hook to retrieve the acpi_handle of the interrupt
controller handling a specific GSI (if any, on GICv5 systems only the IWB
is represented in firmware with an ACPI device object) and add the IWB to
the list of devices whose dependencies can be detected (and cleared) in
ACPI core to guarantee that probe dependencies for the IWB can be
satisfied.

Enable autodep detection for arm64 by adding the arch_acpi_add_auto_dep()
callback in the ACPI IORT driver.

Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Hanjun Guo <guohanjun@huawei.com>
Cc: Sudeep Holla <sudeep.holla@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
---
 drivers/acpi/arm64/iort.c | 22 +++++++++++++++++++---
 drivers/acpi/scan.c       |  1 +
 include/linux/acpi_iort.h |  3 ++-
 3 files changed, 22 insertions(+), 4 deletions(-)

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

