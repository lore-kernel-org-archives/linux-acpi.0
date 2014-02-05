From: oliver@neukum.org
Subject: [PATCH] pciehp: Ignore missing surprise bit on some hosts
Date: Wed,  5 Feb 2014 11:32:22 +0100
Message-ID: <1391596342-27191-1-git-send-email-oliver@neukum.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-out002.kontent.com ([81.88.40.216]:49665 "EHLO
	smtp-out002.kontent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750980AbaBEKc1 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 5 Feb 2014 05:32:27 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: trenn@suse.de, lenb@kernel.org, rjw@rjwysocki.net, linux-acpi@vger.kernel.org
Cc: Oliver Neukum <oneukum@suse.de>

From: Oliver Neukum <oneukum@suse.de>

Some hosts have an internal card reader which
connects or disconnects based on the presence of a medium.
Some of those do not correctly advertise a surprise removal
capability of those devices.
Handling events despite an unannounced capability breaks some other
hosts. So a DMI based table is added.

Signed-off-by: Oliver Neukum <oneukum@suse.de>
Reviewed-by: Thomas Renninger <trenn@suse.de>
---
 drivers/pci/hotplug/pciehp.h      |    3 ++-
 drivers/pci/hotplug/pciehp_core.c |   25 +++++++++++++++++++++++++
 2 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
index 838f571..e68ce86 100644
--- a/drivers/pci/hotplug/pciehp.h
+++ b/drivers/pci/hotplug/pciehp.h
@@ -44,6 +44,7 @@ extern int pciehp_poll_mode;
 extern int pciehp_poll_time;
 extern int pciehp_debug;
 extern int pciehp_force;
+extern bool pciehp_surprise;
 extern struct workqueue_struct *pciehp_wq;
 extern struct workqueue_struct *pciehp_ordered_wq;
 
@@ -123,7 +124,7 @@ struct controller {
 #define MRL_SENS(ctrl)		((ctrl)->slot_cap & PCI_EXP_SLTCAP_MRLSP)
 #define ATTN_LED(ctrl)		((ctrl)->slot_cap & PCI_EXP_SLTCAP_AIP)
 #define PWR_LED(ctrl)		((ctrl)->slot_cap & PCI_EXP_SLTCAP_PIP)
-#define HP_SUPR_RM(ctrl)	((ctrl)->slot_cap & PCI_EXP_SLTCAP_HPS)
+#define HP_SUPR_RM(ctrl)	(pciehp_surprise || (ctrl)->slot_cap & PCI_EXP_SLTCAP_HPS)
 #define EMI(ctrl)		((ctrl)->slot_cap & PCI_EXP_SLTCAP_EIP)
 #define NO_CMD_CMPL(ctrl)	((ctrl)->slot_cap & PCI_EXP_SLTCAP_NCCS)
 #define PSN(ctrl)		((ctrl)->slot_cap >> 19)
diff --git a/drivers/pci/hotplug/pciehp_core.c b/drivers/pci/hotplug/pciehp_core.c
index 67b6c54..900fb17 100644
--- a/drivers/pci/hotplug/pciehp_core.c
+++ b/drivers/pci/hotplug/pciehp_core.c
@@ -36,12 +36,14 @@
 #include "pciehp.h"
 #include <linux/interrupt.h>
 #include <linux/time.h>
+#include <linux/dmi.h>
 
 /* Global variables */
 int pciehp_debug;
 int pciehp_poll_mode;
 int pciehp_poll_time;
 int pciehp_force;
+bool pciehp_surprise = false;
 struct workqueue_struct *pciehp_wq;
 struct workqueue_struct *pciehp_ordered_wq;
 
@@ -349,10 +351,33 @@ static struct dmi_system_id __initdata pcieph_dmi_table[] = {
 };
 MODULE_DEVICE_TABLE(dmi, pcieph_dmi_table);
 
+static struct dmi_system_id __initdata pcieph_dmi_surprise_table[] = {
+	{
+		/* HP Probook 445 */
+		.ident = "HP ProBook 445",
+		.matches = {
+			DMI_MATCH(DMI_PRODUCT_NAME, "HP ProBook 445 G1"),
+		},
+	},
+	{
+		/* HP Probook 455 */
+		.ident = "HP ProBook 455",
+		.matches = {
+			DMI_MATCH(DMI_PRODUCT_NAME, "HP ProBook 455 G1"),
+		},
+	},
+	{} /* terminating entry */
+};
+
 static int __init pcied_init(void)
 {
 	int retval = 0;
 
+	if (dmi_check_system(pcieph_dmi_surprise_table)) {
+		pciehp_surprise = true;
+		info(DRIVER_DESC " accepting unannounced surprise event\n");
+	}
+
 	pciehp_wq = alloc_workqueue("pciehp", 0, 0);
 	if (!pciehp_wq)
 		return -ENOMEM;
-- 
1.7.10.4

