From: Len Brown <len.brown@intel.com>
Subject: [PATCH 36/77] ACPI: Export events via generic netlink
Date: Sun, 22 Jul 2007 05:14:21 -0400
Message-ID: <1185095739370-git-send-email-len.brown@intel.com>
References: <11850957022956-git-send-email-len.brown@intel.com>
 <11850957033938-git-send-email-len.brown@intel.com>
 <11850957043270-git-send-email-len.brown@intel.com>
 <11850957053842-git-send-email-len.brown@intel.com>
 <11850957062754-git-send-email-len.brown@intel.com>
 <11850957073494-git-send-email-len.brown@intel.com>
 <1185095708928-git-send-email-len.brown@intel.com>
 <11850957093360-git-send-email-len.brown@intel.com>
 <11850957102641-git-send-email-len.brown@intel.com>
 <11850957111797-git-send-email-len.brown@intel.com>
 <11850957123807-git-send-email-len.brown@intel.com>
 <11850957131802-git-send-email-len.brown@intel.com>
 <1185095714699-git-send-email-len.brown@intel.com>
 <1185095715506-git-send-email-len.brown@intel.com>
 <11850957162801-git-send-email-len.brown@intel.com>
 <11850957173842-git-send-email-len.brown@intel.com>
 <11850957181201-git-send-email-len.brown@intel.com>
 <11850957192175-git-send-email-len.brown@intel.com>
 <1185095721166-git-send-email-len.brown@intel.com>
 <1185095721760-git-send-email-len.brown@intel.com>
 <11850957232745-git-send-email-len.brown@intel.com>
 <11850957242656-git-send-email-len.brown@intel.com>
 <11850957252722-git-send-email-len.brown@intel.com>
 <11850957262869-git-send-email-len.brown@intel.com>
 <11850957272369-git-send-email-len.brown@intel.com>
 <11850957282082-git-send-email-len.brown@intel.com>
 <11850957292555-git-send-email-len.brown@intel.com>
 <11850957302782-git-send-email-len.brown@intel.com>
 <11850957311269-git-send-email-len.brown@intel.com>
 <11850957323059-git-send-email-len.brown@intel.com>
 <11850957332171-git-send-email-len.brown@intel.com>
 <11850957342584-git-send-email-len.brown@intel.com>
 <11850957362476-git-send-email-len.brown@intel.com>
 <11850957361736-git-send-email-len.brown@intel.com>
 <1185095737422-git-send-email-len.brown@intel.com>
 <11850957384004-git-send-email-len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:22481 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762413AbXGVJPr (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 22 Jul 2007 05:15:47 -0400
In-Reply-To: <11850957384004-git-send-email-len.brown@intel.com>
Message-Id: <864bdfb912e372670b5b2541dac9d273a4a7722a.1185095456.git.len.brown@intel.com>
In-Reply-To: <a1f0eff21edac1bd87e397f56c4258b9611b5a50.1185095456.git.len.brown@intel.com>
References: <a1f0eff21edac1bd87e397f56c4258b9611b5a50.1185095456.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>, Len Brown <len.brown@intel.com>

From: Zhang Rui <rui.zhang@intel.com>

Upon ACPI events, send an "acpi_event" via Generic Netlink.
This is in addition to /proc/acpi/event, which remains intact for now.

Thanks to Jamal for his great help.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/bus.c      |    4 +
 drivers/acpi/event.c    |  166 +++++++++++++++++++++++++++++++++++++++++++++--
 include/acpi/acpi_bus.h |    3 +-
 3 files changed, 165 insertions(+), 8 deletions(-)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index e5084ec..6b2658c 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -292,6 +292,10 @@ int acpi_bus_generate_event(struct acpi_device *device, u8 type, int data)
 	if (!device)
 		return -EINVAL;
 
+	if (acpi_bus_generate_genetlink_event(device, type, data))
+		printk(KERN_WARNING PREFIX
+			"Failed to generate an ACPI event via genetlink!\n");
+
 	/* drop event on the floor if no one's listening */
 	if (!event_is_open)
 		return 0;
diff --git a/drivers/acpi/event.c b/drivers/acpi/event.c
index 3b23562..98627b0 100644
--- a/drivers/acpi/event.c
+++ b/drivers/acpi/event.c
@@ -11,6 +11,8 @@
 #include <linux/init.h>
 #include <linux/poll.h>
 #include <acpi/acpi_drivers.h>
+#include <net/netlink.h>
+#include <net/genetlink.h>
 
 #define _COMPONENT		ACPI_SYSTEM_COMPONENT
 ACPI_MODULE_NAME("event");
@@ -48,7 +50,6 @@ acpi_system_read_event(struct file *file, char __user * buffer, size_t count,
 	static int chars_remaining = 0;
 	static char *ptr;
 
-
 	if (!chars_remaining) {
 		memset(&event, 0, sizeof(struct acpi_bus_event));
 
@@ -106,23 +107,174 @@ static const struct file_operations acpi_system_event_ops = {
 	.poll = acpi_system_poll_event,
 };
 
+#ifdef CONFIG_NET
+unsigned int acpi_event_seqnum;
+struct acpi_genl_event {
+	acpi_device_class device_class;
+	char bus_id[15];
+	u32 type;
+	u32 data;
+};
+
+/* attributes of acpi_genl_family */
+enum {
+	ACPI_GENL_ATTR_UNSPEC,
+	ACPI_GENL_ATTR_EVENT,	/* ACPI event info needed by user space */
+	__ACPI_GENL_ATTR_MAX,
+};
+#define ACPI_GENL_ATTR_MAX (__ACPI_GENL_ATTR_MAX - 1)
+
+/* commands supported by the acpi_genl_family */
+enum {
+	ACPI_GENL_CMD_UNSPEC,
+	ACPI_GENL_CMD_EVENT,	/* kernel->user notifications for ACPI events */
+	__ACPI_GENL_CMD_MAX,
+};
+#define ACPI_GENL_CMD_MAX (__ACPI_GENL_CMD_MAX - 1)
+
+#define ACPI_GENL_NAME		"acpi_event"
+#define ACPI_GENL_VERSION	0x01
+
+static struct genl_family acpi_event_genl_family = {
+	.id = GENL_ID_GENERATE,
+	.name = ACPI_GENL_NAME,
+	.version = ACPI_GENL_VERSION,
+	.maxattr = ACPI_GENL_ATTR_MAX,
+};
+
+/* .doit: standard command callback */
+static int acpi_genl_cmd_event(struct sk_buff *skb, struct genl_info *info)
+{
+	struct acpi_genl_event *event = info->userhdr;
+
+	if (!event)
+		ACPI_DEBUG_PRINT((ACPI_DB_WARN, "ACPI event: NULL\n"));
+
+	return 0;
+}
+
+static struct genl_ops acpi_event_genl_ops = {
+	.cmd = ACPI_GENL_CMD_EVENT,
+	.doit = acpi_genl_cmd_event,
+};
+
+int acpi_bus_generate_genetlink_event(struct acpi_device *device,
+				      u8 type, int data)
+{
+	struct sk_buff *skb;
+	struct nlattr *attr;
+	struct acpi_genl_event *event;
+	void *msg_header;
+	int size;
+	int result;
+
+	/* allocate memory */
+	size = nla_total_size(sizeof(struct acpi_genl_event)) +
+	    nla_total_size(0);
+
+	skb = genlmsg_new(size, GFP_ATOMIC);
+	if (!skb)
+		return -ENOMEM;
+
+	/* add the genetlink message header */
+	msg_header = genlmsg_put(skb, 0, acpi_event_seqnum++,
+				 &acpi_event_genl_family, 0,
+				 ACPI_GENL_CMD_EVENT);
+	if (!msg_header) {
+		nlmsg_free(skb);
+		return -ENOMEM;
+	}
+
+	/* fill the data */
+	attr =
+	    nla_reserve(skb, ACPI_GENL_ATTR_EVENT,
+			sizeof(struct acpi_genl_event));
+	if (!attr) {
+		nlmsg_free(skb);
+		return -EINVAL;
+	}
+
+	event = nla_data(attr);
+	if (!event) {
+		nlmsg_free(skb);
+		return -EINVAL;
+	}
+
+	memset(event, 0, sizeof(struct acpi_genl_event));
+
+	strcpy(event->device_class, device->pnp.device_class);
+	strcpy(event->bus_id, device->dev.bus_id);
+	event->type = type;
+	event->data = data;
+
+	/* send multicast genetlink message */
+	result = genlmsg_end(skb, msg_header);
+	if (result < 0) {
+		nlmsg_free(skb);
+		return result;
+	}
+
+	result =
+	    genlmsg_multicast(skb, 0, acpi_event_genl_family.id, GFP_ATOMIC);
+	if (result)
+		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
+				  "Failed to send a Genetlink message!\n"));
+	return 0;
+}
+EXPORT_SYMBOL(acpi_bus_generate_genetlink_event);
+
+static int acpi_event_genetlink_init(void)
+{
+	int result;
+
+	result = genl_register_family(&acpi_event_genl_family);
+	if (result)
+		return result;
+
+	result =
+	    genl_register_ops(&acpi_event_genl_family, &acpi_event_genl_ops);
+	if (result)
+		genl_unregister_family(&acpi_event_genl_family);
+
+	return result;
+}
+
+#else
+int acpi_bus_generate_genetlink_event(struct acpi_device *device, u8 type,
+				      int data)
+{
+	return 0;
+}
+EXPORT_SYMBOL(acpi_bus_generate_genetlink_event);
+
+static int acpi_event_genetlink_init(void)
+{
+	return -ENODEV;
+}
+#endif
+
 static int __init acpi_event_init(void)
 {
 	struct proc_dir_entry *entry;
 	int error = 0;
 
-
 	if (acpi_disabled)
 		return 0;
 
+	/* create genetlink for acpi event */
+	error = acpi_event_genetlink_init();
+	if (error)
+		printk(KERN_WARNING PREFIX
+		       "Failed to create genetlink family for ACPI event\n");
+
 	/* 'event' [R] */
 	entry = create_proc_entry("event", S_IRUSR, acpi_root_dir);
 	if (entry)
 		entry->proc_fops = &acpi_system_event_ops;
-	else {
-		error = -ENODEV;
-	}
-	return error;
+	else
+		return -ENODEV;
+
+	return 0;
 }
 
-subsys_initcall(acpi_event_init);
+fs_initcall(acpi_event_init);
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index c6fa5e0..5e3dcf3 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -321,7 +321,8 @@ struct acpi_bus_event {
 };
 
 extern struct kset acpi_subsys;
-
+extern int acpi_bus_generate_genetlink_event(struct acpi_device *device,
+						u8 type, int data);
 /*
  * External Functions
  */
-- 
1.5.3.rc2.22.g69a9b
