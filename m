From: Len Brown <lenb@kernel.org>
Subject: [PATCH 28/33] IPMI: Add one interface to get more info of low-level
 IPMI device
Date: Sun, 26 Dec 2010 17:43:49 -0500
Message-ID: <16f4232ce4d6855361b4eb56262f4a202295c978.1293403342.git.len.brown@intel.com>
References: <1293403434-12054-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:48856 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752588Ab0LZX6u (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 26 Dec 2010 18:58:50 -0500
Received: from localhost.localdomain ([unknown] [108.7.186.163])
 by vms173003.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LE2004117XXGRZ1@vms173003.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sun, 26 Dec 2010 17:58:49 -0600 (CST)
In-reply-to: <1293403434-12054-1-git-send-email-lenb@kernel.org>
In-reply-to: <803711afdbea5c6a6dd2b46eca76097f6d50fb53.1293403342.git.len.brown@intel.com>
References: <803711afdbea5c6a6dd2b46eca76097f6d50fb53.1293403342.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Zhao Yakui <yakui.zhao@intel.com>, Corey Minyard <cminyard@mvista.com>, Len Brown <len.brown@intel.com>

From: Zhao Yakui <yakui.zhao@intel.com>

The IPMI smi_watcher will be used to catch the IPMI interface as they
come or go.  In order to communicate with the correct IPMI device, it
should be confirmed whether it is what we wanted especially on the
system with multiple IPMI devices. But the new_smi callback function
of smi_watcher provides very limited info(only the interface number
and dev pointer) and there is no detailed info about the low level
interface. For example: which mechansim registers the IPMI
interface(ACPI, PCI, DMI and so on).

This is to add one interface that can get more info of low-level IPMI
device. For example: the ACPI device handle will be returned for the
pnp_acpi IPMI device.

Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
Signed-off-by: Corey Minyard <cminyard@mvista.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/char/ipmi/ipmi_msghandler.c |   27 ++++++++++++++++++++++++
 drivers/char/ipmi/ipmi_si_intf.c    |   20 ++++++++++++++---
 include/linux/ipmi.h                |   38 +++++++++++++++++++++++++++++++++++
 include/linux/ipmi_smi.h            |    8 +++++++
 4 files changed, 89 insertions(+), 4 deletions(-)

diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
index 2fe72f8..38223e9 100644
--- a/drivers/char/ipmi/ipmi_msghandler.c
+++ b/drivers/char/ipmi/ipmi_msghandler.c
@@ -970,6 +970,33 @@ out_kfree:
 }
 EXPORT_SYMBOL(ipmi_create_user);
 
