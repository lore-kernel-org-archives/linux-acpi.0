From: Len Brown <lenb@kernel.org>
Subject: [PATCH 22/34] sony-laptop: rfkill support for newer models
Date: Thu, 24 Dec 2009 01:23:53 -0500
Message-ID: <d5a664a311c1957a75bec1808cae0f10d606c378.1261635793.git.len.brown@intel.com>
References: <1261635845-18306-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:37630 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755439AbZLXTbT (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 24 Dec 2009 14:31:19 -0500
Received: from localhost.localdomain ([unknown] [74.104.151.18])
 by vms173001.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0KV600GDH8VGSH71@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 24 Dec 2009 13:31:00 -0600 (CST)
In-reply-to: <1261635845-18306-1-git-send-email-lenb@kernel.org>
In-reply-to: <0ad3dc3af8ba028368263b190a7a270f8d5cf5ae.1261635793.git.len.brown@intel.com>
References: <0ad3dc3af8ba028368263b190a7a270f8d5cf5ae.1261635793.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Mattia Dongili <malattia@linux.it>, Len Brown <len.brown@intel.com>

From: Mattia Dongili <malattia@linux.it>

Vaio Type X and possibly other new models use F135 as the radio
frequency controlling function attached to the SNC device. In the
indexed table this corresponds to 0x0135 (surpise!).

Signed-off-by: Mattia Dongili <malattia@linux.it>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/platform/x86/sony-laptop.c |   22 ++++++++++++++--------
 1 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/platform/x86/sony-laptop.c b/drivers/platform/x86/sony-laptop.c
index 9710f70..1144686 100644
--- a/drivers/platform/x86/sony-laptop.c
+++ b/drivers/platform/x86/sony-laptop.c
@@ -131,6 +131,7 @@ enum sony_nc_rfkill {
 	N_SONY_RFKILL,
 };
 
+static int sony_rfkill_handle;
 static struct rfkill *sony_rfkill_devices[N_SONY_RFKILL];
 static int sony_rfkill_address[N_SONY_RFKILL] = {0x300, 0x500, 0x700, 0x900};
 static void sony_nc_rfkill_update(void);
@@ -965,7 +966,7 @@ static void sony_nc_notify(struct acpi_device *device, u32 event)
 				else
 					sony_laptop_report_input_event(ev);
 			}
-		} else if (sony_find_snc_handle(0x124) == ev) {
+		} else if (sony_find_snc_handle(sony_rfkill_handle) == ev) {
 			sony_nc_rfkill_update();
 			return;
 		}
@@ -1071,7 +1072,7 @@ static int sony_nc_rfkill_set(void *data, bool blocked)
 	if (!blocked)
 		argument |= 0xff0000;
 
-	return sony_call_snc_handle(0x124, argument, &result);
+	return sony_call_snc_handle(sony_rfkill_handle, argument, &result);
 }
 
 static const struct rfkill_ops sony_rfkill_ops = {
@@ -1114,7 +1115,7 @@ static int sony_nc_setup_rfkill(struct acpi_device *device,
 	if (!rfk)
 		return -ENOMEM;
 
-	sony_call_snc_handle(0x124, 0x200, &result);
+	sony_call_snc_handle(sony_rfkill_handle, 0x200, &result);
 	hwblock = !(result & 0x1);
 	rfkill_set_hw_state(rfk, hwblock);
 
@@ -1133,7 +1134,7 @@ static void sony_nc_rfkill_update()
 	int result;
 	bool hwblock;
 
-	sony_call_snc_handle(0x124, 0x200, &result);
+	sony_call_snc_handle(sony_rfkill_handle, 0x200, &result);
 	hwblock = !(result & 0x1);
 
 	for (i = 0; i < N_SONY_RFKILL; i++) {
@@ -1149,7 +1150,7 @@ static void sony_nc_rfkill_update()
 			continue;
 		}
 
-		sony_call_snc_handle(0x124, argument, &result);
+		sony_call_snc_handle(sony_rfkill_handle, argument, &result);
 		rfkill_set_states(sony_rfkill_devices[i],
 				  !(result & 0xf), false);
 	}
@@ -1159,10 +1160,15 @@ static int sony_nc_rfkill_setup(struct acpi_device *device)
 {
 	int result, ret;
 
-	if (sony_find_snc_handle(0x124) == -1)
-		return -1;
+	if (sony_find_snc_handle(0x124) == -1) {
+		if (sony_find_snc_handle(0x135) == -1)
+			return -1;
+		else
+			sony_rfkill_handle = 0x135;
+	} else
+		sony_rfkill_handle = 0x124;
 
-	ret = sony_call_snc_handle(0x124, 0xb00, &result);
+	ret = sony_call_snc_handle(sony_rfkill_handle, 0xb00, &result);
 	if (ret) {
 		printk(KERN_INFO DRV_PFX
 		       "Unable to enumerate rfkill devices: %x\n", ret);
-- 
1.6.0.6

