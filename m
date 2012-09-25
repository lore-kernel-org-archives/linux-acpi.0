From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH] ACPI: Do not touch legacy irq in Hardware Reduced ACPI mode
Date: Tue, 25 Sep 2012 09:37:16 +0800
Message-ID: <1348537036.10877.186.camel@rui.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:26956 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750928Ab2IYBgd (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 24 Sep 2012 21:36:33 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Len, Brown" <lenb@kernel.org>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

>From 3a60407725e92bbb05e4d723863fe4bd810bdc5e Mon Sep 17 00:00:00 2001
From: Zhang Rui <rui.zhang@intel.com>
Date: Tue, 25 Sep 2012 09:31:08 +0800
Subject: [PATCH] Do not touch legacy irq in Hardware Reduced ACPI mode

In Hardware Reduced ACPI mode, there is neither SCI nor legacy IRQ,
thus we should not touch any of these.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 arch/x86/kernel/acpi/boot.c |   11 ++++++++++-
 drivers/acpi/pci_link.c     |    3 +++
 2 files changed, 13 insertions(+), 1 deletions(-)

diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index b2297e5..f44648f 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -373,6 +373,10 @@ acpi_parse_ioapic(struct acpi_subtable_header * header, const unsigned long end)
  */
 static void __init acpi_sci_ioapic_setup(u8 bus_irq, u16 polarity, u16 trigger, u32 gsi)
 {
+	/* No SCI in Hardware Reduced Mode */
+	if (acpi_gbl_reduced_hardware)
+		return;
+
 	if (trigger == 0)	/* compatible SCI trigger is level */
 		trigger = 3;
 
@@ -992,6 +996,10 @@ void __init mp_config_acpi_legacy_irqs(void)
 	int i;
 	struct mpc_intsrc mp_irq;
 
+	/* No legacy IRQ in Hardware Reduced Mode */
+	if (acpi_gbl_reduced_hardware)
+		return;
+
 #ifdef CONFIG_EISA
 	/*
 	 * Fabricate the legacy ISA bus (bus #31).
@@ -1109,7 +1117,8 @@ int mp_register_gsi(struct device *dev, u32 gsi, int trigger, int polarity)
 		return gsi;
 
 	/* Don't set up the ACPI SCI because it's already set up */
-	if (acpi_gbl_FADT.sci_interrupt == gsi)
+	if (!acpi_gbl_reduced_hardware &&
+	    acpi_gbl_FADT.sci_interrupt == gsi)
 		return gsi;
 
 	ioapic = mp_find_ioapic(gsi);
diff --git a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
index a128082..95ce198 100644
--- a/drivers/acpi/pci_link.c
+++ b/drivers/acpi/pci_link.c
@@ -481,6 +481,9 @@ int __init acpi_irq_penalty_init(void)
 	struct acpi_pci_link *link;
 	int i;
 
+	/* No irq penalty in Hardware Reduced Mode */
+	if (acpi_gbl_reduced_hardware)
+		return 0;
 	/*
 	 * Update penalties to facilitate IRQ balancing.
 	 */
-- 
1.7.7.6



