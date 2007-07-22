From: Len Brown <len.brown@intel.com>
Subject: [PATCH 73/77] ACPI: export ACPI events via acpi_mc_group multicast group
Date: Sun, 22 Jul 2007 05:14:58 -0400
Message-ID: <11850957781461-git-send-email-len.brown@intel.com>
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
 <1185095739370-git-send-email-len.brown@intel.com>
 <11850957403722-git-send-email-len.brown@intel.com>
 <11850957413607-git-send-email-len.brown@intel.com>
 <11850957432095-git-send-email-len.brown@intel.com>
 <11850957443711-git-send-email-len.brown@intel.com>
 <11850957451942-git-send-email-len.brown@intel.com>
 <11850957462109-git-send-email-len.brown@intel.com>
 <11850957471828-git-send-email-len.brown@intel.com>
 <11850957482671-git-send-email-len.brown@intel.com>
 <11850957491254-git-send-email-len.brown@intel.com>
 <11850957503243-git-send-email-len.brown@intel.com>
 <1185095751279-git-send-email-len.brown@intel.com>
 <11850957522609-git-send-email-len.brown@intel.com>
 <11850957531914-git-send-email-len.brown@intel.com>
 <11850957541879-git-send-email-len.brown@intel.com>
 <11850957552824-git-send-email-len.brown@intel.com>
 <11850957561003-git-send-email-len.brown@intel.com>
 <11850957571080-git-send-email-len.brown@intel.com>
 <11850957591101-git-send-email-len.brown@intel.com>
 <11850957601664-git-send-email-len.brown@intel.com>
 <1185095761326-git-send-email-len.brown@intel.com>
 <11850957621605-git-send-email-len.brown@intel.com>
 <11850957633613-git-send-email-len.brown@intel.com>
 <11850957641697-git-send-email-len.brown@intel.com>
 <11850957651127-git-send-email-len.brown@intel.com>
 <1185095766274-git-send-email-len.brown@intel.com>
 <1185095767879-git-send-email-len.brown@intel.com>
 <1185095768376-git-send-email-len.brown@intel.com>
 <11850957691561-git-send-email-len.brown@intel.com>
 <11850957703097-git-send-email-len.brown@intel.com>
 <11850957712166-git-send-email-len.brown@intel.com>
 <11850957721285-git-send-email-len.brown@intel.com>
 <11850957721315-git-send-email-len.brown@intel.com>
 <11850957741937-git-send-email-len.brown@intel.com>
 <1185095775978-git-send-email-len.brown@intel.com>
 <1185095776538-git-send-email-len.brown@intel.com>
 <1185095777144-git-send-email-len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:35829 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762050AbXGVJQT (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 22 Jul 2007 05:16:19 -0400
In-Reply-To: <1185095777144-git-send-email-len.brown@intel.com>
Message-Id: <9c977a453ed62396d067b75f3f272b3fb1ea3acc.1185095456.git.len.brown@intel.com>
In-Reply-To: <a1f0eff21edac1bd87e397f56c4258b9611b5a50.1185095456.git.len.brown@intel.com>
References: <a1f0eff21edac1bd87e397f56c4258b9611b5a50.1185095456.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>, Len Brown <len.brown@intel.com>

From: Zhang Rui <rui.zhang@intel.com>

This is an incremental patch for the recent genetlink
multicast changes.

Now ACPI events are exported via generic netlink multicast group.

Thanks for Johannes' help on developing this patch

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/event.c |   29 +++++++++--------------------
 1 files changed, 9 insertions(+), 20 deletions(-)

diff --git a/drivers/acpi/event.c b/drivers/acpi/event.c
index de4def9..dfa5853 100644
--- a/drivers/acpi/event.c
+++ b/drivers/acpi/event.c
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
@@ -215,7 +204,7 @@ int acpi_bus_generate_genetlink_event(struct acpi_device *device,
 	}
 
 	result =
-	    genlmsg_multicast(skb, 0, acpi_event_genl_family.id, GFP_ATOMIC);
+	    genlmsg_multicast(skb, 0, acpi_event_mcgrp.id, GFP_ATOMIC);
 	if (result)
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
 				  "Failed to send a Genetlink message!\n"));
@@ -230,8 +219,8 @@ static int acpi_event_genetlink_init(void)
 	if (result)
 		return result;
 
-	result =
-	    genl_register_ops(&acpi_event_genl_family, &acpi_event_genl_ops);
+	result = genl_register_mc_group(&acpi_event_genl_family,
+					&acpi_event_mcgrp);
 	if (result)
 		genl_unregister_family(&acpi_event_genl_family);
 
-- 
1.5.3.rc2.22.g69a9b
