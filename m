From: Len Brown <lenb@kernel.org>
Subject: [PATCH 58/60] ACPI: Pre-map 'system event' related register blocks
Date: Mon, 25 Oct 2010 02:21:06 -0400
Message-ID: <d362edaf5386acedad4319a6721bb1540b74dcf7.1287987547.git.len.brown@intel.com>
References: <1287987668-17584-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173019pub.verizon.net ([206.46.173.19]:50545 "EHLO
	vms173019pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753210Ab0JYHLS (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 25 Oct 2010 03:11:18 -0400
Received: from localhost.localdomain ([unknown] [74.104.161.234])
 by vms173019.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LAU00FPR3YCZ7J4@vms173019.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Mon, 25 Oct 2010 02:11:11 -0500 (CDT)
In-reply-to: <1287987668-17584-1-git-send-email-lenb@kernel.org>
In-reply-to: <a210080195c95ebca2a517ee3057d71607aa65e0.1287987547.git.len.brown@intel.com>
References: <a210080195c95ebca2a517ee3057d71607aa65e0.1287987547.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Myron Stowe <myron.stowe@hp.com>, Len Brown <len.brown@intel.com>

From: Myron Stowe <myron.stowe@hp.com>

During ACPI initialization, pre-map fixed hardware registers that are
accessed during ACPI's 'system event' related IRQ handing.

ACPI's 'system event' handing accesses specific fixed hardware
registers; namely PM1a event, PM1b event, GPE0, and GPE1 register
blocks which are declared within the FADT.  If these registers are
backed by MMIO, as opposed to I/O port space, accessing them within
interrupt context will cause a panic as acpi_os_read_memory()
depends on ioremap() in such cases - BZ 18012.

By utilizing the functionality provided in the previous two patches -
ACPI: Maintain a list of ACPI memory mapped I/O remappings, and, ACPI:
Add interfaces for ioremapping/iounmapping ACPI registers - accesses
to ACPI MMIO areas will now be safe from within interrupt contexts (IRQ
and/or NMI) provided the area was pre-mapped.  This solves BZ 18012.

ACPI "System Event" reference(s):
  ACPI Specification, Revision 4.0, Section 3 "ACPI Overview",
  3.8 "System Events", 5.6 "ACPI Event Programming Model".

Reference: https://bugzilla.kernel.org/show_bug.cgi?id=18012

Reported-by: <bjorn.helgaas@hp.com>
Signed-off-by: Myron Stowe <myron.stowe@hp.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/osl.c |   71 +++++++++++++++++++++++++++++----------------------
 1 files changed, 40 insertions(+), 31 deletions(-)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index fc6c5d2..c63d4cb 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -199,36 +199,6 @@ static int __init acpi_reserve_resources(void)
 }
 device_initcall(acpi_reserve_resources);
 
-acpi_status __init acpi_os_initialize(void)
-{
-	return AE_OK;
-}
-
-acpi_status acpi_os_initialize1(void)
-{
-	kacpid_wq = create_workqueue("kacpid");
-	kacpi_notify_wq = create_workqueue("kacpi_notify");
-	kacpi_hotplug_wq = create_workqueue("kacpi_hotplug");
-	BUG_ON(!kacpid_wq);
-	BUG_ON(!kacpi_notify_wq);
-	BUG_ON(!kacpi_hotplug_wq);
-	return AE_OK;
-}
-
-acpi_status acpi_os_terminate(void)
-{
-	if (acpi_irq_handler) {
-		acpi_os_remove_interrupt_handler(acpi_irq_irq,
-						 acpi_irq_handler);
-	}
-
-	destroy_workqueue(kacpid_wq);
-	destroy_workqueue(kacpi_notify_wq);
-	destroy_workqueue(kacpi_hotplug_wq);
-
-	return AE_OK;
-}
-
 void acpi_os_printf(const char *fmt, ...)
 {
 	va_list args;
@@ -1598,5 +1568,44 @@ acpi_os_validate_address (
 	}
 	return AE_OK;
 }
-
 #endif
+
+acpi_status __init acpi_os_initialize(void)
+{
+	acpi_os_map_generic_address(&acpi_gbl_FADT.xpm1a_event_block);
+	acpi_os_map_generic_address(&acpi_gbl_FADT.xpm1b_event_block);
+	acpi_os_map_generic_address(&acpi_gbl_FADT.xgpe0_block);
+	acpi_os_map_generic_address(&acpi_gbl_FADT.xgpe1_block);
+
+	return AE_OK;
+}
+
+acpi_status acpi_os_initialize1(void)
+{
+	kacpid_wq = create_workqueue("kacpid");
+	kacpi_notify_wq = create_workqueue("kacpi_notify");
+	kacpi_hotplug_wq = create_workqueue("kacpi_hotplug");
+	BUG_ON(!kacpid_wq);
+	BUG_ON(!kacpi_notify_wq);
+	BUG_ON(!kacpi_hotplug_wq);
+	return AE_OK;
+}
+
+acpi_status acpi_os_terminate(void)
+{
+	if (acpi_irq_handler) {
+		acpi_os_remove_interrupt_handler(acpi_irq_irq,
+						 acpi_irq_handler);
+	}
+
+	acpi_os_unmap_generic_address(&acpi_gbl_FADT.xgpe1_block);
+	acpi_os_unmap_generic_address(&acpi_gbl_FADT.xgpe0_block);
+	acpi_os_unmap_generic_address(&acpi_gbl_FADT.xpm1b_event_block);
+	acpi_os_unmap_generic_address(&acpi_gbl_FADT.xpm1a_event_block);
+
+	destroy_workqueue(kacpid_wq);
+	destroy_workqueue(kacpi_notify_wq);
+	destroy_workqueue(kacpi_hotplug_wq);
+
+	return AE_OK;
+}
-- 
1.7.3.2.90.gd4c43

