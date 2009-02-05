From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Subject: [PATCH 2/2] PCI/ACPI: rename pci_osc_control_set()
Date: Thu, 05 Feb 2009 23:19:41 +0900
Message-ID: <498AF57D.2050204@jp.fujitsu.com>
References: <498AF51F.7070200@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <498AF51F.7070200@jp.fujitsu.com>
Sender: linux-pci-owner@vger.kernel.org
To: Jesse Barnes <jbarnes@virtuousgeek.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Cc: linux acpi <linux-acpi@vger.kernel.org>, Andrew Patterson <andrew.patterson@hp.com>, Alex Chiang <achiang@hp.com>
List-Id: linux-acpi@vger.kernel.org

- Rename pci_osc_control_set() to acpi_pci_osc_control_set() according
  to the other API names in drivers/acpi/pci_root.c.

- Move _OSC related definitions to include/linux/acpi.h because _OSC
  related API is implemented in drivers/acpi/pci_root.c now.

Signed-off-by: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>

---
 drivers/acpi/pci_root.c            |    6 ++--
 drivers/pci/hotplug/acpi_pcihp.c   |    5 +---
 drivers/pci/pcie/aer/aerdrv_acpi.c |    2 -
 include/linux/acpi.h               |   34 +++++++++++++++++++++++++++
 include/linux/pci-acpi.h           |   45 -------------------------------------
 5 files changed, 40 insertions(+), 52 deletions(-)

Index: 20090205/drivers/acpi/pci_root.c
===================================================================
--- 20090205.orig/drivers/acpi/pci_root.c
+++ 20090205/drivers/acpi/pci_root.c
@@ -306,13 +306,13 @@ static struct acpi_pci_root *acpi_pci_fi
 }
 
 /**
- * pci_osc_control_set - commit requested control to Firmware
+ * acpi_pci_osc_control_set - commit requested control to Firmware
  * @handle: acpi_handle for the target ACPI object
  * @flags: driver's requested control bits
  *
  * Attempt to take control from Firmware on requested control bits.
  **/
-acpi_status pci_osc_control_set(acpi_handle handle, u32 flags)
+acpi_status acpi_pci_osc_control_set(acpi_handle handle, u32 flags)
 {
 	acpi_status status;
 	u32 control_req, result, capbuf[3];
@@ -359,7 +359,7 @@ out:
 	mutex_unlock(&osc_lock);
 	return status;
 }
-EXPORT_SYMBOL(pci_osc_control_set);
+EXPORT_SYMBOL(acpi_pci_osc_control_set);
 
 static int __devinit acpi_pci_root_add(struct acpi_device *device)
 {
Index: 20090205/include/linux/pci-acpi.h
===================================================================
--- 20090205.orig/include/linux/pci-acpi.h
+++ 20090205/include/linux/pci-acpi.h
@@ -10,46 +10,7 @@
 
 #include <linux/acpi.h>
 
-#define OSC_QUERY_TYPE			0
-#define OSC_SUPPORT_TYPE 		1
-#define OSC_CONTROL_TYPE		2
-#define OSC_SUPPORT_MASKS		0x1f
-
-/*
- * _OSC DW0 Definition 
- */
-#define OSC_QUERY_ENABLE		1
-#define OSC_REQUEST_ERROR		2
-#define OSC_INVALID_UUID_ERROR		4
-#define OSC_INVALID_REVISION_ERROR	8
-#define OSC_CAPABILITIES_MASK_ERROR	16
-
-/*
- * _OSC DW1 Definition (OS Support Fields)
- */
-#define OSC_EXT_PCI_CONFIG_SUPPORT		1
-#define OSC_ACTIVE_STATE_PWR_SUPPORT 		2
-#define OSC_CLOCK_PWR_CAPABILITY_SUPPORT	4
-#define OSC_PCI_SEGMENT_GROUPS_SUPPORT		8
-#define OSC_MSI_SUPPORT				16
-
-/*
- * _OSC DW1 Definition (OS Control Fields)
- */
-#define OSC_PCI_EXPRESS_NATIVE_HP_CONTROL	1
-#define OSC_SHPC_NATIVE_HP_CONTROL 		2
-#define OSC_PCI_EXPRESS_PME_CONTROL		4
-#define OSC_PCI_EXPRESS_AER_CONTROL		8
-#define OSC_PCI_EXPRESS_CAP_STRUCTURE_CONTROL	16
-
-#define OSC_CONTROL_MASKS 	(OSC_PCI_EXPRESS_NATIVE_HP_CONTROL | 	\
-				OSC_SHPC_NATIVE_HP_CONTROL | 		\
-				OSC_PCI_EXPRESS_PME_CONTROL |		\
-				OSC_PCI_EXPRESS_AER_CONTROL |		\
-				OSC_PCI_EXPRESS_CAP_STRUCTURE_CONTROL)
-
 #ifdef CONFIG_ACPI
