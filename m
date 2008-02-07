From: Len Brown <lenb@kernel.org>
Subject: [PATCH 099/112] ACPI: create notifier chain to get hotkey events to graphics driver
Date: Thu,  7 Feb 2008 04:35:01 -0500
Message-ID: <9ee85241fdaab358dff1d8647f20a478cfa512a1.1202376824.git.len.brown@intel.com>
References: <1202376914-21030-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga10.intel.com ([192.55.52.92]:9414 "EHLO
	fmsmga102.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756783AbYBGJg4 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Feb 2008 04:36:56 -0500
In-Reply-To: <1202376914-21030-1-git-send-email-lenb@kernel.org>
In-Reply-To: <4169c45f179e285feac6bcf25f4bd0db6b109bab.1202376823.git.len.brown@intel.com>
References: <4169c45f179e285feac6bcf25f4bd0db6b109bab.1202376823.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>, Len Brown <len.brown@intel.com>

From: Zhang Rui <rui.zhang@intel.com>

Kernel mode graphics drivers need this ACPI notifier chaine
so that they can get notified upon hotkey events.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/event.c    |   28 ++++++++++++++++++++++++++++
 include/acpi/acpi_bus.h |    3 +++
 2 files changed, 31 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/event.c b/drivers/acpi/event.c
index 5c95863..5479dc0 100644
--- a/drivers/acpi/event.c
+++ b/drivers/acpi/event.c
@@ -109,6 +109,34 @@ static const struct file_operations acpi_system_event_ops = {
 };
 #endif	/* CONFIG_ACPI_PROC_EVENT */
 
+/* ACPI notifier chain */
+BLOCKING_NOTIFIER_HEAD(acpi_chain_head);
+
+int acpi_notifier_call_chain(struct acpi_device *dev, u32 type, u32 data)
+{
+	struct acpi_bus_event event;
+
+	strcpy(event.device_class, dev->pnp.device_class);
+	strcpy(event.bus_id, dev->pnp.bus_id);
+	event.type = type;
+	event.data = data;
+	return (blocking_notifier_call_chain(&acpi_chain_head, 0, (void *)&event)
+                        == NOTIFY_BAD) ? -EINVAL : 0;
+}
+EXPORT_SYMBOL(acpi_notifier_call_chain);
+
+int register_acpi_notifier(struct notifier_block *nb)
+{
+	return blocking_notifier_chain_register(&acpi_chain_head, nb);
+}
+EXPORT_SYMBOL(register_acpi_notifier);
+
+int unregister_acpi_notifier(struct notifier_block *nb)
+{
+	return blocking_notifier_chain_unregister(&acpi_chain_head, nb);
+}
+EXPORT_SYMBOL(unregister_acpi_notifier);
+
 #ifdef CONFIG_NET
 static unsigned int acpi_event_seqnum;
 struct acpi_genl_event {
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index fb7171b..3f9f141 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -321,6 +321,9 @@ struct acpi_bus_event {
 
 extern struct kobject *acpi_kobj;
 extern int acpi_bus_generate_netlink_event(const char*, const char*, u8, int);
+extern int acpi_notifier_call_chain(struct acpi_device *, u32, u32);
+extern int register_acpi_notifier(struct notifier_block *);
+extern int unregister_acpi_notifier(struct notifier_block *);
 /*
  * External Functions
  */
-- 
1.5.4.23.gef5b9