+int ipmi_get_smi_info(int if_num, struct ipmi_smi_info *data)
+{
+	int           rv = 0;
+	ipmi_smi_t    intf;
+	struct ipmi_smi_handlers *handlers;
+
+	mutex_lock(&ipmi_interfaces_mutex);
+	list_for_each_entry_rcu(intf, &ipmi_interfaces, link) {
+		if (intf->intf_num == if_num)
+			goto found;
+	}
+	/* Not found, return an error */
+	rv = -EINVAL;
+	mutex_unlock(&ipmi_interfaces_mutex);
+	return rv;
+
+found:
+	handlers = intf->handlers;
+	rv = -ENOSYS;
+	if (handlers->get_smi_info)
+		rv = handlers->get_smi_info(intf->send_info, data);
+	mutex_unlock(&ipmi_interfaces_mutex);
+
+	return rv;
+}
+EXPORT_SYMBOL(ipmi_get_smi_info);
+
 static void free_user(struct kref *ref)
 {
 	ipmi_user_t user = container_of(ref, struct ipmi_user, refcount);
diff --git a/drivers/char/ipmi/ipmi_si_intf.c b/drivers/char/ipmi/ipmi_si_intf.c
index 035da9e..945ae4d 100644
--- a/drivers/char/ipmi/ipmi_si_intf.c
+++ b/drivers/char/ipmi/ipmi_si_intf.c
@@ -57,6 +57,7 @@
 #include <asm/irq.h>
 #include <linux/interrupt.h>
 #include <linux/rcupdate.h>
+#include <linux/ipmi.h>
 #include <linux/ipmi_smi.h>
 #include <asm/io.h>
 #include "ipmi_si_sm.h"
@@ -107,10 +108,6 @@ enum si_type {
 };
 static char *si_to_str[] = { "kcs", "smic", "bt" };
 
-enum ipmi_addr_src {
-	SI_INVALID = 0, SI_HOTMOD, SI_HARDCODED, SI_SPMI, SI_ACPI, SI_SMBIOS,
-	SI_PCI,	SI_DEVICETREE, SI_DEFAULT
-};
 static char *ipmi_addr_src_to_str[] = { NULL, "hotmod", "hardcoded", "SPMI",
 					"ACPI", "SMBIOS", "PCI",
 					"device-tree", "default" };
@@ -291,6 +288,7 @@ struct smi_info {
 	struct task_struct *thread;
 
 	struct list_head link;
+	union ipmi_smi_info_union addr_info;
 };
 
 #define smi_inc_stat(smi, stat) \
@@ -1186,6 +1184,18 @@ static int smi_start_processing(void       *send_info,
 	return 0;
 }
 
+static int get_smi_info(void *send_info, struct ipmi_smi_info *data)
+{
+	struct smi_info *smi = send_info;
+
+	data->addr_src = smi->addr_source;
+	data->dev = smi->dev;
+	data->addr_info = smi->addr_info;
+	get_device(smi->dev);
+
+	return 0;
+}
+
 static void set_maintenance_mode(void *send_info, int enable)
 {
 	struct smi_info   *smi_info = send_info;
@@ -1197,6 +1207,7 @@ static void set_maintenance_mode(void *send_info, int enable)
 static struct ipmi_smi_handlers handlers = {
 	.owner                  = THIS_MODULE,
 	.start_processing       = smi_start_processing,
+	.get_smi_info		= get_smi_info,
 	.sender			= sender,
 	.request_events		= request_events,
 	.set_maintenance_mode   = set_maintenance_mode,
@@ -2156,6 +2167,7 @@ static int __devinit ipmi_pnp_probe(struct pnp_dev *dev,
 	printk(KERN_INFO PFX "probing via ACPI\n");
 
 	handle = acpi_dev->handle;
+	info->addr_info.acpi_info.acpi_handle = handle;
 
 	/* _IFT tells us the interface type: KCS, BT, etc */
 	status = acpi_evaluate_integer(handle, "_IFT", NULL, &tmp);
diff --git a/include/linux/ipmi.h b/include/linux/ipmi.h
index 65aae34..045f2f2 100644
--- a/include/linux/ipmi.h
+++ b/include/linux/ipmi.h
@@ -454,6 +454,44 @@ unsigned int ipmi_addr_length(int addr_type);
 /* Validate that the given IPMI address is valid. */
 int ipmi_validate_addr(struct ipmi_addr *addr, int len);
 
+/*
+ * How did the IPMI driver find out about the device?
+ */
+enum ipmi_addr_src {
+	SI_INVALID = 0, SI_HOTMOD, SI_HARDCODED, SI_SPMI, SI_ACPI, SI_SMBIOS,
+	SI_PCI,	SI_DEVICETREE, SI_DEFAULT
+};
+
+union ipmi_smi_info_union {
+	/*
+	 * the acpi_info element is defined for the SI_ACPI
+	 * address type
+	 */
+	struct {
+		void *acpi_handle;
+	} acpi_info;
+};
+
+struct ipmi_smi_info {
+	enum ipmi_addr_src addr_src;
+
+	/*
+	 * Base device for the interface.  Don't forget to put this when
+	 * you are done.
+	 */
+	struct device *dev;
+
+	/*
+	 * The addr_info provides more detailed info for some IPMI
+	 * devices, depending on the addr_src.  Currently only SI_ACPI
+	 * info is provided.
+	 */
+	union ipmi_smi_info_union addr_info;
+};
+
+/* This is to get the private info of ipmi_smi_t */
+extern int ipmi_get_smi_info(int if_num, struct ipmi_smi_info *data);
+
 #endif /* __KERNEL__ */
 
 
diff --git a/include/linux/ipmi_smi.h b/include/linux/ipmi_smi.h
index 4b48318..906590a 100644
--- a/include/linux/ipmi_smi.h
+++ b/include/linux/ipmi_smi.h
@@ -39,6 +39,7 @@
 #include <linux/module.h>
 #include <linux/device.h>
 #include <linux/platform_device.h>
+#include <linux/ipmi.h>
 
 /* This files describes the interface for IPMI system management interface
    drivers to bind into the IPMI message handler. */
@@ -86,6 +87,13 @@ struct ipmi_smi_handlers {
 	int (*start_processing)(void       *send_info,
 				ipmi_smi_t new_intf);
 
+	/*
+	 * Get the detailed private info of the low level interface and store
+	 * it into the structure of ipmi_smi_data. For example: the
+	 * ACPI device handle will be returned for the pnp_acpi IPMI device.
+	 */
+	int (*get_smi_info)(void *send_info, struct ipmi_smi_info *data);
+
 	/* Called to enqueue an SMI message to be sent.  This
 	   operation is not allowed to fail.  If an error occurs, it
 	   should report back the error in a received message.  It may
-- 
1.7.3.3.557.gb5c17

