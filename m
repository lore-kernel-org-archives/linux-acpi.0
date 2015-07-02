From: Al Stone <al.stone@linaro.org>
Subject: [PATCH v3 3/3] ACPI / ARM64 : use the new BAD_MADT_GICC_ENTRY macro
Date: Thu,  2 Jul 2015 17:48:36 -0600
Message-ID: <1435880916-2153-4-git-send-email-al.stone@linaro.org>
References: <1435880916-2153-1-git-send-email-al.stone@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ie0-f175.google.com ([209.85.223.175]:33778 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754260AbbGBXsy (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 2 Jul 2015 19:48:54 -0400
Received: by ieqy10 with SMTP id y10so67376722ieq.0
        for <linux-acpi@vger.kernel.org>; Thu, 02 Jul 2015 16:48:54 -0700 (PDT)
In-Reply-To: <1435880916-2153-1-git-send-email-al.stone@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: rjw@rjwysocki.net, lenb@kernel.org, catalin.marinas@arm.com, will.deacon@arm.com, tglx@linutronix.de, jason@lakedaemon.net, linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org, linaro-kernel@lists.linaro.org, patches@linaro.org

For those parts of the arm64 ACPI code that need to check GICC subtables
in the MADT, use the new BAD_MADT_GICC_ENTRY macro instead of the previous
BAD_MADT_ENTRY.  The new macro takes into account differences in the size
of the GICC subtable that the old macro did not; this caused failures even
though the subtable entries are valid.

Fixes: aeb823bbacc2 (ACPICA: ACPI 6.0: Add changes for FADT table.)
Signed-off-by: Al Stone <al.stone@linaro.org>
Reviewed-by: Hanjun Guo <hanjun.guo@linaro.org>
Acked-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/kernel/smp.c   | 2 +-
 drivers/irqchip/irq-gic.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index a1883bf..25fc88c 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -438,7 +438,7 @@ acpi_parse_gic_cpu_interface(struct acpi_subtable_header *header,
 	struct acpi_madt_generic_interrupt *processor;
 
 	processor = (struct acpi_madt_generic_interrupt *)header;
-	if (BAD_MADT_ENTRY(processor, end))
+	if (BAD_MADT_GICC_ENTRY(processor, end))
 		return -EINVAL;
 
 	acpi_table_print_madt_entry(header);
diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index 8d7e1c8..4dd8826 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -1055,7 +1055,7 @@ gic_acpi_parse_madt_cpu(struct acpi_subtable_header *header,
 
 	processor = (struct acpi_madt_generic_interrupt *)header;
 
-	if (BAD_MADT_ENTRY(processor, end))
+	if (BAD_MADT_GICC_ENTRY(processor, end))
 		return -EINVAL;
 
 	/*
-- 
2.4.3

