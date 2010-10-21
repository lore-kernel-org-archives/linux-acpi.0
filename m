From: Myron Stowe <myron.stowe@hp.com>
Subject: [PATCH 4/7] ACPI: Pre-map 'system event' related register blocks
Date: Thu, 21 Oct 2010 14:24:04 -0600
Message-ID: <20101021202404.9220.84209.stgit@bob.kio>
References: <20101021201916.9220.5711.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t0026.austin.hp.com ([15.216.28.33]:24539 "EHLO
	g1t0026.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755287Ab0JUUYF (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 21 Oct 2010 16:24:05 -0400
In-Reply-To: <20101021201916.9220.5711.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, bjorn.helgaas@hp.com, ak@linux.intel.com, ying.huang@intel.com

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
---

 drivers/acpi/osl.c |   71 +++++++++++++++++++++++++++++-----------------------
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

