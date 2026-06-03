Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66464219F6;
	Wed,  3 Jun 2026 08:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780474918; cv=none; b=pB3nOgMW4gJeYPldLSY1UqM7QJX1rKvbQnl3HsChZHtMXiBePDb5vr0OTwbUqbGN63VU/PCKA+Wp0cuVCYTM6iCPYngeW+Q/8cjuHOlqbKvesy1ToYZ8tmw0Mr6kSIY55gxt1poVTlJe6MMnpKF/koYasdk2jVfasdK0zxzyJ/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780474918; c=relaxed/simple;
	bh=4+5N4uxvLWBFk2eIXBRg1DHQVb0VGvLDEOpHtIMC4/M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ODhW9UqjeywhubHDgrq71acMoG5rvMEWuXIRl0nc8fjIgXeFYafcuyZCWQKUl1vpC8luAiXBrGWwDVIvSRBnnpDhcn/upD1mh8yZmlEI4GCplfzeIf8VlqSRvh4OG/VIacdiMDGqek+0vnkRu9JGjSWTa3bof84FZaK35vkUnQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gm3Yv3Za; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gm3Yv3Za"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98C5A1F00899;
	Wed,  3 Jun 2026 08:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780474917;
	bh=m+5k6g5V08oIf0zyIc0HtMgKRyoeGZij4UaZCAbhjl4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=gm3Yv3ZaferZ76474cGhOraU0cQUJRTFq09a7OoW6Gnr0QvP0dbYge9HrxDMwy0rU
	 Vsq3FQq7GzRlxIryPMbchjYGIFZVJGbh5zyv5uqQiFcVY2oZ7k1UJABr6LK2RzMS3u
	 n0erUHnhlqTg0SAYlGwh5uaMO9W+LaFvVakEYwoSolQDR4pZLfVX7+TIDB2eI575lK
	 QJJ6XxodqXXEKPYYrZ/tjrffvZoZZcJCfBCT82eHtakWjrkfXKMNpxo0bRY3RhRXFP
	 ADo2IgymnLL2GlTzDAjtinN5uN8tvDiLppx9P7Iu0N7HTgUPdbT2c84Cw5wyIx71/c
	 fr1kKInZ6bjSA==
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
Date: Wed, 03 Jun 2026 10:21:02 +0200
Subject: [PATCH v2 6/6] irqchip/gic-v5: Enable GICv5 IWB ACPI probe
 ordering detection
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260603-gic-v5-acpi-iwb-probe-deferral-v2-6-23ffa16b6ebb@kernel.org>
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

Register an ACPI hook in the ACPI interrupt management code for GICv5 to
retrieve the ACPI interrupt controller handle (if any) of the controller
handling a specific GSI, by updating the acpi_set_irq_model() call with
the gic_v5_get_gsi_handle() function pointer parameter.

gicv5_get_gsi_handle() allows ACPI core to detect the ACPI handle
of the controller that manages a specific GSI interrupt.

Update the IWB driver to clear device dependencies in ACPI core once the
IWB driver has probed.

Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Thomas Gleixner <tglx@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-gic-v5-iwb.c |  5 +++++
 drivers/irqchip/irq-gic-v5.c     | 13 +++++++++++--
 2 files changed, 16 insertions(+), 2 deletions(-)

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
 

-- 
2.54.0

