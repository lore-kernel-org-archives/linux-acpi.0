From: Andy Lutomirski <luto@kernel.org>
Subject: [PATCH 06/14] wmi: Fix error handling when creating devices
Date: Mon, 30 Nov 2015 17:05:56 -0800
Message-ID: <5da108e9e36b235fff41da575658192e817c71c4.1448931782.git.luto@kernel.org>
References: <cover.1448931782.git.luto@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:46745 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755075AbbLABGR (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 30 Nov 2015 20:06:17 -0500
In-Reply-To: <cover.1448931782.git.luto@kernel.org>
In-Reply-To: <cover.1448931782.git.luto@kernel.org>
References: <cover.1448931782.git.luto@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Darren Hart <dvhart@infradead.org>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org, Mario Limonciello <mario_limonciello@dell.com>, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>, Andy Lutomirski <luto@kernel.org>

We had two memory leaks.  If guid_already_parsed returned true, we'd
leak the wmi_block.  If wmi_create_device failed, we'd leak the
device.

Simplify the logic and fix both of them.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 drivers/platform/x86/wmi.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
index 2fa9493bd35c..c181cf5ecdc6 100644
--- a/drivers/platform/x86/wmi.c
+++ b/drivers/platform/x86/wmi.c
@@ -835,6 +835,15 @@ static int parse_wdg(struct device *wmi_bus_dev, struct acpi_device *device)
 		if (debug_dump_wdg)
 			wmi_dump_wdg(&gblock[i]);
 
+		/*
+		 * Some WMI devices, like those for nVidia hooks, have a
+		 * duplicate GUID. It's not clear what we should do in this
+		 * case yet, so for now, we'll just ignore the duplicate
+		 * for device creation.
+		 */
+		if (guid_already_parsed(device, gblock[i].guid))
+			continue;
+
 		wblock = kzalloc(sizeof(struct wmi_block), GFP_KERNEL);
 		if (!wblock)
 			return -ENOMEM;
@@ -842,19 +851,12 @@ static int parse_wdg(struct device *wmi_bus_dev, struct acpi_device *device)
 		wblock->acpi_device = device;
 		wblock->gblock = gblock[i];
 
-		/*
-		  Some WMI devices, like those for nVidia hooks, have a
-		  duplicate GUID. It's not clear what we should do in this
-		  case yet, so for now, we'll just ignore the duplicate
-		  for device creation.
-		*/
-		if (!guid_already_parsed(device, gblock[i].guid)) {
-			retval = wmi_create_device(wmi_bus_dev, &gblock[i],
-						   wblock, device);
-			if (retval) {
-				wmi_free_devices(device);
-				goto out_free_pointer;
-			}
+		retval = wmi_create_device(wmi_bus_dev, &gblock[i],
+					   wblock, device);
+		if (retval) {
+			put_device(&wblock->dev.dev);
+			wmi_free_devices(device);
+			goto out_free_pointer;
 		}
 
 		list_add_tail(&wblock->list, &wmi_block_list);
-- 
2.5.0

