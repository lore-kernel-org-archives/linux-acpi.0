From: Len Brown <len.brown@intel.com>
Subject: [PATCH 092/105] ACPI: thinkpad-acpi: improve dock subdriver initialization
Date: Sun, 29 Apr 2007 00:51:32 -0400
Message-ID: <1177822389199-git-send-email-len.brown@intel.com>
References: <11778223052751-git-send-email-len.brown@intel.com>
 <11778223068-git-send-email-len.brown@intel.com>
 <11778223072296-git-send-email-len.brown@intel.com>
 <11778223083747-git-send-email-len.brown@intel.com>
 <11778223081771-git-send-email-len.brown@intel.com>
 <1177822309524-git-send-email-len.brown@intel.com>
 <1177822310688-git-send-email-len.brown@intel.com>
 <11778223112050-git-send-email-len.brown@intel.com>
 <11778223122850-git-send-email-len.brown@intel.com>
 <11778223131932-git-send-email-len.brown@intel.com>
 <11778223143898-git-send-email-len.brown@intel.com>
 <11778223151972-git-send-email-len.brown@intel.com>
 <11778223152006-git-send-email-len.brown@intel.com>
 <11778223161614-git-send-email-len.brown@intel.com>
 <11778223173663-git-send-email-len.brown@intel.com>
 <11778223183783-git-send-email-len.brown@intel.com>
 <11778223192706-git-send-email-len.brown@intel.com>
 <11778223201940-git-send-email-len.brown@intel.com>
 <11778223212414-git-send-email-len.brown@intel.com>
 <11778223211710-git-send-email-len.brown@intel.com>
 <11778223222525-git-send-email-len.brown@intel.com>
 <11778223233885-git-send-email-len.brown@intel.com>
 <1177822324973-git-send-email-len.brown@intel.com>
 <11778223251849-git-send-email-len.brown@intel.com>
 <1177822326583-git-send-email-len.brown@intel.com>
 <11778223273782-git-send-email-len.brown@intel.com>
 <11778223282154-git-send-email-len.brown@intel.com>
 <11778223282215-git-send-email-len.brown@intel.com>
 <11778223304019-git-send-email-len.brown@intel.com>
 <1177822331727-git-send-email-len.brown@intel.com>
 <117782233197-git-send-email-len.brown@intel.com>
 <11778223331858-git-send-email-len.brown@intel.com>
 <11778223353919-git-send-email-len.brown@intel.com>
 <1177822337332-git-send-email-len.brown@intel.com>
 <11778223382880-git-send-email-len.brown@intel.com>
 <11778223392178-git-send-email-len.brown@intel.com>
 <11778223401417-git-send-email-len.brown@intel.com>
 <11778223411658-git-send-email-len.brown@intel.com>
 <11778223412672-git-send-email-len.brown@intel.com>
 <11778223423-git-send-email-len.brown@intel.com>
 <1177822343712-git-send-email-len.brown@intel.com>
 <11778223442065-git-send-email-len.brown@intel.com>
 <11778223452843-git-send-email-len.brown@intel.com>
 <11778223461282-git-send-email-len.brown@intel.com>
 <11778223472316-git-send-email-len.brown@intel.com>
 <1177822347845-git-send-email-len.brown@intel.com>
 <1177822348546-git-send-email-len.brown@intel.com>
 <11778223493327-git-send-email-len.brown@intel.com>
 <11778223502745-git-send-email-len.brown@intel.com>
 <11778223512990-git-send-email-len.brown@intel.com>
 <1177822352591-git-send-email-len.brown@intel.com>
 <11778223532461-git-send-email-len.brown@intel.com>
 <11778223544100-git-send-email-len.brown@intel.com>
 <11778223553521-git-send-email-len.brown@intel.com>
 <11778223551720-git-send-email-len.brown@intel.com>
 <11778223562656-git-send-email-len.brown@intel.com>
 <11778223571390-git-send-email-len.brown@intel.com>
 <11778223581484-git-send-email-len.brown@intel.com>
 <11778223593048-git-send-email-len.brown@intel.com>
 <11778223602019-git-send-email-len.brown@intel.com>
 <11778223612093-git-send-email-len.brown@intel.com>
 <117782236226-git-send-email-len.brown@intel.com>
 <11778223624095-git-send-email-len.brown@intel.com>
 <11778223633408-git-send-email-len.brown@intel.com>
 <1177822364262-git-send-email-len.brown@intel.com>
 <11778223653391-git-send-email-len.brown@intel.com>
 <11778223663850-git-send-email-len.brown@intel.com>
 <11778223673988-git-send-email-len.brown@intel.com>
 <1177822368767-git-send-email-len.brown@intel.com>
 <1177822368793-git-send-email-len.brown@intel.com>
 <11778223692377-git-send-email-len.brown@intel.com>
 <1177822370442-git-send-email-len.brown@intel.com>
 <1177822371935-git-send-email-len.brown@intel.com>
 <11778223721984-git-send-email-len.brown@intel.com>
 <11778223732286-git-send-email-len.brown@intel.com>
 <11778223733679-git-send-email-len.brown@intel.com>
 <11778223741-git-send-email-len.brown@intel.com>
 <11778223752175-git-send-email-len.brown@intel.com>
 <1177822376123-git-send-email-len.brown@intel.com>
 <11778223771048-git-send-email-len.brown@intel.com>
 <11778223782086-git-send-email-len.brown@intel.com>
 <11778223792074-git-send-email-len.brown@intel.com>
 <11778223802796-git-send-email-len.brown@intel.com>
 <11778223812071-git-send-email-len.brown@intel.com>
 <11778223823637-git-send-email-len.brown@intel.com>
 <117782238310-git-send-email-len.brown@intel.com>
 <11778223843825-git-send-email-len.brown@intel.com>
 <11778223852391-git-send-email-len.brown@intel.com>
 <11778223861983-git-send-email-len.brown@intel.com>
 <11778223872566-git-send-email-len.brown@intel.com>
 <1177822387623-git-send-email-len.brown@intel.com>
 <1177822388542-git-send-email-len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:37949 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756206AbXD2ExO (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 29 Apr 2007 00:53:14 -0400
In-Reply-To: <1177822388542-git-send-email-len.brown@intel.com>
Message-Id: <d94a7f16cad7700f8d2b142cc13cfba5387af3db.1177822058.git.len.brown@intel.com>
In-Reply-To: <ac122bb64b0d51f0512185d3522a75f3f3a80bc9.1177822058.git.len.brown@intel.com>
References: <ac122bb64b0d51f0512185d3522a75f3f3a80bc9.1177822058.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Len Brown <len.brown@intel.com>

From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>

The dock sub-driver has split-personality (two subdrivers), and it was
doing some unoptimal things on init because of that.  Fix it so that the
second half of it will only init when necessary, and only if the first half
initialized sucessfully in the first place.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/misc/thinkpad_acpi.c |   78 +++++++++++++++++++++++++++---------------
 1 files changed, 50 insertions(+), 28 deletions(-)

diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
index 68f1cc0..a565265 100644
--- a/drivers/misc/thinkpad_acpi.c
+++ b/drivers/misc/thinkpad_acpi.c
@@ -1519,6 +1519,33 @@ IBM_HANDLE(dock, root, "\\_SB.GDCK",	/* X30, X31, X40 */
 /* don't list other alternatives as we install a notify handler on the 570 */
 IBM_HANDLE(pci, root, "\\_SB.PCI");	/* 570 */
 
+static struct tp_acpi_drv_struct ibm_dock_acpidriver[2] = {
+	{
+	 .notify = dock_notify,
+	 .handle = &dock_handle,
+	 .type = ACPI_SYSTEM_NOTIFY,
+	},
+	{
+	 .hid = IBM_PCI_HID,
+	 .notify = dock_notify,
+	 .handle = &pci_handle,
+	 .type = ACPI_SYSTEM_NOTIFY,
+	},
+};
+
+static struct ibm_struct dock_driver_data[2] = {
+	{
+	 .name = "dock",
+	 .read = dock_read,
+	 .write = dock_write,
+	 .acpi = &ibm_dock_acpidriver[0],
+	},
+	{
+	 .name = "dock",
+	 .acpi = &ibm_dock_acpidriver[1],
+	},
+};
+
 #define dock_docked() (_sta(dock_handle) & 1)
 
 static int __init dock_init(struct ibm_init_struct *iibm)
@@ -1526,7 +1553,6 @@ static int __init dock_init(struct ibm_init_struct *iibm)
 	vdbg_printk(TPACPI_DBG_INIT, "initializing dock subdriver\n");
 
 	IBM_ACPIHANDLE_INIT(dock);
-	IBM_ACPIHANDLE_INIT(pci);
 
 	vdbg_printk(TPACPI_DBG_INIT, "dock is %s\n",
 		str_supported(dock_handle != NULL));
@@ -1534,6 +1560,28 @@ static int __init dock_init(struct ibm_init_struct *iibm)
 	return (dock_handle)? 0 : 1;
 }
 
+static int __init dock_init2(struct ibm_init_struct *iibm)
+{
+	int dock2_needed;
+
+	vdbg_printk(TPACPI_DBG_INIT, "initializing dock subdriver part 2\n");
+
+	if (dock_driver_data[0].flags.acpi_driver_registered &&
+	    dock_driver_data[0].flags.acpi_notify_installed) {
+		IBM_ACPIHANDLE_INIT(pci);
+		dock2_needed = (pci_handle != NULL);
+		vdbg_printk(TPACPI_DBG_INIT,
+			    "dock PCI handler for the TP 570 is %s\n",
+			    str_supported(dock2_needed));
+	} else {
+		vdbg_printk(TPACPI_DBG_INIT,
+		"dock subdriver part 2 not required\n");
+		dock2_needed = 0;
+	}
+
+	return (dock2_needed)? 0 : 1;
+}
+
 static void dock_notify(struct ibm_struct *ibm, u32 event)
 {
 	int docked = dock_docked();
@@ -1595,33 +1643,6 @@ static int dock_write(char *buf)
 	return 0;
 }
 
-static struct tp_acpi_drv_struct ibm_dock_acpidriver[2] = {
-	{
-	 .notify = dock_notify,
-	 .handle = &dock_handle,
-	 .type = ACPI_SYSTEM_NOTIFY,
-	},
-	{
-	 .hid = IBM_PCI_HID,
-	 .notify = dock_notify,
-	 .handle = &pci_handle,
-	 .type = ACPI_SYSTEM_NOTIFY,
-	},
-};
-
-static struct ibm_struct dock_driver_data[2] = {
-	{
-	 .name = "dock",
-	 .read = dock_read,
-	 .write = dock_write,
-	 .acpi = &ibm_dock_acpidriver[0],
-	},
-	{
-	 .name = "dock",
-	 .acpi = &ibm_dock_acpidriver[1],
-	},
-};
-
 #endif /* CONFIG_THINKPAD_ACPI_DOCK */
 
 /*************************************************************************
@@ -3850,6 +3871,7 @@ static struct ibm_init_struct ibms_init[] __initdata = {
 		.data = &dock_driver_data[0],
 	},
 	{
+		.init = dock_init2,
 		.data = &dock_driver_data[1],
 	},
 #endif
-- 
1.5.2.rc0.34.gda94
