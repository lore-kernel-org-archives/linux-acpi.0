From: Mattia Dongili <malattia@linux.it>
Subject: [PATCH 6/6] sony-laptop: always try to unblock rfkill on load
Date: Sun, 12 Apr 2009 20:26:31 +0900
Message-ID: <1239535591-15514-7-git-send-email-malattia@linux.it>
References: <1239535591-15514-1-git-send-email-malattia@linux.it>
 <1239535591-15514-2-git-send-email-malattia@linux.it>
 <1239535591-15514-3-git-send-email-malattia@linux.it>
 <1239535591-15514-4-git-send-email-malattia@linux.it>
 <1239535591-15514-5-git-send-email-malattia@linux.it>
 <1239535591-15514-6-git-send-email-malattia@linux.it>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from static-220-247-10-204.b-man.svips.gol.ne.jp ([220.247.10.204]:41444
	"EHLO smtp.kamineko.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760072AbZDLL0f (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 12 Apr 2009 07:26:35 -0400
In-Reply-To: <1239535591-15514-6-git-send-email-malattia@linux.it>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Mattia Dongili <malattia@linux.it>, Matthias Welwarsky <matze@welwarsky.de>, Matthew Garrett <mjg59@srcf.ucam.org>

This fixes an inconsistent behaviour when loading the driver with the
switch on or off. In the former case you would also need to soft unblock
the switch via the sysfs file entries to really disable rfkill, in the
latter you wouldn't.

Signed-off-by: Mattia Dongili <malattia@linux.it>
Cc: Matthias Welwarsky <matze@welwarsky.de>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>
---
 drivers/platform/x86/sony-laptop.c |   20 ++++++++++++++++----
 1 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/sony-laptop.c b/drivers/platform/x86/sony-laptop.c
index 419873a..9c0ce73 100644
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
1.6.2.2

