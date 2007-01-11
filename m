From: Len Brown <len.brown@intel.com>
Subject: [PATCH 1/7] ACPI: Altix: ACPI _PRT support
Date: Thu, 11 Jan 2007 04:11:42 -0500
Message-ID: <11685067091916-git-send-email-len.brown@intel.com>
References: <11685067081383-git-send-email-len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:7019 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030243AbXAKJLw (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 11 Jan 2007 04:11:52 -0500
In-Reply-To: <11685067081383-git-send-email-len.brown@intel.com>
Message-Id: <3948ec9406f9a60a43d63f23f6f5284db6529b9c.1168506584.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: John Keller <jpk@sgi.com>, Len Brown <len.brown@intel.com>

From: John Keller <jpk@sgi.com>

Provide ACPI _PRT support for SN Altix systems.

The SN Altix platform does not conform to the
IOSAPIC IRQ routing model, so a new acpi_irq_model
(ACPI_IRQ_MODEL_PLATFORM) has been defined. The SN
platform specific code sets acpi_irq_model to
this new value, and keys off of it in acpi_register_gsi()
to avoid the iosapic code path.

Signed-off-by: John Keller <jpk@sgi.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 arch/ia64/kernel/acpi.c            |    3 +++
 arch/ia64/sn/kernel/io_acpi_init.c |    3 +++
 drivers/acpi/bus.c                 |    3 +++
 include/linux/acpi.h               |    1 +
 4 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/ia64/kernel/acpi.c b/arch/ia64/kernel/acpi.c
index 73ef4a8..ef2fe47 100644
--- a/arch/ia64/kernel/acpi.c
+++ b/arch/ia64/kernel/acpi.c
@@ -590,6 +590,9 @@ void __init acpi_numa_arch_fixup(void)
  */
 int acpi_register_gsi(u32 gsi, int triggering, int polarity)
 {
+	if (acpi_irq_model == ACPI_IRQ_MODEL_PLATFORM)
+		return gsi;
+
 	if (has_8259 && gsi < 16)
 		return isa_irq_to_vector(gsi);
 
diff --git a/arch/ia64/sn/kernel/io_acpi_init.c b/arch/ia64/sn/kernel/io_acpi_init.c
index 99d7f27..cb96b4e 100644
--- a/arch/ia64/sn/kernel/io_acpi_init.c
+++ b/arch/ia64/sn/kernel/io_acpi_init.c
@@ -223,6 +223,9 @@ sn_io_acpi_init(void)
 	u64 result;
 	s64 status;
 
+	/* SN Altix does not follow the IOSAPIC IRQ routing model */
+	acpi_irq_model = ACPI_IRQ_MODEL_PLATFORM;
+
 	acpi_bus_register_driver(&acpi_sn_hubdev_driver);
 	status = sal_ioif_init(&result);
 	if (status || result)
diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 279c4ba..766332e 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -561,6 +561,9 @@ static int __init acpi_bus_init_irq(void)
 	case ACPI_IRQ_MODEL_IOSAPIC:
 		message = "IOSAPIC";
 		break;
+	case ACPI_IRQ_MODEL_PLATFORM:
+		message = "platform specific model";
+		break;
 	default:
 		printk(KERN_WARNING PREFIX "Unknown interrupt routing model\n");
 		return -ENODEV;
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 2b0c955..91f1f23 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -47,6 +47,7 @@ enum acpi_irq_model_id {
 	ACPI_IRQ_MODEL_PIC = 0,
 	ACPI_IRQ_MODEL_IOAPIC,
 	ACPI_IRQ_MODEL_IOSAPIC,
+	ACPI_IRQ_MODEL_PLATFORM,
 	ACPI_IRQ_MODEL_COUNT
 };
 
-- 
1.4.4.4.ge05d
