From: Len Brown <lenb@kernel.org>
Subject: [PATCH 129/140] Altix: Add ACPI SSDT PCI device support (hotplug)
Date: Wed,  7 Feb 2007 13:52:23 -0500
Message-ID: <1170874546646-git-send-email-lenb@kernel.org>
References: <11708743541314-git-send-email-lenb@kernel.org> <11708743561383-git-send-email-lenb@kernel.org> <117087435785-git-send-email-lenb@kernel.org> <11708743582090-git-send-email-lenb@kernel.org> <11708743611662-git-send-email-lenb@kernel.org> <11708743653073-git-send-email-lenb@kernel.org> <11708743674006-git-send-email-lenb@kernel.org> <11708743693386-git-send-email-lenb@kernel.org> <11708743702194-git-send-email-lenb@kernel.org> <11708743723353-git-send-email-lenb@kernel.org> <11708743783727-git-send-email-lenb@kernel.org> <11708743802558-git-send-email-lenb@kernel.org> <11708743821259-git-send-email-lenb@kernel.org> <11708743853573-git-send-email-lenb@kernel.org> <11708743871468-git-send-email-lenb@kernel.org> <1170874390715-git-send-email-lenb@kernel.org> <1170874393736-git-send-email-lenb@kernel.org> <11708743943108-git-send-email-lenb@kernel.org> <11708743962377-git-send-ema
 il-lenb@kernel.org> <11708743972593-git-send-email-lenb@kernel.org> <1170874398386-git-send-email-lenb@kernel.org> <11708743993414-git-send-email-lenb@kernel.org> <11708744003959-git-send-email-lenb@kernel.org> <11708744023872-git-send-email-lenb@kernel.org> <11708744032427-git-send-email-lenb@kernel.org> <11708744053556-git-send-email-lenb@kernel.org> <11708744062538-git-send-email-lenb@kernel.org> <11708744071019-git-send-email-lenb@kernel.org> <11708744093818-git-send-email-lenb@kernel.org> <11708744101300-git-send-email-lenb@kernel.org> <1170874412494-git-send-email-lenb@kernel.org> <11708744142658-git-send-email-lenb@kernel.org> <1170874415464-git-send-email-lenb@kernel.org> <1170874417392-git-send-email-lenb@kernel.org> <1170874418134-git-send-email-lenb@kernel.org> <11708744191642-git-send-email-lenb@kernel.org> <11708744203492-git-send-email-lenb@kernel.org> <1170874421658-git-
 send-email-lenb@kernel.org> <1170874422581-git-send-email-lenb@kernel.org> <117087442385-git-send-email-lenb@kernel.org> <1170874424332-git-send-email-lenb@kernel.org> <11708744253790-git-send-email-lenb@kernel.org> <11708744263395-git-send-email-lenb@kernel.org> <11708744273028-git-send-email-lenb@kernel.org> <11708744272354-git-send-email-lenb@kernel.org> <11708744311281-git-send-email-lenb@kernel.org> <11708744322360-git-send-email-lenb@kernel.org> <1170874433382-git-send-email-lenb@kernel.org> <11708744353864-git-send-email-lenb@kernel.org> <11708744352790-git-send-email-lenb@kernel.org> <1170874437973-git-send-email-lenb@kernel.org> <11708744382626-git-send-email-lenb@kernel.org> <11708744402139-git-send-email-lenb@kernel.org> <11708744413743-git-send-email-lenb@kernel.org> <117087444256-git-send-email-lenb@kernel.org> <11708744461131-git-send-email-lenb@kernel.org> <1170874451354
 1-git-send-email-lenb@kernel.org> <11708744522444-git-send-email-lenb@kernel.org> <1170874453363-git-send-email-lenb@kernel.org> <11708744542419-git-send-email-lenb@kernel.org> <11708744562243-git-send-email-lenb@kernel.org> <1170874458256-git-send-email-lenb@kernel.org> <11708744603317-git-send-email-lenb@kernel.org> <11708744612314-git-send-email-lenb@kernel.org> <117087446376-git-send-email-lenb@kernel.org> <11708744642267-git-send-email-lenb@kernel.org> <11708744674050-git-send-email-lenb@kernel.org> <11708744692041-git-send-email-lenb@kernel.org> <11708744712690-git-send-email-lenb@kernel.org> <11708744732351-git-send-email-lenb@kernel.org> <11708744752537-git-send-email-lenb@kernel.org> <11708744772462-git-send-email-lenb@kernel.org> <11708744803527-git-send-email-lenb@kernel.org> <11708744813011-git-send-email-lenb@kernel.org> <11708744852095-git-send-email-lenb@kernel.org> <117
 08744874154-git-send-email-lenb@kernel.org> <11708744878-git-send-email-lenb@kernel.org> <1170874488430-git-send-email-lenb@kernel.org> <11708744903381-git-send-email-lenb@kernel.org> <11708744911989-git-send-email-lenb@kernel.org> <11708744922677-git-send-email-lenb@kernel.org> <11708744934033-git-send-email-lenb@kernel.org> <1170874494939-git-send-email-lenb@kernel.org> <11708744951308-git-send-emailMessage-Id: <3e643e77a929202455a0cc868c2030a5ba8d1371.1170873819.git.len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([143.182.124.22]:1087 "EHLO
	azsmga101.ch.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1422872AbXBGSzt (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 7 Feb 2007 13:55:49 -0500
In-Reply-To: <11708745451195-git-send-email-lenb@kernel.org>
In-Reply-To: <9e89dde2b063ca73fcdc9244fe68e2dea32c5088.1170873816.git.len.brown@intel.com>
References: <9e89dde2b063ca73fcdc9244fe68e2dea32c5088.1170873816.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: John Keller <jpk@sgi.com>, Aaron Young <ayoung@sgi.com>, Andrew Morton <akpm@osdl.org>, Len Brown <len.brown@intel.com>

From: John Keller <jpk@sgi.com>

Support for dynamic loading and unloading of ACPI SSDT tables upon slot
hotplugs and unplugs.

On SN platforms, we now represent every populated root bus slot with a single
ACPI SSDT table containing info for every device and PPB attached to the slot.
 These SSDTs are generated by the prom at initial boot and hotplug time.  The
info in these SSDT tables is used by the SN kernel IO "fixup" code (which is
called at boot and hotplug time).

On hotplugs (i.e.  enable_slot()), if running with an ACPI capable prom,
attempt to obtain a new ACPI SSDT table for the slot being hotplugged.  If
successful, add the table to the ACPI namespace (acpi_load_table()) and then
walk the new devices and add them to the ACPI infrastructure (acpi_bus_add()).

On hot unplugs (i.e.  disable_slot()), if running with an ACPI capable prom,
attempt to remove the SSDT table associated with the slot from the ACPI
namespace (acpi_unload_table_id()) and infastructure (acpi_bus_trim()).

From: John Keller <jpk@sgi.com>

 A bug was fixed where the sgi hotplug driver was removing
 the slot's SSDT table from the ACPI namespace a bit too early in
 disable_slot(). Also, we now call acpi_bus_start() subsequent
 to acpi_bus_add().

Signed-off-by: Aaron Young <ayoung@sgi.com>
Cc: Greg KH <greg@kroah.com>
Cc: "Luck, Tony" <tony.luck@intel.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Len Brown<len.brown@intel.com>
---
 drivers/pci/hotplug/sgi_hotplug.c |  155 +++++++++++++++++++++++++++++++++++--
 1 files changed, 148 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/hotplug/sgi_hotplug.c b/drivers/pci/hotplug/sgi_hotplug.c
index 5d188c5..78cf071 100644
--- a/drivers/pci/hotplug/sgi_hotplug.c
+++ b/drivers/pci/hotplug/sgi_hotplug.c
@@ -28,6 +28,8 @@
 #include <asm/sn/sn_feature_sets.h>
 #include <asm/sn/sn_sal.h>
 #include <asm/sn/types.h>
+#include <linux/acpi.h>
+#include <asm/sn/acpi.h>
 
 #include "../pci.h"
 
@@ -35,14 +37,17 @@ MODULE_LICENSE("GPL");
 MODULE_AUTHOR("SGI (prarit@sgi.com, dickie@sgi.com, habeck@sgi.com)");
 MODULE_DESCRIPTION("SGI Altix Hot Plug PCI Controller Driver");
 
-#define PCIIO_ASIC_TYPE_TIOCA		4
+
+/* SAL call error codes. Keep in sync with prom header io/include/pcibr.h */
 #define PCI_SLOT_ALREADY_UP		2	/* slot already up */
 #define PCI_SLOT_ALREADY_DOWN		3	/* slot already down */
 #define PCI_L1_ERR			7	/* L1 console command error */
 #define PCI_EMPTY_33MHZ			15	/* empty 33 MHz bus */
+
+
+#define PCIIO_ASIC_TYPE_TIOCA		4
 #define PCI_L1_QSIZE			128	/* our L1 message buffer size */
 #define SN_MAX_HP_SLOTS			32	/* max hotplug slots */
-#define SGI_HOTPLUG_PROM_REV		0x0430	/* Min. required PROM version */
 #define SN_SLOT_NAME_SIZE		33	/* size of name string */
 
 /* internal list head */
@@ -227,7 +232,7 @@ static void sn_bus_free_data(struct pci_dev *dev)
 }
 
 static int sn_slot_enable(struct hotplug_slot *bss_hotplug_slot,
-			  int device_num)
+			  int device_num, char **ssdt)
 {
 	struct slot *slot = bss_hotplug_slot->private;
 	struct pcibus_info *pcibus_info;
@@ -240,7 +245,8 @@ static int sn_slot_enable(struct hotplug_slot *bss_hotplug_slot,
 	 * Power-on and initialize the slot in the SN
 	 * PCI infrastructure.
 	 */
-	rc = sal_pcibr_slot_enable(pcibus_info, device_num, &resp);
+	rc = sal_pcibr_slot_enable(pcibus_info, device_num, &resp, ssdt);
+
 
 	if (rc == PCI_SLOT_ALREADY_UP) {
 		dev_dbg(slot->pci_bus->self, "is already active\n");
@@ -335,6 +341,7 @@ static int enable_slot(struct hotplug_slot *bss_hotplug_slot)
 	int func, num_funcs;
 	int new_ppb = 0;
 	int rc;
+	char *ssdt = NULL;
 	void pcibios_fixup_device_resources(struct pci_dev *);
 
 	/* Serialize the Linux PCI infrastructure */
@@ -342,14 +349,29 @@ static int enable_slot(struct hotplug_slot *bss_hotplug_slot)
 
 	/*
 	 * Power-on and initialize the slot in the SN
-	 * PCI infrastructure.
+	 * PCI infrastructure. Also, retrieve the ACPI SSDT
+	 * table for the slot (if ACPI capable PROM).
 	 */
-	rc = sn_slot_enable(bss_hotplug_slot, slot->device_num);
+	rc = sn_slot_enable(bss_hotplug_slot, slot->device_num, &ssdt);
 	if (rc) {
 		mutex_unlock(&sn_hotplug_mutex);
 		return rc;
 	}
 
+	if (ssdt)
+		ssdt = __va(ssdt);
+	/* Add the new SSDT for the slot to the ACPI namespace */
+	if (SN_ACPI_BASE_SUPPORT() && ssdt) {
+		acpi_status ret;
+
+		ret = acpi_load_table((struct acpi_table_header *)ssdt);
+		if (ACPI_FAILURE(ret)) {
+			printk(KERN_ERR "%s: acpi_load_table failed (0x%x)\n",
+			       __FUNCTION__, ret);
+			/* try to continue on */
+		}
+	}
+
 	num_funcs = pci_scan_slot(slot->pci_bus,
 				  PCI_DEVFN(slot->device_num + 1, 0));
 	if (!num_funcs) {
@@ -374,7 +396,10 @@ static int enable_slot(struct hotplug_slot *bss_hotplug_slot)
 			 * pdi_host_pcidev_info).
 			 */
 			pcibios_fixup_device_resources(dev);
-			sn_pci_fixup_slot(dev);
+			if (SN_ACPI_BASE_SUPPORT())
+				sn_acpi_slot_fixup(dev);
+			else
+				sn_io_slot_fixup(dev);
 			if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE) {
 				unsigned char sec_bus;
 				pci_read_config_byte(dev, PCI_SECONDARY_BUS,
@@ -388,6 +413,63 @@ static int enable_slot(struct hotplug_slot *bss_hotplug_slot)
 		}
 	}
 
+	/*
+	 * Add the slot's devices to the ACPI infrastructure */
+	if (SN_ACPI_BASE_SUPPORT() && ssdt) {
+		unsigned long adr;
+		struct acpi_device *pdevice;
+		struct acpi_device *device;
+		acpi_handle phandle;
+		acpi_handle chandle = NULL;
+		acpi_handle rethandle;
+		acpi_status ret;
+
+		phandle = PCI_CONTROLLER(slot->pci_bus)->acpi_handle;
+
+		if (acpi_bus_get_device(phandle, &pdevice)) {
+			dev_dbg(slot->pci_bus->self,
+				"no parent device, assuming NULL\n");
+			pdevice = NULL;
+		}
+
+		/*
+		 * Walk the rootbus node's immediate children looking for
+		 * the slot's device node(s). There can be more than
+		 * one for multifunction devices.
+		 */
+		for (;;) {
+			rethandle = NULL;
+			ret = acpi_get_next_object(ACPI_TYPE_DEVICE,
+						   phandle, chandle,
+						   &rethandle);
+
+			if (ret == AE_NOT_FOUND || rethandle == NULL)
+				break;
+
+			chandle = rethandle;
+
+			ret = acpi_evaluate_integer(chandle, METHOD_NAME__ADR,
+						    NULL, &adr);
+
+			if (ACPI_SUCCESS(ret) &&
+			    (adr>>16) == (slot->device_num + 1)) {
+
+				ret = acpi_bus_add(&device, pdevice, chandle,
+						   ACPI_BUS_TYPE_DEVICE);
+				if (ACPI_FAILURE(ret)) {
+					printk(KERN_ERR "%s: acpi_bus_add "
+					       "failed (0x%x) for slot %d "
+					       "func %d\n", __FUNCTION__,
+					       ret, (int)(adr>>16),
+					       (int)(adr&0xffff));
+					/* try to continue on */
+				} else {
+					acpi_bus_start(device);
+				}
+			}
+		}
+	}
+
 	/* Call the driver for the new device */
 	pci_bus_add_devices(slot->pci_bus);
 	/* Call the drivers for the new devices subordinate to PPB */
@@ -412,6 +494,7 @@ static int disable_slot(struct hotplug_slot *bss_hotplug_slot)
 	struct pci_dev *dev;
 	int func;
 	int rc;
+	acpi_owner_id ssdt_id = 0;
 
 	/* Acquire update access to the bus */
 	mutex_lock(&sn_hotplug_mutex);
@@ -422,6 +505,52 @@ static int disable_slot(struct hotplug_slot *bss_hotplug_slot)
 	if (rc)
 		goto leaving;
 
+	/* free the ACPI resources for the slot */
+	if (SN_ACPI_BASE_SUPPORT() &&
+            PCI_CONTROLLER(slot->pci_bus)->acpi_handle) {
+		unsigned long adr;
+		struct acpi_device *device;
+		acpi_handle phandle;
+		acpi_handle chandle = NULL;
+		acpi_handle rethandle;
+		acpi_status ret;
+
+		/* Get the rootbus node pointer */
+		phandle = PCI_CONTROLLER(slot->pci_bus)->acpi_handle;
+
+		/*
+		 * Walk the rootbus node's immediate children looking for
+		 * the slot's device node(s). There can be more than
+		 * one for multifunction devices.
+		 */
+		for (;;) {
+			rethandle = NULL;
+			ret = acpi_get_next_object(ACPI_TYPE_DEVICE,
+						   phandle, chandle,
+						   &rethandle);
+
+			if (ret == AE_NOT_FOUND || rethandle == NULL)
+				break;
+
+			chandle = rethandle;
+
+			ret = acpi_evaluate_integer(chandle,
+						    METHOD_NAME__ADR,
+						    NULL, &adr);
+			if (ACPI_SUCCESS(ret) &&
+			    (adr>>16) == (slot->device_num + 1)) {
+				/* retain the owner id */
+				acpi_get_id(chandle, &ssdt_id);
+
+				ret = acpi_bus_get_device(chandle,
+							  &device);
+				if (ACPI_SUCCESS(ret))
+					acpi_bus_trim(device, 1);
+			}
+		}
+
+	}
+
 	/* Free the SN resources assigned to the Linux device.*/
 	for (func = 0; func < 8;  func++) {
 		dev = pci_get_slot(slot->pci_bus,
@@ -434,6 +563,18 @@ static int disable_slot(struct hotplug_slot *bss_hotplug_slot)
 		}
 	}
 
+	/* Remove the SSDT for the slot from the ACPI namespace */
+	if (SN_ACPI_BASE_SUPPORT() && ssdt_id) {
+		acpi_status ret;
+		ret = acpi_unload_table_id(ssdt_id);
+		if (ACPI_FAILURE(ret)) {
+			printk(KERN_ERR "%s: acpi_unload_table_id "
+			       "failed (0x%x) for id %d\n",
+			       __FUNCTION__, ret, ssdt_id);
+			/* try to continue on */
+		}
+	}
+
 	/* free the collected sysdata pointers */
 	sn_bus_free_sysdata();
 
-- 
1.5.0.rc3.39.gec804
