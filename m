Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E8F634DB6D;
	Wed,  1 Jul 2026 14:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782916777; cv=none; b=TwStYRzdzUcjd/wPKmdzkBPrzkzTcGkHAg1wpLKje0RaItlPkGtlkIx/DZ00K4Zo7XlRqr2FDNe+CUFVF0odbmY+5lAgLX6FhpZtXnzVyP+iyqS1B0Rj7XoACT//TIyTumJvbMrjUSR7yd7nWQk0VTtF+dIdR3yw7sqNNmOn+1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782916777; c=relaxed/simple;
	bh=dhrl+dqJBuE61pxWAMxJ63hZiz+3t/c6O+D5yjhWPGI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nWtGuTWijeXTcf3OLt7LmXvbdBEGFnTZKNNZi38yneQQM1r85FUl17B7EbbtQ4OVROLmAahHO0kdY7f5ENX8PuOmIMou6gpYizuLV5w2g+t5lF/S4n5u3UsflC4f5tKdSQbEktPvQa4cLg8zECkEGyM+6VQUePkgKwtpdeSX0Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tri4RibR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tri4RibR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 541911F00A3A;
	Wed,  1 Jul 2026 14:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782916776;
	bh=FHnEU2cWOeE/SJ4pLk0OaaCpWkfm5he3fR+uDqxMHpc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Tri4RibRz0rLKkiWQesj5+TrZ6WsxzeDDot/YI3M3DllgoPNtve0GXXGg8PS/m1w7
	 vvBDak1fhDDs/gyPkCZcitAw4CtNzZROVpxo4gx0US9/EL8kho1LPZzfNzpVgxiro0
	 YOTCj8M27QpL12yLzs7FGQ3rDmAF2ya14DxrsurPzXm19c/ALt165N9WPFgNx36aRq
	 IeWFE1IoreijSyodjAM9JUzhIuKRMdn0mgC71Hj2gv6ooW0b2SlHVU306F4Ml+0/Tc
	 8ebETIEjMryVQR2ku0pJpaSh0d3ftfeJJkudzUJCaf/34BfoZLwnwsyT0mrwNQT+8d
	 /JvUfYedZ8CfA==
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
Date: Wed, 01 Jul 2026 16:38:55 +0200
Subject: [PATCH v3 7/7] irqchip/gic-v5: Enable GICv5 IWB ACPI probe
 ordering detection
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260701-gic-v5-acpi-iwb-probe-deferral-v3-7-c5562cf0fe29@kernel.org>
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
 drivers/irqchip/irq-gic-v5-iwb.c |  2 ++
 drivers/irqchip/irq-gic-v5.c     | 11 ++++++++++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v5-iwb.c b/drivers/irqchip/irq-gic-v5-iwb.c
index 9103feb70ce8..2546fc74dd99 100644
--- a/drivers/irqchip/irq-gic-v5-iwb.c
+++ b/drivers/irqchip/irq-gic-v5-iwb.c
@@ -269,6 +269,8 @@ static int gicv5_iwb_device_probe(struct platform_device *pdev)
 	if (IS_ERR(iwb_node))
 		return PTR_ERR(iwb_node);
 
+	acpi_device_clear_dep(&pdev->dev);
+
 	return 0;
 }
 
diff --git a/drivers/irqchip/irq-gic-v5.c b/drivers/irqchip/irq-gic-v5.c
index 7ea39cb19f75..5dcf404ab4c8 100644
--- a/drivers/irqchip/irq-gic-v5.c
+++ b/drivers/irqchip/irq-gic-v5.c
@@ -1231,6 +1231,14 @@ static struct fwnode_handle *gic_v5_get_gsi_domain_id(u32 gsi)
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
@@ -1251,7 +1259,8 @@ static int __init gic_acpi_init(union acpi_subtable_headers *header, const unsig
 	if (ret)
 		goto out_irs;
 
-	acpi_set_irq_model(ACPI_IRQ_MODEL_GIC_V5, gic_v5_get_gsi_domain_id, NULL);
+	acpi_set_irq_model(ACPI_IRQ_MODEL_GIC_V5, gic_v5_get_gsi_domain_id,
+			   gic_v5_get_gsi_handle);
 
 	return 0;
 

-- 
2.34.1

