From: Len Brown <lenb@kernel.org>
Subject: [PATCH 33/34] hp-wmi: Fix two memleaks
Date: Thu, 24 Dec 2009 01:24:04 -0500
Message-ID: <44ef00e6482e755f36629773abc2aee83a6f53e3.1261635794.git.len.brown@intel.com>
References: <1261635845-18306-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:37630 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753526AbZLXTbI (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 24 Dec 2009 14:31:08 -0500
Received: from localhost.localdomain ([unknown] [74.104.151.18])
 by vms173001.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0KV600GDH8VGSH71@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 24 Dec 2009 13:30:56 -0600 (CST)
In-reply-to: <1261635845-18306-1-git-send-email-lenb@kernel.org>
In-reply-to: <0ad3dc3af8ba028368263b190a7a270f8d5cf5ae.1261635793.git.len.brown@intel.com>
References: <0ad3dc3af8ba028368263b190a7a270f8d5cf5ae.1261635793.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Thomas Renninger <trenn@suse.de>, Len Brown <len.brown@intel.com>

From: Thomas Renninger <trenn@suse.de>

Signed-off-by: Thomas Renninger <trenn@suse.de>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/platform/x86/hp-wmi.c |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/drivers/platform/x86/hp-wmi.c b/drivers/platform/x86/hp-wmi.c
index db10c5d..8781d8f 100644
--- a/drivers/platform/x86/hp-wmi.c
+++ b/drivers/platform/x86/hp-wmi.c
@@ -134,10 +134,15 @@ static int hp_wmi_perform_query(int query, int write, int value)
 
 	obj = output.pointer;
 
-	if (!obj || obj->type != ACPI_TYPE_BUFFER)
+	if (!obj)
 		return -EINVAL;
+	else if (obj->type != ACPI_TYPE_BUFFER) {
+		kfree(obj);
+		return -EINVAL;
+	}
 
 	bios_return = *((struct bios_return *)obj->buffer.pointer);
+	kfree(obj);
 	if (bios_return.return_code > 0)
 		return bios_return.return_code * -1;
 	else
@@ -340,10 +345,12 @@ static void hp_wmi_notify(u32 value, void *context)
 
 	if (!obj || obj->type != ACPI_TYPE_BUFFER || obj->buffer.length != 8) {
 		printk(KERN_INFO "HP WMI: Unknown response received\n");
+		kfree(obj);
 		return;
 	}
 
 	eventcode = *((u8 *) obj->buffer.pointer);
+	kfree(obj);
 	if (eventcode == 0x4)
 		eventcode = hp_wmi_perform_query(HPWMI_HOTKEY_QUERY, 0,
 						0);
-- 
1.6.0.6

