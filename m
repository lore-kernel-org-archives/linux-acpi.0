From: Matthew Garrett <mjg@redhat.com>
Subject: [PATCH 1/3] acpi: Provide default GPE handler if the firmware doesn't
Date: Mon,  9 Nov 2009 17:44:45 -0500
Message-ID: <1257806687-6608-1-git-send-email-mjg@redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:49367 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754238AbZKIWpF (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 9 Nov 2009 17:45:05 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: rjw@sisk.pl, robert.moore@intel.com, Matthew Garrett <mjg@redhat.com>

Firmware may support using GPEs for system wakeup without providing any
runtime GPE handlers. This prevents the use runtime power management on
these devices even if the hardware supports it. This patch adds support
for providing default GPE handlers if the firmware doesn't, allowing us
to implement runtime power management on machines where it would be
otherwise impossible.

This implementation adds basic support for Intel chipsets.

Signed-off-by: Matthew Garrett <mjg@redhat.com>
---
 drivers/pci/pci-acpi.c |  119 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 119 insertions(+), 0 deletions(-)

diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index dae90cc..7fff59c 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -879,6 +879,124 @@ static struct acpi_bus_type acpi_pci_bus = {
 	.find_bridge = acpi_pci_find_root_bridge,
 };
 
+static void acpi_pci_bus_notify(struct work_struct *work)
+{
+	acpi_handle handle = acpi_get_pci_rootbridge_handle(0, 0);
+	struct acpi_device *acpi_dev;
+	struct acpi_pci_root *root;
+
+	kfree(work);
+
+	if (acpi_bus_get_device(handle, &acpi_dev))
+		return;
+
+	root = acpi_driver_data(acpi_dev);
+
+	if (!root)
+		return;
+
+	pci_pme_wakeup_bus(root->bus);
+}
+
+
+static void acpi_pci_uhci_notify(struct work_struct *work)
+{
+	struct pci_dev *pci_dev = NULL;
+
+	kfree(work);
+
+	while ((pci_dev = pci_get_class(PCI_CLASS_SERIAL_USB_UHCI, pci_dev))) {
+		pci_pme_wakeup(pci_dev);
+		pci_dev_put(pci_dev);
+	}
+}
+
+static void acpi_pci_audio_or_uhci_notify(struct work_struct *work)
+{
+	/* FIXME: Need to work out how to check what this actually maps to */
+	return acpi_pci_uhci_notify(work);
+}
+
+static acpi_status acpi_pci_pme_notify(void *context)
+{
+	struct work_struct *work = kzalloc(sizeof(struct work_struct),
+					   GFP_ATOMIC);
+
+	if (work) {
+		INIT_WORK(work, context);
+		schedule_work(work);
+	}
+	return AE_OK;
+}
+
+struct gpe_fixup {
+	int gpe;
+	work_func_t callback;
+};
+
+static struct gpe_fixup acpi_pci_intel_gpes[] = {
+	{ 0x3, &acpi_pci_uhci_notify, },
+	{ 0x4, &acpi_pci_uhci_notify, },
+	{ 0x5, &acpi_pci_audio_or_uhci_notify, },
+	{ 0xb, &acpi_pci_bus_notify, },
+	{ 0xc, &acpi_pci_uhci_notify, },
+	{ 0xd, &acpi_pci_bus_notify, },
+	{ 0xe, &acpi_pci_uhci_notify, },
+	{ 0x20, &acpi_pci_uhci_notify, },
+	{ 0, NULL, },
+};
+
+static void __init acpi_pci_install_gpe(u32 gpe_number,
+					work_func_t callback, int force)
+{
+	acpi_status status;
+	acpi_event_status event_status;
+
+	status = acpi_get_gpe_status(NULL, gpe_number, ACPI_NOT_ISR,
+				     &event_status);
+
+	/* Don't override existing methods by default */
+	if (!force && (event_status & ACPI_EVENT_FLAG_HANDLE))
+		return;
+
+	status = acpi_install_gpe_handler(NULL, gpe_number,
+					  ACPI_GPE_LEVEL_TRIGGERED,
+					  acpi_pci_pme_notify, callback);
+
+	if (ACPI_FAILURE(status) && status != AE_ALREADY_EXISTS) {
+		printk(KERN_INFO "Unable to install GPE fixup for %x\n",
+		       gpe_number);
+		acpi_remove_gpe_handler(NULL, gpe_number, acpi_pci_pme_notify);
+	}
+}
+
+static int __init acpi_pci_gpe_fixups(void)
+{
+	struct pci_dev *lpc;
+	struct gpe_fixup *fixups;
+	int i;
+
+	lpc = pci_get_class(PCI_CLASS_BRIDGE_ISA << 8, NULL);
+
+	if (!lpc)
+		return -ENODEV;
+
+	switch(lpc->vendor) {
+	case PCI_VENDOR_ID_INTEL:
+		fixups = acpi_pci_intel_gpes;
+		break;
+	}
+
+	if (fixups)
+		for (i=0; fixups[i].callback != NULL; i++)
+			acpi_pci_install_gpe(fixups[i].gpe,
+					     fixups[i].callback, false);
+
+	pci_dev_put(lpc);
+
+	return 0;
+}
+
 static int __init acpi_pci_init(void)
 {
 	int ret;
@@ -900,3 +1018,4 @@ static int __init acpi_pci_init(void)
 	return 0;
 }
 arch_initcall(acpi_pci_init);
+late_initcall(acpi_pci_gpe_fixups);
-- 
1.6.5.2

