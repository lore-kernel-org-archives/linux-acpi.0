From: Andrew Patterson <andrew.patterson@hp.com>
Subject: [PATCH 1/4] PCI ACPI: Added a function to register _OSC with only
	PCIe devices.
Date: Tue, 22 Jan 2008 17:18:12 -0700
Message-ID: <20080123001812.28190.84860.stgit@bluto.andrew>
References: <20080123001807.28190.32648.stgit@bluto.andrew>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t0028.austin.hp.com ([15.216.28.35]:43519 "EHLO
	g1t0028.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752436AbYAWASN (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 22 Jan 2008 19:18:13 -0500
In-Reply-To: <20080123001807.28190.32648.stgit@bluto.andrew>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, lenb@kernel.org, gregkh@suse.de, matthew@wil.cx, tom.l.nguyen@intel.com, linux-acpi@vger.kernel.org, Andrew Patterson <andrew.patterson@hp.com>

From: Andrew Patterson <andrew.patterson@hp.com>

The function pci_osc_support_set() traverses every root bridge when
checking for _OSC support for a capability.  It quits as soon as it finds a
device/bridge that doesn't support the requested capability. This won't
work for systems that have mixed PCI and PCIe bridges when checking for
PCIe features.  I split this function into two -- pci_osc_support_set() and
pcie_osc_support_set(). The latter is used when only PCIe devices should be
traversed.

Signed-off-by: Andrew Patterson <andrew.patterson@hp.com>
---

 drivers/pci/pci-acpi.c   |    6 +++---
 include/linux/pci-acpi.h |   11 ++++++++++-
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index 02e4876..ec61428 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -156,13 +156,13 @@ run_osc_out:
 }
 
 /**
- * pci_osc_support_set - register OS support to Firmware
+__pci_osc_support_set - register OS support to Firmware
  * @flags: OS support bits
  *
  * Update OS support fields and doing a _OSC Query to obtain an update
  * from Firmware on supported control bits.
  **/
-acpi_status pci_osc_support_set(u32 flags)
+acpi_status __pci_osc_support_set(u32 flags, const char *hid)
 {
 	u32 temp;
 	acpi_status retval;
@@ -176,7 +176,7 @@ acpi_status pci_osc_support_set(u32 flags)
 	temp = ctrlset_buf[OSC_CONTROL_TYPE];
 	ctrlset_buf[OSC_QUERY_TYPE] = OSC_QUERY_ENABLE;
 	ctrlset_buf[OSC_CONTROL_TYPE] = OSC_CONTROL_MASKS;
-	acpi_get_devices ( PCI_ROOT_HID_STRING,
+	acpi_get_devices(hid,
 			acpi_query_osc,
 			ctrlset_buf,
 			(void **) &retval );
diff --git a/include/linux/pci-acpi.h b/include/linux/pci-acpi.h
index 936ef82..3ba2506 100644
--- a/include/linux/pci-acpi.h
+++ b/include/linux/pci-acpi.h
@@ -48,7 +48,15 @@
 
 #ifdef CONFIG_ACPI
 extern acpi_status pci_osc_control_set(acpi_handle handle, u32 flags);
-extern acpi_status pci_osc_support_set(u32 flags);
+extern acpi_status __pci_osc_support_set(u32 flags, const char *hid);
+static inline acpi_status pci_osc_support_set(u32 flags)
+{
+	return __pci_osc_support_set(flags, PCI_ROOT_HID_STRING);
+}
+static inline acpi_status pcie_osc_support_set(u32 flags)
+{
+	return __pci_osc_support_set(flags, PCI_EXPRESS_ROOT_HID_STRING);
+}
 #else
 #if !defined(AE_ERROR)
 typedef u32 		acpi_status;
@@ -57,6 +65,7 @@ typedef u32 		acpi_status;
 static inline acpi_status pci_osc_control_set(acpi_handle handle, u32 flags)
 {return AE_ERROR;}
 static inline acpi_status pci_osc_support_set(u32 flags) {return AE_ERROR;} 
+static inline acpi_status pcie_osc_support_set(u32 flags) {return AE_ERROR;}
 #endif
 
 #endif	/* _PCI_ACPI_H_ */

