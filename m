From: malattia@linux.it
Subject: [PATCH 4/11] Add backlight support to the sony_acpi
Date: Sun,  7 Jan 2007 18:54:36 +0100
Message-ID: <11681924832264-git-send-email-malattia@linux.it>
References: <1168192483500-git-send-email-malattia@linux.it> <11681924832840-git-send-email-malattia@linux.it> <1168192483207-git-send-email-malattia@linux.it> <11681924833947-git-send-email-malattia@linux.it>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from aa013msr.fastwebnet.it ([85.18.95.73]:56874 "EHLO
	aa013msr.fastwebnet.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932629AbXAGRzU (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 7 Jan 2007 12:55:20 -0500
In-Reply-To: <11681924833947-git-send-email-malattia@linux.it>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, Alessandro Guido <alessandro.guido@gmail.com>

From: Alessandro Guido <alessandro.guido@gmail.com>

Make the sony_acpi use the backlight subsystem to adjust brightness value
instead of using the /proc/sony/brightness file.  (Other settings will
still have a /proc/sony/...  entry)

Signed-off-by: Alessandro Guido <alessandro.guido@gmail.com>
Cc: Stelian Pop <stelian@popies.net>
Cc: Richard Purdie <rpurdie@rpsys.net>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Mattia Dongili <malattia@linux.it>
---
 drivers/acpi/Kconfig     |    1 +
 drivers/acpi/sony_acpi.c |   59 ++++++++++++++++++++++++++++++++++++---------
 2 files changed, 48 insertions(+), 12 deletions(-)

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index e064482..cbd8727 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -264,6 +264,7 @@ config ACPI_TOSHIBA
 config ACPI_SONY
 	tristate "Sony Laptop Extras"
 	depends on X86 && ACPI
+	select BACKLIGHT_CLASS_DEVICE
 	default m
 	  ---help---
 	  This mini-driver drives the ACPI SNC device present in the
diff --git a/drivers/acpi/sony_acpi.c b/drivers/acpi/sony_acpi.c
index f323c2c..d509468 100644
--- a/drivers/acpi/sony_acpi.c
+++ b/drivers/acpi/sony_acpi.c
@@ -27,13 +27,19 @@
 #include <linux/moduleparam.h>
 #include <linux/init.h>
 #include <linux/types.h>
+#include <linux/backlight.h>
+#include <linux/err.h>
 #include <acpi/acpi_drivers.h>
 #include <acpi/acpi_bus.h>
 #include <asm/uaccess.h>
 
 #define ACPI_SNC_CLASS		"sony"
 #define ACPI_SNC_HID		"SNY5001"
-#define ACPI_SNC_DRIVER_NAME	"ACPI Sony Notebook Control Driver v0.2"
+#define ACPI_SNC_DRIVER_NAME	"ACPI Sony Notebook Control Driver v0.3"
+
+/* the device uses 1-based values, while the backlight subsystem uses
+   0-based values */
+#define SONY_MAX_BRIGHTNESS	8
 
 #define LOG_PFX			KERN_WARNING "sony_acpi: "
 
@@ -49,6 +55,16 @@ MODULE_PARM_DESC(debug, "set this to 1 (and RTFM) if you want to help "
 static acpi_handle sony_acpi_handle;
 static struct proc_dir_entry *sony_acpi_dir;
 
+static int sony_backlight_update_status(struct backlight_device *bd);
+static int sony_backlight_get_brightness(struct backlight_device *bd);
+static struct backlight_device *sony_backlight_device;
+static struct backlight_properties sony_backlight_properties = {
+	.owner		= THIS_MODULE,
+	.update_status	= sony_backlight_update_status,
+	.get_brightness	= sony_backlight_get_brightness,
+	.max_brightness	= SONY_MAX_BRIGHTNESS - 1,
+};
+
 static struct sony_acpi_value {
 	char			*name;	 /* name of the entry */
 	struct proc_dir_entry 	*proc;	 /* /proc entry */
@@ -61,19 +77,11 @@ static struct sony_acpi_value {
 	int			debug;	 /* active only in debug mode ? */
 } sony_acpi_values[] = {
 	{
-		.name		= "brightness",
-		.acpiget	= "GBRT",
-		.acpiset	= "SBRT",
-		.min		= 1,
-		.max		= 8,
-		.debug		= 0,
-	},
-	{
 		.name		= "brightness_default",
 		.acpiget	= "GPBR",
 		.acpiset	= "SPBR",
 		.min		= 1,
-		.max		= 8,
+		.max		= SONY_MAX_BRIGHTNESS,
 		.debug		= 0,
 	},
 	{
@@ -276,6 +284,7 @@ static int sony_acpi_add(struct acpi_device *device)
 {
 	acpi_status status;
 	int result;
+	acpi_handle handle;
 	struct sony_acpi_value *item;
 
 	sony_acpi_handle = device->handle;
@@ -303,9 +312,15 @@ static int sony_acpi_add(struct acpi_device *device)
 		}
 	}
 
-	for (item = sony_acpi_values; item->name; ++item) {
-		acpi_handle handle;
+	if (ACPI_SUCCESS(acpi_get_handle(sony_acpi_handle, "GBRT", &handle))) {
+		sony_backlight_device = backlight_device_register("sony", NULL,
+					&sony_backlight_properties);
+	        if (IS_ERR(sony_backlight_device)) {
+        	        printk(LOG_PFX "unable to register backlight device\n");
+		}
+	}
 
+	for (item = sony_acpi_values; item->name; ++item) {
 		if (!debug && item->debug)
 			continue;
 
@@ -358,6 +373,9 @@ static int sony_acpi_remove(struct acpi_device *device, int type)
 	acpi_status status;
 	struct sony_acpi_value *item;
 
+	if (sony_backlight_device)
+		backlight_device_unregister(sony_backlight_device);
+
 	if (debug) {
 		status = acpi_remove_notify_handler(sony_acpi_handle,
 						    ACPI_DEVICE_NOTIFY,
@@ -375,6 +393,23 @@ static int sony_acpi_remove(struct acpi_device *device, int type)
 	return 0;
 }
 
+static int sony_backlight_update_status(struct backlight_device *bd)
+{
+	return acpi_callsetfunc(sony_acpi_handle, "SBRT",
+				bd->props->brightness + 1,
+				NULL);
+}
+
+static int sony_backlight_get_brightness(struct backlight_device *bd)
+{
+	int value;
+
+	if (acpi_callgetfunc(sony_acpi_handle, "GBRT", &value))
+		return 0;
+	/* brightness levels are 1-based, while backlight ones are 0-based */
+	return value - 1;
+}
+
 static struct acpi_driver sony_acpi_driver = {
 	.name	= ACPI_SNC_DRIVER_NAME,
 	.class	= ACPI_SNC_CLASS,
-- 
1.4.4.2

