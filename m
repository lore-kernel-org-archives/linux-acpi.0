From: Len Brown <lenb@kernel.org>
Subject: [PATCH 07/12] ACPI: acpi_pci_set_power_state() cleanups
Date: Tue, 11 Mar 2008 02:51:44 -0400
Message-ID: <583c377f1d58e705f75d8d5648ab41722be1ebca.1205217406.git.len.brown@intel.com>
References: <1205218309-19695-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.21]:2378 "EHLO
	orsmga101.jf.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754036AbYCKGyz (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 11 Mar 2008 02:54:55 -0400
In-Reply-To: <1205218309-19695-1-git-send-email-lenb@kernel.org>
In-Reply-To: <b95e9e8d94484c2823be67416f25e9756db149dc.1205217406.git.len.brown@intel.com>
References: <b95e9e8d94484c2823be67416f25e9756db149dc.1205217406.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: David Brownell <david-b@pacbell.net>, David Brownell <dbrownell@users.sourceforge.net>, Len Brown <len.brown@intel.com>

From: David Brownell <david-b@pacbell.net>

Minor cleanups to acpi_pci_set_power_state():  use the ACPI and PCI
state symbols to make clear that a mapping is being done between PCI
and ACPI states, instead of using magic numbers.  For paranoia's sake,
report any errors.  Save five bytes (x86_64) too.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/pci/pci-acpi.c |   24 ++++++++++++++++--------
 1 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index 4a23654..72f7476 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -272,21 +272,29 @@ static int acpi_pci_set_power_state(struct pci_dev *dev, pci_power_t state)
 {
 	acpi_handle handle = DEVICE_ACPI_HANDLE(&dev->dev);
 	acpi_handle tmp;
-	static int state_conv[] = {
-		[0] = 0,
-		[1] = 1,
-		[2] = 2,
-		[3] = 3,
-		[4] = 3
+	static const u8 state_conv[] = {
+		[PCI_D0] = ACPI_STATE_D0,
+		[PCI_D1] = ACPI_STATE_D1,
+		[PCI_D2] = ACPI_STATE_D2,
+		[PCI_D3hot] = ACPI_STATE_D3,
+		[PCI_D3cold] = ACPI_STATE_D3
 	};
-	int acpi_state = state_conv[(int __force) state];
 
 	if (!handle)
 		return -ENODEV;
 	/* If the ACPI device has _EJ0, ignore the device */
 	if (ACPI_SUCCESS(acpi_get_handle(handle, "_EJ0", &tmp)))
 		return 0;
-	return acpi_bus_set_power(handle, acpi_state);
+
+	switch (state) {
+	case PCI_D0:
+	case PCI_D1:
+	case PCI_D2:
+	case PCI_D3hot:
+	case PCI_D3cold:
+		return acpi_bus_set_power(handle, state_conv[state]);
+	}
+	return -EINVAL;
 }
 
 
-- 
1.5.4.3.422.g34cd6

