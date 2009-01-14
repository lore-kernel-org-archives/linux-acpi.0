From: Martin Lucina <mato@kotelna.sk>
Subject: [PATCH] panasonic-laptop.c: add support for optical drive power control
Date: Wed, 14 Jan 2009 19:42:28 +0100
Message-ID: <20090114184227.GC3654@dezo.moloch.sk>
References: <20090113163233.GA734@dezo.moloch.sk> <20090114060834.GN4791@prithivi.gnumonks.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from chrocht.moloch.sk ([62.176.169.44]:52247 "EHLO mail.moloch.sk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755979AbZANSmf (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 14 Jan 2009 13:42:35 -0500
Content-Disposition: inline
In-Reply-To: <20090114060834.GN4791@prithivi.gnumonks.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Harald Welte <laforge@gnumonks.org>
Cc: linux-acpi@vger.kernel.org

Add support for power control of the built in optical drive on models
with the required ACPI methods present.  Tested on Panasonic CF-W4.

Creates an interface in /sys/devices/platform/panasonic/cdpower, to
which you can write "1" to switch the drive on, "0" to switch it off
or read from to query the current state.

Signed-off-by: Martin Lucina <mato@kotelna.sk>

---

Harald, this should address all the comments in this thread.  I've
removed the DMI table and enable the code if _SB.{STAT,FBAY,CDDI} are
all present.

I've not figured out how to return an actual error from the sysfs
show/store functions so I've at least added ACPI_DEBUG_PRINT to print an
error if the relevant methods fail.

-mato

--- linux-2.6.28/drivers/misc/panasonic-laptop.c.orig	2009-01-14 19:10:33.626598152 +0100
+++ linux-2.6.28/drivers/misc/panasonic-laptop.c	2009-01-14 19:22:06.500598198 +0100
@@ -24,6 +24,9 @@
  *---------------------------------------------------------------------------
  *
  * ChangeLog:
+ *	Jan.14, 2009    Martin Lucina <mato@kotelna.sk>
+ *		-v0.96  add support for optical drive power control
+ *			via /sys/devices/platform/panasonic/cdpower
  *	Sep.23, 2008	Harald Welte <laforge@gnumonks.org>
  *		-v0.95	rename driver from drivers/acpi/pcc_acpi.c to
  *			drivers/misc/panasonic-laptop.c
@@ -127,6 +130,7 @@
 #include <acpi/acpi_bus.h>
 #include <acpi/acpi_drivers.h>
 #include <linux/input.h>
+#include <linux/platform_device.h>
 
 
 #ifndef ACPI_HOTKEY_COMPONENT
@@ -219,6 +223,7 @@ struct pcc_acpi {
 	struct acpi_device	*device;
 	struct input_dev	*input_dev;
 	struct backlight_device	*backlight;
+	struct platform_device  *platform;
 	int			keymap[KEYMAP_SIZE];
 };
 
@@ -360,6 +365,96 @@ static struct backlight_ops pcc_backligh
 	.update_status	= bl_set_status,
 };
 
