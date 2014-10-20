From: Jiang Liu <jiang.liu@linux.intel.com>
Subject: [Patch] ACPI, irq: fix regression casued by 6b9fb7082409
Date: Mon, 20 Oct 2014 22:45:27 +0800
Message-ID: <1413816327-12850-1-git-send-email-jiang.liu@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:53040 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751749AbaJTOm3 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 20 Oct 2014 10:42:29 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Bjorn Helgaas <bhelgaas@google.com>
Cc: Jiang Liu <jiang.liu@linux.intel.com>, Tony Luck <tony.luck@intel.com>, x86@kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Thomas Richter <thor@math.tu-berlin.de>, rui.zhang@intel.com

When IOAPIC is disabled, acpi_gsi_to_irq() should return gsi directly
instead of calling mp_map_gsi_to_irq() to translate gsi to IRQ by IOAPIC.
It fixes https://bugzilla.kernel.org/show_bug.cgi?id=84381.

Reported-and-Tested-by: Thomas Richter <thor@math.tu-berlin.de>
Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
Cc: Thomas Richter <thor@math.tu-berlin.de>
Cc: rui.zhang@intel.com
Cc: <stable@vger.kernel.org> # 3.17
---
 arch/x86/kernel/acpi/boot.c |   13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index b436fc735aa4..eceba9d9e116 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -604,14 +604,19 @@ void __init acpi_pic_sci_set_trigger(unsigned int irq, u16 trigger)
 
 int acpi_gsi_to_irq(u32 gsi, unsigned int *irqp)
 {
-	int irq = mp_map_gsi_to_irq(gsi, IOAPIC_MAP_ALLOC | IOAPIC_MAP_CHECK);
+	int irq;
 
-	if (irq >= 0) {
+	if (acpi_irq_model == ACPI_IRQ_MODEL_PIC) {
+		*irqp = gsi;
+	} else {
+		irq = mp_map_gsi_to_irq(gsi,
+					IOAPIC_MAP_ALLOC | IOAPIC_MAP_CHECK);
+		if (irq < 0)
+			return -1;
 		*irqp = irq;
-		return 0;
 	}
 
-	return -1;
+	return 0;
 }
 EXPORT_SYMBOL_GPL(acpi_gsi_to_irq);
 
-- 
1.7.10.4

