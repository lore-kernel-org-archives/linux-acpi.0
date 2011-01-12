From: Len Brown <lenb@kernel.org>
Subject: [PATCH 45/48] ACPI / PM: Check status of power resources under mutexes
Date: Wed, 12 Jan 2011 05:19:39 -0500
Message-ID: <d0515d9fec68bace144fda57a69f4268fb875209.1294827492.git.len.brown@intel.com>
References: <1294827582-4620-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173019pub.verizon.net ([206.46.173.19]:64394 "EHLO
	vms173019pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755354Ab1ALRAj (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 12 Jan 2011 12:00:39 -0500
Received: from localhost.localdomain ([unknown] [108.7.58.61])
 by vms173019.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LEX001MR5WB77F2@vms173019.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 12 Jan 2011 11:00:35 -0600 (CST)
In-reply-to: <1294827582-4620-1-git-send-email-lenb@kernel.org>
In-reply-to: <803711afdbea5c6a6dd2b46eca76097f6d50fb53.1294827492.git.len.brown@intel.com>
References: <803711afdbea5c6a6dd2b46eca76097f6d50fb53.1294827492.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <len.brown@intel.com>

From: Rafael J. Wysocki <rjw@sisk.pl>

It certainly is not a good idea to execute _ON or _OFF and _STA
for the same power resource at the same time which may happen in
some circumstances in theory.  To prevent that from happening,
read the power state of each power resource under its mutex, as
that will prevent the state from being changed at the same time.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/power.c |   33 ++++++++++++++++++++-------------
 1 files changed, 20 insertions(+), 13 deletions(-)

diff --git a/drivers/acpi/power.c b/drivers/acpi/power.c
index ac02af4..9ac2a9f 100644
--- a/drivers/acpi/power.c
+++ b/drivers/acpi/power.c
@@ -145,9 +145,8 @@ static int acpi_power_get_state(acpi_handle handle, int *state)
 
 static int acpi_power_get_list_state(struct acpi_handle_list *list, int *state)
 {
-	int result = 0, state1;
-	u32 i = 0;
-
+	int cur_state;
+	int i = 0;
 
 	if (!list || !state)
 		return -EINVAL;
@@ -155,25 +154,33 @@ static int acpi_power_get_list_state(struct acpi_handle_list *list, int *state)
 	/* The state of the list is 'on' IFF all resources are 'on'. */
 
 	for (i = 0; i < list->count; i++) {
-		/*
-		 * The state of the power resource can be obtained by
-		 * using the ACPI handle. In such case it is unnecessary to
-		 * get the Power resource first and then get its state again.
-		 */
-		result = acpi_power_get_state(list->handles[i], &state1);
+		struct acpi_power_resource *resource;
+		acpi_handle handle = list->handles[i];
+		int result;
+
+		result = acpi_power_get_context(handle, &resource);
 		if (result)
 			return result;
 
-		*state = state1;
+		mutex_lock(&resource->resource_lock);
 
-		if (*state != ACPI_POWER_RESOURCE_STATE_ON)
+		result = acpi_power_get_state(handle, &cur_state);
+
+		mutex_unlock(&resource->resource_lock);
+
+		if (result)
+			return result;
+
+		if (cur_state != ACPI_POWER_RESOURCE_STATE_ON)
 			break;
 	}
 
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Resource list is %s\n",
-			  *state ? "on" : "off"));
+			  cur_state ? "on" : "off"));
 
-	return result;
+	*state = cur_state;
+
+	return 0;
 }
 
 static int __acpi_power_on(struct acpi_power_resource *resource)
-- 
1.7.4.rc1.7.g2cf08

