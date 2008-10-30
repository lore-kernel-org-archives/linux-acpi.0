From: Andrew Patterson <andrew.patterson@hp.com>
Subject: [PATCH 6/6] PCI,
	ACPI: remove obsolete _OSC capability support functions
Date: Wed, 29 Oct 2008 23:28:17 -0600
Message-ID: <20081030052817.10259.87461.stgit@bob.kio>
References: <20081030052746.10259.22045.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t0026.austin.hp.com ([15.216.28.33]:46674 "EHLO
	g1t0026.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752496AbYJ3F2S (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 30 Oct 2008 01:28:18 -0400
In-Reply-To: <20081030052746.10259.22045.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org
Cc: andrew.patterson@hp.com, matthew@wil.cx, kaneshige.kenji@jp.fujitsu.com, bjorn.helgaas@hp.com

PCI, ACPI: remove obsolete _OSC capability support functions

The acpi_query_osc, __pci_osc_support_set, pci_osc_support_set, and
pcie_osc_support_set functions have been obsoleted in favor of setting
these capabilities during root bridge discovery with pci_acpi_osc_support.
There are no longer any callers of these functions, so they are removed.

Signed-off-by: Andrew Patterson <andrew.patterson@hp.com>
---

 drivers/pci/pci-acpi.c   |   25 -------------------------
 include/linux/pci-acpi.h |   11 -----------
 2 files changed, 0 insertions(+), 36 deletions(-)


diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index f457387..128ce7d 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -171,31 +171,6 @@ out:
 	return rc;
 }
 
-static acpi_status acpi_query_osc(acpi_handle handle, u32 level,
-				  void *context, void **retval)
-{
-	pci_acpi_osc_support(handle, (unsigned long)context);
-	return AE_OK;
-}
-
-/**
- * __pci_osc_support_set - register OS support to Firmware
- * @flags: OS support bits
- * @hid: hardware ID
- *
- * Update OS support fields and doing a _OSC Query to obtain an update
- * from Firmware on supported control bits.
- **/
-acpi_status __pci_osc_support_set(u32 flags, const char *hid)
-{
-	if (!(flags & OSC_SUPPORT_MASKS))
-		return AE_TYPE;
-
-	acpi_get_devices(hid, acpi_query_osc,
-			 (void *)(unsigned long)flags, NULL);
-	return AE_OK;
-}
-
 /**
  * pci_osc_control_set - commit requested control to Firmware
  * @handle: acpi_handle for the target ACPI object
diff --git a/include/linux/pci-acpi.h b/include/linux/pci-acpi.h
index 424f06f..871e096 100644
--- a/include/linux/pci-acpi.h
+++ b/include/linux/pci-acpi.h
@@ -50,16 +50,7 @@
 
 #ifdef CONFIG_ACPI
 extern acpi_status pci_osc_control_set(acpi_handle handle, u32 flags);
-extern acpi_status __pci_osc_support_set(u32 flags, const char *hid);
 int pci_acpi_osc_support(acpi_handle handle, u32 flags);
-static inline acpi_status pci_osc_support_set(u32 flags)
-{
-	return __pci_osc_support_set(flags, PCI_ROOT_HID_STRING);
-}
-static inline acpi_status pcie_osc_support_set(u32 flags)
-{
-	return __pci_osc_support_set(flags, PCI_EXPRESS_ROOT_HID_STRING);
-}
 static inline acpi_handle acpi_find_root_bridge_handle(struct pci_dev *pdev)
 {
 	/* Find root host bridge */
@@ -76,8 +67,6 @@ typedef u32 		acpi_status;
 #endif    
 static inline acpi_status pci_osc_control_set(acpi_handle handle, u32 flags)
 {return AE_ERROR;}
-static inline acpi_status pci_osc_support_set(u32 flags) {return AE_ERROR;} 
-static inline acpi_status pcie_osc_support_set(u32 flags) {return AE_ERROR;}
 static inline acpi_handle acpi_find_root_bridge_handle(struct pci_dev *pdev)
 { return NULL; }
 #endif