-extern acpi_status pci_osc_control_set(acpi_handle handle, u32 flags);
 static inline acpi_handle acpi_find_root_bridge_handle(struct pci_dev *pdev)
 {
 	/* Find root host bridge */
@@ -69,12 +30,6 @@ static inline acpi_handle acpi_pci_get_b
 	return acpi_get_pci_rootbridge_handle(seg, busnr);
 }
 #else
-#if !defined(AE_ERROR)
-typedef u32 		acpi_status;
-#define AE_ERROR      	(acpi_status) (0x0001)
-#endif    
-static inline acpi_status pci_osc_control_set(acpi_handle handle, u32 flags)
-{return AE_ERROR;}
 static inline acpi_handle acpi_find_root_bridge_handle(struct pci_dev *pdev)
 { return NULL; }
 #endif
Index: 20090205/include/linux/acpi.h
===================================================================
--- 20090205.orig/include/linux/acpi.h
+++ 20090205/include/linux/acpi.h
@@ -256,6 +256,40 @@ void __init acpi_no_s4_hw_signature(void
 void __init acpi_old_suspend_ordering(void);
 void __init acpi_s4_no_nvs(void);
 #endif /* CONFIG_PM_SLEEP */
+
+#define OSC_QUERY_TYPE			0
+#define OSC_SUPPORT_TYPE 		1
+#define OSC_CONTROL_TYPE		2
+#define OSC_SUPPORT_MASKS		0x1f
+
+/* _OSC DW0 Definition */
+#define OSC_QUERY_ENABLE		1
+#define OSC_REQUEST_ERROR		2
+#define OSC_INVALID_UUID_ERROR		4
+#define OSC_INVALID_REVISION_ERROR	8
+#define OSC_CAPABILITIES_MASK_ERROR	16
+
+/* _OSC DW1 Definition (OS Support Fields) */
+#define OSC_EXT_PCI_CONFIG_SUPPORT		1
+#define OSC_ACTIVE_STATE_PWR_SUPPORT 		2
+#define OSC_CLOCK_PWR_CAPABILITY_SUPPORT	4
+#define OSC_PCI_SEGMENT_GROUPS_SUPPORT		8
+#define OSC_MSI_SUPPORT				16
+
+/* _OSC DW1 Definition (OS Control Fields) */
+#define OSC_PCI_EXPRESS_NATIVE_HP_CONTROL	1
+#define OSC_SHPC_NATIVE_HP_CONTROL 		2
+#define OSC_PCI_EXPRESS_PME_CONTROL		4
+#define OSC_PCI_EXPRESS_AER_CONTROL		8
+#define OSC_PCI_EXPRESS_CAP_STRUCTURE_CONTROL	16
+
+#define OSC_CONTROL_MASKS 	(OSC_PCI_EXPRESS_NATIVE_HP_CONTROL | 	\
+				OSC_SHPC_NATIVE_HP_CONTROL | 		\
+				OSC_PCI_EXPRESS_PME_CONTROL |		\
+				OSC_PCI_EXPRESS_AER_CONTROL |		\
+				OSC_PCI_EXPRESS_CAP_STRUCTURE_CONTROL)
+
+extern acpi_status acpi_pci_osc_control_set(acpi_handle handle, u32 flags);
 #else	/* CONFIG_ACPI */
 
 static inline int early_acpi_boot_init(void)
Index: 20090205/drivers/pci/hotplug/acpi_pcihp.c
===================================================================
--- 20090205.orig/drivers/pci/hotplug/acpi_pcihp.c
+++ 20090205/drivers/pci/hotplug/acpi_pcihp.c
@@ -30,9 +30,8 @@
 #include <linux/types.h>
 #include <linux/pci.h>
 #include <linux/pci_hotplug.h>
+#include <linux/acpi.h>
 #include <linux/pci-acpi.h>
-#include <acpi/acpi.h>
-#include <acpi/acpi_bus.h>
 
 #define MY_NAME	"acpi_pcihp"
 
@@ -408,7 +407,7 @@ int acpi_get_hp_hw_control_from_firmware
 		acpi_get_name(handle, ACPI_FULL_PATHNAME, &string);
 		dbg("Trying to get hotplug control for %s\n",
 				(char *)string.pointer);
-		status = pci_osc_control_set(handle, flags);
+		status = acpi_pci_osc_control_set(handle, flags);
 		if (ACPI_SUCCESS(status))
 			goto got_one;
 		kfree(string.pointer);
Index: 20090205/drivers/pci/pcie/aer/aerdrv_acpi.c
===================================================================
--- 20090205.orig/drivers/pci/pcie/aer/aerdrv_acpi.c
+++ 20090205/drivers/pci/pcie/aer/aerdrv_acpi.c
@@ -38,7 +38,7 @@ int aer_osc_setup(struct pcie_device *pc
 
 	handle = acpi_find_root_bridge_handle(pdev);
 	if (handle) {
-		status = pci_osc_control_set(handle,
+		status = acpi_pci_osc_control_set(handle,
 					OSC_PCI_EXPRESS_AER_CONTROL |
 					OSC_PCI_EXPRESS_CAP_STRUCTURE_CONTROL);
 	}
