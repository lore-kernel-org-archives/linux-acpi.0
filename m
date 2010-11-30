From: yakui.zhao@intel.com
Subject: [RFC PATCH 1/4] IPMI: Add one interface to get more info of low-level IPMI device
Date: Tue, 30 Nov 2010 08:26:18 +0800
Message-ID: <1291076781-9438-2-git-send-email-yakui.zhao@intel.com>
References: <1291076781-9438-1-git-send-email-yakui.zhao@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:7352 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754776Ab0K3Ac0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 29 Nov 2010 19:32:26 -0500
In-Reply-To: <1291076781-9438-1-git-send-email-yakui.zhao@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: minyard@acm.org
Cc: openipmi-developer@lists.sourceforge.net, lenb@kernel.org, linux-acpi@vger.kernel.org, Zhao Yakui <yakui.zhao@intel.com>

From: Zhao Yakui <yakui.zhao@intel.com>

The IPMI smi_watcher will be used to catch the IPMI interface as they come or go.
In order to communicate with the correct IPMI device, it should be confirmed
 whether it is what we wanted especially on the system with multiple IPMI
devices. But the new_smi callback function of smi_watcher provides very
limited info(only the interface number and dev pointer) and there is no
detailed info about the low level interface. For example: which mechansim
registers the IPMI interface(ACPI, PCI, DMI and so on).

This is to add one interface that can get more info of low-level IPMI
device. For example: the ACPI device handle will be returned for the pnp_acpi
IPMI device.

Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
---
 drivers/char/ipmi/ipmi_msghandler.c |   31 +++++++++++++++++++++++++++++++
 drivers/char/ipmi/ipmi_si_intf.c    |   24 ++++++++++++++++++++----
 include/linux/ipmi.h                |   29 +++++++++++++++++++++++++++++
 include/linux/ipmi_smi.h            |    7 +++++++
 4 files changed, 87 insertions(+), 4 deletions(-)

diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
index 2fe72f8..a90b3ec 100644
--- a/drivers/char/ipmi/ipmi_msghandler.c
+++ b/drivers/char/ipmi/ipmi_msghandler.c
@@ -970,6 +970,37 @@ out_kfree:
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
+	rv = handlers->get_smi_info(intf->send_info, data);
+	mutex_unlock(&ipmi_interfaces_mutex);
+
+	return rv;
+}
+EXPORT_SYMBOL(ipmi_get_smi_info);
+
+void ipmi_put_smi_info(struct ipmi_smi_info *data)
+{
+	put_device(data->dev);
+}
+EXPORT_SYMBOL(ipmi_put_smi_info);
+
 static void free_user(struct kref *ref)
 {
 	ipmi_user_t user = container_of(ref, struct ipmi_user, refcount);
diff --git a/drivers/char/ipmi/ipmi_si_intf.c b/drivers/char/ipmi/ipmi_si_intf.c
index 035da9e..a41afca 100644
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
+	struct ipmi_smi_info smi_data;
 };
 
 #define smi_inc_stat(smi, stat) \
@@ -1186,6 +1184,18 @@ static int smi_start_processing(void       *send_info,
 	return 0;
 }
 
+static int get_smi_info(void *send_info, struct ipmi_smi_info *data)
+{
+	struct smi_info *new_smi = send_info;
+	struct ipmi_smi_info *smi_data = &new_smi->smi_data;
+
+	memcpy(data, smi_data, sizeof(*smi_data));
+	data->addr_src = new_smi->addr_source;
+	get_device(new_smi->dev);
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
@@ -2153,6 +2164,8 @@ static int __devinit ipmi_pnp_probe(struct pnp_dev *dev,
 		return -ENOMEM;
 
 	info->addr_source = SI_ACPI;
+	info->smi_data.addr_info.acpi_info.acpi_handle =
+				acpi_dev->handle;
 	printk(KERN_INFO PFX "probing via ACPI\n");
 
 	handle = acpi_dev->handle;
@@ -3102,6 +3115,7 @@ static int try_smi_init(struct smi_info *new_smi)
 {
 	int rv = 0;
 	int i;
+	struct ipmi_smi_info *smi_data;
 
 	printk(KERN_INFO PFX "Trying %s-specified %s state"
 	       " machine at %s address 0x%lx, slave address 0x%x,"
@@ -3263,6 +3277,8 @@ static int try_smi_init(struct smi_info *new_smi)
 	dev_info(new_smi->dev, "IPMI %s interface initialized\n",
 		 si_to_str[new_smi->si_type]);
 
+	smi_data = &new_smi->smi_data;
+	smi_data->dev = new_smi->dev;
 	return 0;
 
  out_err_stop_timer:
diff --git a/include/linux/ipmi.h b/include/linux/ipmi.h
index 65aae34..956bd41 100644
--- a/include/linux/ipmi.h
+++ b/include/linux/ipmi.h
@@ -454,6 +454,35 @@ unsigned int ipmi_addr_length(int addr_type);
 /* Validate that the given IPMI address is valid. */
 int ipmi_validate_addr(struct ipmi_addr *addr, int len);
 
+enum ipmi_addr_src {
+	SI_INVALID = 0, SI_HOTMOD, SI_HARDCODED, SI_SPMI, SI_ACPI, SI_SMBIOS,
+	SI_PCI,	SI_DEVICETREE, SI_DEFAULT
+};
+struct ipmi_smi_info {
+	enum ipmi_addr_src addr_src;
+	struct device *dev;
+	/*
+	 * The addr_info can provide more detailed info of one IPMI device.
+	 * Now only SI_ACPI info is provided. And it depends on the SI_ACPI
+	 * address type. If the info is required for other address type, please
+	 * add it.
+	 */
+	union {
+		/* the acpi_info element is defined for the SI_ACPI
+		 * address type
+		 */
+		struct {
+			void *acpi_handle;
+		} acpi_info;
+	} addr_info;
+};
+
+/* This is to get the private info of ipmi_smi_t */
+extern int ipmi_get_smi_info(int if_num, struct ipmi_smi_info *data);
+/* This is to decrease refcount of dev added in the function of
+ * ipmi_get_smi_info
+ */
+extern void ipmi_put_smi_info(struct ipmi_smi_info *data);
 #endif /* __KERNEL__ */
 
 
diff --git a/include/linux/ipmi_smi.h b/include/linux/ipmi_smi.h
index 4b48318..deabdcc 100644
--- a/include/linux/ipmi_smi.h
+++ b/include/linux/ipmi_smi.h
@@ -86,6 +86,13 @@ struct ipmi_smi_handlers {
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
1.5.4.5

