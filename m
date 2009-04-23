From: Len Brown <lenb@kernel.org>
Subject: [PATCH 16/29] sony-laptop: always try to unblock rfkill on load
Date: Thu, 23 Apr 2009 02:23:38 -0400
Message-ID: <84fae3158152d19c8bcf08218d32e121f9adf12b.1240467664.git.len.brown@intel.com>
References: <1240467831-32613-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:58416 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753931AbZDWGYF (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 23 Apr 2009 02:24:05 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173003.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KIJ0050UJ44B06J@vms173003.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 23 Apr 2009 01:24:05 -0500 (CDT)
In-reply-to: <1240467831-32613-1-git-send-email-lenb@kernel.org>
In-reply-to: <50a4da890102a455e5cd3dd358c38650d07178d3.1240467664.git.len.brown@intel.com>
References: <50a4da890102a455e5cd3dd358c38650d07178d3.1240467664.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Mattia Dongili <malattia@linux.it>, Matthias Welwarsky <matze@welwarsky.de>, Len Brown <len.brown@intel.com>

From: Mattia Dongili <malattia@linux.it>

This fixes an inconsistent behaviour when loading the driver with the
switch on or off. In the former case you would also need to soft unblock
the switch via the sysfs file entries to really disable rfkill, in the
latter you wouldn't.

Signed-off-by: Mattia Dongili <malattia@linux.it>
Cc: Matthias Welwarsky <matze@welwarsky.de>
Acked-by: Matthew Garrett <mjg@redhat.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/platform/x86/sony-laptop.c |   20 ++++++++++++++++----
 1 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/sony-laptop.c b/drivers/platform/x86/sony-laptop.c
index d93cff6..5529585 100644
--- a/drivers/platform/x86/sony-laptop.c
+++ b/drivers/platform/x86/sony-laptop.c
@@ -1103,8 +1103,11 @@ static int sony_nc_setup_wifi_rfkill(struct acpi_device *device)
 	err = rfkill_register(sony_wifi_rfkill);
 	if (err)
 		rfkill_free(sony_wifi_rfkill);
-	else
+	else {
 		sony_rfkill_devices[SONY_WIFI] = sony_wifi_rfkill;
+		sony_nc_rfkill_set(sony_wifi_rfkill->data,
+				RFKILL_STATE_UNBLOCKED);
+	}
 	return err;
 }
 
@@ -1125,8 +1128,11 @@ static int sony_nc_setup_bluetooth_rfkill(struct acpi_device *device)
 	err = rfkill_register(sony_bluetooth_rfkill);
 	if (err)
 		rfkill_free(sony_bluetooth_rfkill);
-	else
+	else {
 		sony_rfkill_devices[SONY_BLUETOOTH] = sony_bluetooth_rfkill;
+		sony_nc_rfkill_set(sony_bluetooth_rfkill->data,
+				RFKILL_STATE_UNBLOCKED);
+	}
 	return err;
 }
 
@@ -1146,8 +1152,11 @@ static int sony_nc_setup_wwan_rfkill(struct acpi_device *device)
 	err = rfkill_register(sony_wwan_rfkill);
 	if (err)
 		rfkill_free(sony_wwan_rfkill);
-	else
+	else {
 		sony_rfkill_devices[SONY_WWAN] = sony_wwan_rfkill;
+		sony_nc_rfkill_set(sony_wwan_rfkill->data,
+				RFKILL_STATE_UNBLOCKED);
+	}
 	return err;
 }
 
@@ -1167,8 +1176,11 @@ static int sony_nc_setup_wimax_rfkill(struct acpi_device *device)
 	err = rfkill_register(sony_wimax_rfkill);
 	if (err)
 		rfkill_free(sony_wimax_rfkill);
-	else
+	else {
 		sony_rfkill_devices[SONY_WIMAX] = sony_wimax_rfkill;
+		sony_nc_rfkill_set(sony_wimax_rfkill->data,
+				RFKILL_STATE_UNBLOCKED);
+	}
 	return err;
 }
 
-- 
1.6.0.6

