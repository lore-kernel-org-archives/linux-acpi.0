From: Andy Lutomirski <luto@kernel.org>
Subject: [PATCH 02/14] wmi: Pass the acpi_device through to parse_wdg
Date: Mon, 30 Nov 2015 17:05:52 -0800
Message-ID: <857a35118767ca5d42a4f99bbeff0474b3e45238.1448931782.git.luto@kernel.org>
References: <cover.1448931782.git.luto@kernel.org>
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <cover.1448931782.git.luto@kernel.org>
In-Reply-To: <cover.1448931782.git.luto@kernel.org>
References: <cover.1448931782.git.luto@kernel.org>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Darren Hart <dvhart@infradead.org>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org, Mario Limonciello <mario_limonciello@dell.com>, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>, Andy Lutomirski <luto@kernel.org>
List-Id: linux-acpi@vger.kernel.org

Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 drivers/platform/x86/wmi.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
index a17c3d5effe4..383efb8260c7 100644
--- a/drivers/platform/x86/wmi.c
+++ b/drivers/platform/x86/wmi.c
@@ -684,7 +684,8 @@ static struct class wmi_class = {
 };
 
 static int wmi_create_device(const struct guid_block *gblock,
-			     struct wmi_block *wblock, acpi_handle handle)
+			     struct wmi_block *wblock,
+			     struct acpi_device *device)
 {
 	wblock->dev.class = &wmi_class;
 
@@ -723,7 +724,7 @@ static bool guid_already_parsed(const char *guid_string)
 /*
  * Parse the _WDG method for the GUID data blocks
  */
-static int parse_wdg(acpi_handle handle)
+static int parse_wdg(struct acpi_device *device)
 {
 	struct acpi_buffer out = {ACPI_ALLOCATE_BUFFER, NULL};
 	union acpi_object *obj;
@@ -733,7 +734,7 @@ static int parse_wdg(acpi_handle handle)
 	int retval;
 	u32 i, total;
 
-	status = acpi_evaluate_object(handle, "_WDG", NULL, &out);
+	status = acpi_evaluate_object(device->handle, "_WDG", NULL, &out);
 	if (ACPI_FAILURE(status))
 		return -ENXIO;
 
@@ -757,7 +758,7 @@ static int parse_wdg(acpi_handle handle)
 		if (!wblock)
 			return -ENOMEM;
 
-		wblock->handle = handle;
+		wblock->handle = device->handle;
 		wblock->gblock = gblock[i];
 
 		/*
@@ -767,7 +768,7 @@ static int parse_wdg(acpi_handle handle)
 		  for device creation.
 		*/
 		if (!guid_already_parsed(gblock[i].guid)) {
-			retval = wmi_create_device(&gblock[i], wblock, handle);
+			retval = wmi_create_device(&gblock[i], wblock, device);
 			if (retval) {
 				wmi_free_devices();
 				goto out_free_pointer;
@@ -884,7 +885,7 @@ static int acpi_wmi_add(struct acpi_device *device)
 		return -ENODEV;
 	}
 
-	error = parse_wdg(device->handle);
+	error = parse_wdg(device);
 	if (error) {
 		acpi_remove_address_space_handler(device->handle,
 						  ACPI_ADR_SPACE_EC,
-- 
2.5.0
