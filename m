From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH] ACPI: export ACPI events via acpi_mc_group multicast group
Date: Fri, 20 Jul 2007 16:41:14 +0800
Message-ID: <1184920874.5547.21.camel@rzhang1-laptop>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:30359 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751595AbXGTIlW (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 20 Jul 2007 04:41:22 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: lenb@kernel.org, johannes@sipsolutions.net, hadi@cyberus.ca

This is an incremental patch for the recent genetlink
multicast changes.

Now ACPI events are exported via generic netlink multicast group.

Attachment is an refreshed user space demo "acpi_genl"
that receives genetlink multicast messages from acpi_mc_group.

Thanks for Johannes' help on developing this patch and
the user space demo.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/acpi/event.c |   29 +++++++++--------------------
 1 file changed, 9 insertions(+), 20 deletions(-)

Index: linux-2.6.22/drivers/acpi/event.c
===================================================================
--- linux-2.6.22.orig/drivers/acpi/event.c
+++ linux-2.6.22/drivers/acpi/event.c
@@ -132,30 +132,19 @@ enum {
 };
 #define ACPI_GENL_CMD_MAX (__ACPI_GENL_CMD_MAX - 1)
 
-#define ACPI_GENL_NAME		"acpi_event"
-#define ACPI_GENL_VERSION	0x01
+#define ACPI_GENL_FAMILY_NAME		"acpi_event"
+#define ACPI_GENL_VERSION		0x01
+#define ACPI_GENL_MCAST_GROUP_NAME 	"acpi_mc_group"
 
 static struct genl_family acpi_event_genl_family = {
 	.id = GENL_ID_GENERATE,
-	.name = ACPI_GENL_NAME,
+	.name = ACPI_GENL_FAMILY_NAME,
 	.version = ACPI_GENL_VERSION,
 	.maxattr = ACPI_GENL_ATTR_MAX,
 };
 
-/* .doit: standard command callback */
-static int acpi_genl_cmd_event(struct sk_buff *skb, struct genl_info *info)
-{
-	struct acpi_genl_event *event = info->userhdr;
-
-	if (!event)
-		ACPI_DEBUG_PRINT((ACPI_DB_WARN, "ACPI event: NULL\n"));
-
-	return 0;
-}
-
-static struct genl_ops acpi_event_genl_ops = {
-	.cmd = ACPI_GENL_CMD_EVENT,
-	.doit = acpi_genl_cmd_event,
+static struct genl_multicast_group acpi_event_mcgrp = {
+	.name = ACPI_GENL_MCAST_GROUP_NAME,
 };
 
 int acpi_bus_generate_genetlink_event(struct acpi_device *device,
@@ -215,7 +204,7 @@ int acpi_bus_generate_genetlink_event(st
 	}
 
 	result =
-	    genlmsg_multicast(skb, 0, acpi_event_genl_family.id, GFP_ATOMIC);
+	    genlmsg_multicast(skb, 0, acpi_event_mcgrp.id, GFP_ATOMIC);
 	if (result)
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
 				  "Failed to send a Genetlink message!\n"));
@@ -230,8 +219,8 @@ static int acpi_event_genetlink_init(voi
 	if (result)
 		return result;
 
-	result =
-	    genl_register_ops(&acpi_event_genl_family, &acpi_event_genl_ops);
+	result = genl_register_mc_group(&acpi_event_genl_family,
+					&acpi_event_mcgrp);
 	if (result)
 		genl_unregister_family(&acpi_event_genl_family);
 