+/* returns ACPI_SUCCESS if methods to control optical drive are present */
+
+static acpi_status check_optd_present(void)
+{
+	acpi_status status = AE_OK;
+	acpi_handle handle;
+
+	status = acpi_get_handle(NULL, "\\_SB.STAT", &handle);
+	if (ACPI_FAILURE(status))
+		goto out;
+	status = acpi_get_handle(NULL, "\\_SB.FBAY", &handle);
+	if (ACPI_FAILURE(status))
+		goto out;
+	status = acpi_get_handle(NULL, "\\_SB.CDDI", &handle);
+	if (ACPI_FAILURE(status))
+		goto out;
+
+out:
+	return status;
+}
+
+/* get optical driver power state */
+
+static int get_optd_power_state(void)
+{
+	acpi_status status;
+	unsigned long long state;
+	int result;
+
+	status = acpi_evaluate_integer(NULL, "\\_SB.STAT", NULL, &state);
+	if (ACPI_FAILURE(status)) {
+		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
+				  "evaluation error _SB.STAT\n"));
+		result = -EIO;
+		goto out;
+	}
+	switch (state) {
+	case 0: /* power off */
+		result = 0;
+		break;
+	case 0x0f: /* power on */
+		result = 1;
+		break;
+	default:
+		result = -EIO;
+		break;
+	}
+
+out:
+	return result;
+}
+
+/* set optical drive power state */
+
+static int set_optd_power_state(int new_state)
+{
+	int result;
+	acpi_status status;
+
+	result = get_optd_power_state();
+	if (result < 0)
+		goto out;
+	if (new_state == result)
+		goto out;
+
+	switch (new_state) {
+	case 0: /* power off */
+		status = acpi_evaluate_object(NULL, "\\_SB.CDDI", NULL, NULL);
+		if (ACPI_FAILURE(status)) {
+			ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
+					  "evaluation error _SB.CDDI\n"));
+			result = -EIO;
+		}
+		break;
+	case 1: /* power on */
+		status = acpi_evaluate_object(NULL, "\\_SB.FBAY", NULL, NULL);
+		if (ACPI_FAILURE(status)) {
+			ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
+					  "evaluation error _SB.FBAY\n"));
+			result = -EIO;
+		}
+		break;
+	default:
+		result = -EINVAL;
+		break;
+	}
+
+out:
+	return result;
+}
 
 /* sysfs user interface functions */
 
@@ -427,10 +522,29 @@ static ssize_t set_sticky(struct device 
 	return count;
 }
 
+static ssize_t show_cdpower(struct device *dev, struct device_attribute *attr,
+			    char *buf)
+{
+	return snprintf(buf, PAGE_SIZE, "%d\n", get_optd_power_state());
+}
+
+static ssize_t set_cdpower(struct device *dev, struct device_attribute *attr,
+			   const char *buf, size_t count)
+{
+	int value;
+
+	if (count) {
+		value = simple_strtoul(buf, NULL, 10);
+		set_optd_power_state(value);
+	}
+	return count;
+}
+
 static DEVICE_ATTR(numbatt, S_IRUGO, show_numbatt, NULL);
 static DEVICE_ATTR(lcdtype, S_IRUGO, show_lcdtype, NULL);
 static DEVICE_ATTR(mute, S_IRUGO, show_mute, NULL);
 static DEVICE_ATTR(sticky_key, S_IRUGO | S_IWUSR, show_sticky, set_sticky);
+static DEVICE_ATTR(cdpower, S_IRUGO | S_IWUSR, show_cdpower, set_cdpower);
 
 static struct attribute *pcc_sysfs_entries[] = {
 	&dev_attr_numbatt.attr,
@@ -691,8 +805,26 @@ static int acpi_pcc_hotkey_add(struct ac
 	if (result)
 		goto out_backlight;
 
+	/* optical drive initialization */
+	if (ACPI_SUCCESS(check_optd_present())) {
+		pcc->platform = platform_device_register_simple("panasonic",
+			-1, NULL, 0);
+		if (IS_ERR(pcc->platform)) {
+			result = PTR_ERR(pcc->platform);
+			goto out_backlight;
+		}
+		result = device_create_file(&pcc->platform->dev,
+			&dev_attr_cdpower);
+		if (result)
+			goto out_platform;
+	} else {
+		pcc->platform = NULL;
+	}
+
 	return 0;
 
+out_platform:
+	platform_device_unregister(pcc->platform);
 out_backlight:
 	backlight_device_unregister(pcc->backlight);
 out_notify:
@@ -738,6 +870,11 @@ static int acpi_pcc_hotkey_remove(struct
 	if (!device || !pcc)
 		return -EINVAL;
 
+	if (pcc->platform) {
+		device_remove_file(&pcc->platform->dev, &dev_attr_cdpower);
+		platform_device_unregister(pcc->platform);
+	}
+
 	sysfs_remove_group(&device->dev.kobj, &pcc_attr_group);
 
 	backlight_device_unregister(pcc->backlight);
