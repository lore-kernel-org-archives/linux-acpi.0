From: Andrew Patterson <andrew.patterson@hp.com>
Subject: [PATCH 7/7] PCI,
	ACPI: remove obsolete _OSC capability support functions
Date: Tue, 04 Nov 2008 22:30:10 -0700
Message-ID: <20081105053010.15722.69142.stgit@bob.kio>
References: <20081105052934.15722.98580.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <20081105052934.15722.98580.stgit@bob.kio>
Sender: linux-pci-owner@vger.kernel.org
To: linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org
Cc: andrew.patterson@hp.com, matthew@wil.cx, kaneshige.kenji@jp.fujitsu.com, bjorn.helgaas@hp.com
List-Id: linux-acpi@vger.kernel.org

PCI, ACPI: remove obsolete _OSC capability support functions

The acpi_query_osc, __pci_osc_support_set, pci_osc_support_set, and
pcie_osc_support_set functions have been obsoleted in favor of setting
these capabilities during root bridge discovery with pci_acpi_osc_support.
There are no longer any callers of these functions, so they are removed.

Signed-off-by: Andrew Patterson <andrew.patterson@hp.com>
---

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
