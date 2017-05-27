From: Darren Hart <dvhart@infradead.org>
Subject: [PATCH 02/16] platform/x86: wmi: Pass the acpi_device through to parse_wdg
Date: Fri, 26 May 2017 22:31:16 -0700
Message-ID: <4f0f31a62d3f91fa38fc5762cb9340e85c8fb124.1495862272.git.dvhart@infradead.org>
References: <cover.1495862272.git.dvhart@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:55348 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750744AbdE0Fbk (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 27 May 2017 01:31:40 -0400
In-Reply-To: <cover.1495862272.git.dvhart@infradead.org>
In-Reply-To: <cover.1495862272.git.dvhart@infradead.org>
References: <cover.1495862272.git.dvhart@infradead.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: platform-driver-x86@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Andy Lutomirski <luto@amacapital.net>, Mario Limonciello <mario_limonciello@dell.com>, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>, Rafael Wysocki <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Darren Hart <dvhart@infradead.org>

From: Andy Lutomirski <luto@kernel.org>

We will need the device to convert to a bus architecture and bind WMI to
the platform device.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Mario Limonciello <mario_limonciello@dell.com>
Cc: Pali Rohár <pali.rohar@gmail.com>
Cc: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linux-kernel@vger.kernel.org
Cc: platform-driver-x86@vger.kernel.org
Cc: linux-acpi@vger.kernel.org
Signed-off-by: Darren Hart (VMware) <dvhart@infradead.org>
---
 drivers/platform/x86/wmi.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
index 0043581..c6e11b5 100644
--- a/drivers/platform/x86/wmi.c
+++ b/drivers/platform/x86/wmi.c
@@ -606,7 +606,8 @@ static struct class wmi_class = {
 };
 
 static int wmi_create_device(const struct guid_block *gblock,
-			     struct wmi_block *wblock, acpi_handle handle)
+			     struct wmi_block *wblock,
+			     struct acpi_device *device)
 {
 	wblock->dev.class = &wmi_class;
 
@@ -645,7 +646,7 @@ static bool guid_already_parsed(const char *guid_string)
 /*
  * Parse the _WDG method for the GUID data blocks
  */
-static int parse_wdg(acpi_handle handle)
+static int parse_wdg(struct acpi_device *device)
 {
 	struct acpi_buffer out = {ACPI_ALLOCATE_BUFFER, NULL};
 	union acpi_object *obj;
@@ -655,7 +656,7 @@ static int parse_wdg(acpi_handle handle)
 	int retval;
 	u32 i, total;
 
-	status = acpi_evaluate_object(handle, "_WDG", NULL, &out);
+	status = acpi_evaluate_object(device->handle, "_WDG", NULL, &out);
 	if (ACPI_FAILURE(status))
 		return -ENXIO;
 
@@ -679,7 +680,7 @@ static int parse_wdg(acpi_handle handle)
 		if (!wblock)
 			return -ENOMEM;
 
-		wblock->handle = handle;
+		wblock->handle = device->handle;
 		wblock->gblock = gblock[i];
 
 		/*
@@ -689,7 +690,7 @@ static int parse_wdg(acpi_handle handle)
 		  for device creation.
 		*/
 		if (!guid_already_parsed(gblock[i].guid)) {
-			retval = wmi_create_device(&gblock[i], wblock, handle);
+			retval = wmi_create_device(&gblock[i], wblock, device);
 			if (retval) {
 				wmi_free_devices();
 				goto out_free_pointer;
@@ -806,7 +807,7 @@ static int acpi_wmi_add(struct acpi_device *device)
 		return -ENODEV;
 	}
 
-	error = parse_wdg(device->handle);
+	error = parse_wdg(device);
 	if (error) {
 		acpi_remove_address_space_handler(device->handle,
 						  ACPI_ADR_SPACE_EC,
-- 
2.9.4

