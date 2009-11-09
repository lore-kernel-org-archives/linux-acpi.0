From: Matthew Garrett <mjg@redhat.com>
Subject: [PATCH 3/3] pci: Override gpe 0xd on Dell machines
Date: Mon,  9 Nov 2009 17:44:47 -0500
Message-ID: <1257806687-6608-3-git-send-email-mjg@redhat.com>
References: <1257806687-6608-1-git-send-email-mjg@redhat.com>
 <1257806687-6608-2-git-send-email-mjg@redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:49374 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755079AbZKIWpG (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 9 Nov 2009 17:45:06 -0500
In-Reply-To: <1257806687-6608-2-git-send-email-mjg@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: rjw@sisk.pl, robert.moore@intel.com, Matthew Garrett <mjg@redhat.com>

Dell's mobile BIOS implements a platform-level check for the bus device
that triggered the PME# GPE. The GPE triggers an SMI, which in turn
causes notifications to be sent to only the devices that require it.

Unfortunately, this SMI is incorrect and fails to generate any notifications.
The wakeup device's PME line thus remains asserted, triggering another GPE
and executing the SMI again. As no notification will ever be sent, the
device is never powered up and the PME bit never cleared. This is less than
optimal.

This issue was supposed to be fixed in systems with an OEM table ID of M09
or higher - unfortunately, it seems that that isn't the case. So, for now,
disable the GPE and allow it to be replaced with an OS-level handler (on
Intel) or ignored (on other chipsets)

Signed-off-by: Matthew Garrett <mjg@redhat.com>
---
 drivers/pci/pci-acpi.c |   24 ++++++++++++++++++++++++
 1 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index 7fff59c..1606d06 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -14,6 +14,7 @@
 #include <linux/pci-aspm.h>
 #include <acpi/acpi.h>
 #include <acpi/acpi_bus.h>
+#include <linux/dmi.h>
 
 #include <linux/pci-acpi.h>
 #include "pci.h"
@@ -970,12 +971,35 @@ static void __init acpi_pci_install_gpe(u32 gpe_number,
 	}
 }
 
+static int __init acpi_gpe_remove_0xd_method(const struct dmi_system_id *d)
+{
+	acpi_remove_gpe_method(NULL, 0xd);
+	return 0;
+}
+
+static struct dmi_system_id gpe_dmi_table[] __initdata = {
+	/*
+	 * Dells have a broken handler for GPE 0xd. Remove it rather than
+	 * trusting it
+	 */
+	{
+		.callback = acpi_gpe_remove_0xd_method,
+		.ident = "Dell",
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "Dell Inc."),
+		},
+	},
+	{}
+};
+
 static int __init acpi_pci_gpe_fixups(void)
 {
 	struct pci_dev *lpc;
 	struct gpe_fixup *fixups;
 	int i;
 
+	dmi_check_system(gpe_dmi_table);
+
 	lpc = pci_get_class(PCI_CLASS_BRIDGE_ISA << 8, NULL);
 
 	if (!lpc)
-- 
1.6.5.2

