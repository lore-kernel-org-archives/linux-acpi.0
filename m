From: Len Brown <lenb@kernel.org>
Subject: [PATCH 10/14] wmi: check find_guid() return value to prevent oops
Date: Wed, 30 Dec 2009 02:36:33 -0500
Message-ID: <1773062dc10fa90d9a4271fa15d1a531b1f6e6de.1262158495.git.len.brown@intel.com>
References: <1262158597-9597-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:64677 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751271AbZL3X1I (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 30 Dec 2009 18:27:08 -0500
Received: from localhost.localdomain ([unknown] [74.104.151.18])
 by vms173001.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0KVH007CENT0HQT5@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 30 Dec 2009 17:27:04 -0600 (CST)
In-reply-to: <1262158597-9597-1-git-send-email-lenb@kernel.org>
In-reply-to: <51b0f1c2b8c32ee44ff01ef74599a1f17e4fc565.1262158495.git.len.brown@intel.com>
References: <51b0f1c2b8c32ee44ff01ef74599a1f17e4fc565.1262158495.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Paul Rolland <rol@as2917.net>, Len Brown <len.brown@intel.com>

From: Paul Rolland <rol@as2917.net>

Signed-off-by: Paul Rolland <rol@as2917.net>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/platform/x86/wmi.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
index 9f93d6c..cc9ad74 100644
--- a/drivers/platform/x86/wmi.c
+++ b/drivers/platform/x86/wmi.c
@@ -492,8 +492,7 @@ wmi_notify_handler handler, void *data)
 	if (!guid || !handler)
 		return AE_BAD_PARAMETER;
 
-	find_guid(guid, &block);
-	if (!block)
+	if (!find_guid(guid, &block))
 		return AE_NOT_EXIST;
 
 	if (block->handler)
@@ -521,8 +520,7 @@ acpi_status wmi_remove_notify_handler(const char *guid)
 	if (!guid)
 		return AE_BAD_PARAMETER;
 
-	find_guid(guid, &block);
-	if (!block)
+	if (!find_guid(guid, &block))
 		return AE_NOT_EXIST;
 
 	if (!block->handler)
-- 
1.6.0.6

