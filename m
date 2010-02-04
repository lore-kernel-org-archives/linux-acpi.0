From: Matthew Garrett <mjg@redhat.com>
Subject: [PATCH] dell-laptop: Use buffer with 32-bit physical address
Date: Thu,  4 Feb 2010 17:56:54 -0500
Message-ID: <1265324214-7812-1-git-send-email-mjg@redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:40107 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755091Ab0BDW6S (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 4 Feb 2010 17:58:18 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: lenb@kernel.org, stuart_hayes@dell.com

From: Stuart Hayes <stuart_hayes@dell.com>

Calls to communicate with system firmware via a SMI (using dcdbas)
need to use a buffer that has a physical address of 4GB or less.
Currently the dell-laptop driver does not guarantee this, and when the
buffer address is higher than 4GB, the address is truncated to 32 bits
and the SMI handler writes to the wrong memory address.

Signed-off-by: Stuart Hayes <stuart_hayes@dell.com>
Acked-by: Matthew Garrett <mjg@redhat.com>
---
 drivers/platform/x86/dell-laptop.c |   89 ++++++++++++++++++++++++-----------
 1 files changed, 61 insertions(+), 28 deletions(-)

diff --git a/drivers/platform/x86/dell-laptop.c b/drivers/platform/x86/dell-laptop.c
index 3780994..08d62c9 100644
--- a/drivers/platform/x86/dell-laptop.c
+++ b/drivers/platform/x86/dell-laptop.c
@@ -22,6 +22,7 @@
 #include <linux/rfkill.h>
 #include <linux/power_supply.h>
 #include <linux/acpi.h>
+#include <linux/mm.h>
 #include "../../firmware/dcdbas.h"
 
 #define BRIGHTNESS_TOKEN 0x7d
@@ -82,6 +83,20 @@ static const struct dmi_system_id __initdata dell_device_table[] = {
 	{ }
 };
 
+static struct calling_interface_buffer *buffer;
+DEFINE_MUTEX(buffer_mutex);
+
+static void get_buffer(void)
+{
+	mutex_lock(&buffer_mutex);
+	memset(buffer, 0, sizeof(struct calling_interface_buffer));
+}
+
+static void release_buffer(void)
+{
+	mutex_unlock(&buffer_mutex);
+}
+
 static void __init parse_da_table(const struct dmi_header *dm)
 {
 	/* Final token is a terminator, so we don't want to copy it */
@@ -184,26 +199,26 @@ dell_send_request(struct calling_interface_buffer *buffer, int class,
 
 static int dell_rfkill_set(void *data, bool blocked)
 {
-	struct calling_interface_buffer buffer;
 	int disable = blocked ? 1 : 0;
 	unsigned long radio = (unsigned long)data;
 
-	memset(&buffer, 0, sizeof(struct calling_interface_buffer));
-	buffer.input[0] = (1 | (radio<<8) | (disable << 16));
-	dell_send_request(&buffer, 17, 11);
+	get_buffer();
+	buffer->input[0] = (1 | (radio<<8) | (disable << 16));
+	dell_send_request(buffer, 17, 11);
+	release_buffer();
 
 	return 0;
 }
 
 static void dell_rfkill_query(struct rfkill *rfkill, void *data)
 {
-	struct calling_interface_buffer buffer;
 	int status;
 	int bit = (unsigned long)data + 16;
 
-	memset(&buffer, 0, sizeof(struct calling_interface_buffer));
-	dell_send_request(&buffer, 17, 11);
-	status = buffer.output[1];
+	get_buffer();
+	dell_send_request(buffer, 17, 11);
+	status = buffer->output[1];
+	release_buffer();
 
 	rfkill_set_sw_state(rfkill, !!(status & BIT(bit)));
 	rfkill_set_hw_state(rfkill, !(status & BIT(16)));
@@ -298,39 +313,45 @@ static void dell_cleanup_rfkill(void)
 
 static int dell_send_intensity(struct backlight_device *bd)
 {
-	struct calling_interface_buffer buffer;
 
-	memset(&buffer, 0, sizeof(struct calling_interface_buffer));
-	buffer.input[0] = find_token_location(BRIGHTNESS_TOKEN);
-	buffer.input[1] = bd->props.brightness;
+	get_buffer();
+	buffer->input[0] = find_token_location(BRIGHTNESS_TOKEN);
+	buffer->input[1] = bd->props.brightness;
 
-	if (buffer.input[0] == -1)
+	if (buffer->input[0] == -1) {
+		release_buffer();
 		return -ENODEV;
+	}
 
 	if (power_supply_is_system_supplied() > 0)
-		dell_send_request(&buffer, 1, 2);
+		dell_send_request(buffer, 1, 2);
 	else
-		dell_send_request(&buffer, 1, 1);
+		dell_send_request(buffer, 1, 1);
 
+	release_buffer();
 	return 0;
 }
 
 static int dell_get_intensity(struct backlight_device *bd)
 {
-	struct calling_interface_buffer buffer;
+	int ret;
 
-	memset(&buffer, 0, sizeof(struct calling_interface_buffer));
-	buffer.input[0] = find_token_location(BRIGHTNESS_TOKEN);
+	get_buffer();
+	buffer->input[0] = find_token_location(BRIGHTNESS_TOKEN);
 
-	if (buffer.input[0] == -1)
+	if (buffer->input[0] == -1) {
+		release_buffer();
 		return -ENODEV;
+	}
 
 	if (power_supply_is_system_supplied() > 0)
-		dell_send_request(&buffer, 0, 2);
+		dell_send_request(buffer, 0, 2);
 	else
-		dell_send_request(&buffer, 0, 1);
+		dell_send_request(buffer, 0, 1);
 
-	return buffer.output[1];
+	ret = buffer->output[1];
+	release_buffer();
+	return ret;
 }
 
 static struct backlight_ops dell_ops = {
@@ -340,9 +361,9 @@ static struct backlight_ops dell_ops = {
 
 static int __init dell_init(void)
 {
-	struct calling_interface_buffer buffer;
 	int max_intensity = 0;
 	int ret;
+	struct page *bufferpage;
 
 	if (!dmi_check_system(dell_device_table))
 		return -ENODEV;
@@ -366,6 +387,15 @@ static int __init dell_init(void)
 	if (ret)
 		goto fail_platform_device2;
 
+	/*
+	 * Allocate buffer below 4GB for SMI data--only 32-bit physical addr
+	 * is passed to SMI handler.
+	 */
+	if (!(bufferpage = alloc_page(GFP_KERNEL | GFP_DMA32)))
+		return -ENOMEM;
+	buffer = page_address(bufferpage);
+	mutex_init(&buffer_mutex);
+
 	ret = dell_setup_rfkill();
 
 	if (ret) {
@@ -381,13 +411,14 @@ static int __init dell_init(void)
 		return 0;
 #endif
 
-	memset(&buffer, 0, sizeof(struct calling_interface_buffer));
-	buffer.input[0] = find_token_location(BRIGHTNESS_TOKEN);
+	get_buffer();
+	buffer->input[0] = find_token_location(BRIGHTNESS_TOKEN);
 
-	if (buffer.input[0] != -1) {
-		dell_send_request(&buffer, 0, 2);
-		max_intensity = buffer.output[3];
+	if (buffer->input[0] != -1) {
+		dell_send_request(buffer, 0, 2);
+		max_intensity = buffer->output[3];
 	}
+	release_buffer();
 
 	if (max_intensity) {
 		dell_backlight_device = backlight_device_register(
@@ -419,6 +450,7 @@ fail_platform_device1:
 	platform_driver_unregister(&platform_driver);
 fail_platform_driver:
 	kfree(da_tokens);
+	free_page(buffer);
 	return ret;
 }
 
@@ -426,6 +458,7 @@ static void __exit dell_exit(void)
 {
 	backlight_device_unregister(dell_backlight_device);
 	dell_cleanup_rfkill();
+	free_page(buffer);
 }
 
 module_init(dell_init);
-- 
1.6.6

