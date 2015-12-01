From: Andy Lutomirski <luto@kernel.org>
Subject: [PATCH 09/14] wmi: Instantiate all devices before adding them
Date: Mon, 30 Nov 2015 17:05:59 -0800
Message-ID: <344ad68ef32ea13d2a7bb81e3ced15c4507a6cc8.1448931782.git.luto@kernel.org>
References: <cover.1448931782.git.luto@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:46818 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755107AbbLABGW (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 30 Nov 2015 20:06:22 -0500
In-Reply-To: <cover.1448931782.git.luto@kernel.org>
In-Reply-To: <cover.1448931782.git.luto@kernel.org>
References: <cover.1448931782.git.luto@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Darren Hart <dvhart@infradead.org>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org, Mario Limonciello <mario_limonciello@dell.com>, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>, Andy Lutomirski <luto@kernel.org>

At some point, we'll want to subdrivers to get references to other
devices on the same WMI bus.  This change is needed to avoid races.

This ends up simplifying the setup code and fixng some leaks, too.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 drivers/platform/x86/wmi.c | 49 +++++++++++++++++++++++++++++-----------------
 1 file changed, 31 insertions(+), 18 deletions(-)

diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
index 49be61207c4a..7d8a11a45bf9 100644
--- a/drivers/platform/x86/wmi.c
+++ b/drivers/platform/x86/wmi.c
@@ -869,7 +869,7 @@ static struct device_type wmi_type_data = {
 	.release = wmi_dev_release,
 };
 
-static int wmi_create_device(struct device *wmi_bus_dev,
+static void wmi_create_device(struct device *wmi_bus_dev,
 			     const struct guid_block *gblock,
 			     struct wmi_block *wblock,
 			     struct acpi_device *device)
@@ -923,7 +923,7 @@ static int wmi_create_device(struct device *wmi_bus_dev,
 
 	}
 
-	return device_register(&wblock->dev.dev);
+	device_initialize(&wblock->dev.dev);
 }
 
 static void wmi_free_devices(struct acpi_device *device)
@@ -934,10 +934,14 @@ static void wmi_free_devices(struct acpi_device *device)
 	list_for_each_entry_safe(wblock, next, &wmi_block_list, list) {
 		if (wblock->acpi_device == device) {
 			list_del(&wblock->list);
-			if (wblock->dev.dev.bus)
-				device_unregister(&wblock->dev.dev);
-			else
+			if (wblock->dev.dev.bus) {
+				/* Device was initialized. */
+				device_del(&wblock->dev.dev);
+				put_device(&wblock->dev.dev);
+			} else {
+				/* device_initialize was not called. */
 				kfree(wblock);
+			}
 		}
 	}
 }
@@ -972,9 +976,9 @@ static int parse_wdg(struct device *wmi_bus_dev, struct acpi_device *device)
 	struct acpi_buffer out = {ACPI_ALLOCATE_BUFFER, NULL};
 	union acpi_object *obj;
 	const struct guid_block *gblock;
-	struct wmi_block *wblock;
+	struct wmi_block *wblock, *next;
 	acpi_status status;
-	int retval;
+	int retval = 0;
 	u32 i, total;
 
 	status = acpi_evaluate_object(device->handle, "_WDG", NULL, &out);
@@ -1007,19 +1011,15 @@ static int parse_wdg(struct device *wmi_bus_dev, struct acpi_device *device)
 			continue;
 
 		wblock = kzalloc(sizeof(struct wmi_block), GFP_KERNEL);
-		if (!wblock)
-			return -ENOMEM;
+		if (!wblock) {
+			retval = -ENOMEM;
+			break;
+		}
 
 		wblock->acpi_device = device;
 		wblock->gblock = gblock[i];
 
-		retval = wmi_create_device(wmi_bus_dev, &gblock[i],
-					   wblock, device);
-		if (retval) {
-			put_device(&wblock->dev.dev);
-			wmi_free_devices(device);
-			goto out_free_pointer;
-		}
+		wmi_create_device(wmi_bus_dev, &gblock[i], wblock, device);
 
 		list_add_tail(&wblock->list, &wmi_block_list);
 
@@ -1029,11 +1029,24 @@ static int parse_wdg(struct device *wmi_bus_dev, struct acpi_device *device)
 		}
 	}
 
-	retval = 0;
-
 out_free_pointer:
 	kfree(out.pointer);
 
+	/*
+	 * Now that all of the devices are created, add them to the
+	 * device tree and probe subdrivers.
+	 */
+	list_for_each_entry_safe(wblock, next, &wmi_block_list, list) {
+		if (wblock->acpi_device == device) {
+			if (device_add(&wblock->dev.dev) != 0) {
+				dev_err(wmi_bus_dev,
+					"failed to register %pULL\n",
+					wblock->gblock.guid);
+				list_del(&wblock->list);
+			}
+		}
+	}
+
 	return retval;
 }
 
-- 
2.5.0

