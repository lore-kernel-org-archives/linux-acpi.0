From: Corentin CHARY <corentincj@iksaif.net>
Subject: Re: [PATCH 2/4] asus-laptop add GPS support
Date: Sun, 6 May 2007 14:47:06 +0200
Message-ID: <200705061447.07015.corentincj@iksaif.net>
References: <200705061445.03504.corentincj@iksaif.net>
Reply-To: corentincj@iksaif.net
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iksaif.dns26.com ([84.246.226.15]:40212 "EHLO iksaif.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753996AbXEFMrJ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 6 May 2007 08:47:09 -0400
In-Reply-To: <200705061445.03504.corentincj@iksaif.net>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org

From: Corentin Chary <corentincj@iksaif.net>

Just adds GPS support found in R2H thanks to Sam Lin.  It will
make a "gps" file in /sys/devices/platform/asus-laptop/.

Signed-off-by: Corentin Chary <corentincj@iksaif.net>
---
 asus-laptop.c |   55 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 54 insertions(+), 1 deletion(-)

--- a/drivers/misc/asus-laptop.c	2007-05-05 09:21:19.000000000 +0200
+++ b/drivers/misc/asus-laptop.c	2007-05-05 09:27:46.000000000 +0200
@@ -30,7 +30,7 @@
  *  Eric Burghard  - LED display support for W1N
  *  Josh Green     - Light Sens support
  *  Thomas Tuttle  - His first patch for led support was very helpfull
- *
+ *  Sam Lin        - GPS support
  */
 
 #include <linux/autoconf.h>
@@ -83,6 +83,7 @@
 #define PLED_ON     0x20	//Phone LED
 #define GLED_ON     0x40	//Gaming LED
 #define LCD_ON      0x80	//LCD backlight
+#define GPS_ON      0x100       //GPS
 
 #define ASUS_LOG    ASUS_HOTK_FILE ": "
 #define ASUS_ERR    KERN_ERR    ASUS_LOG
@@ -162,6 +163,12 @@
 ASUS_HANDLE(ls_switch, ASUS_HOTK_PREFIX "ALSC");	/* Z71A Z71V */
 ASUS_HANDLE(ls_level, ASUS_HOTK_PREFIX "ALSL");	/* Z71A Z71V */
 
+/* GPS */
+/* R2H use different handle for GPS on/off */
+ASUS_HANDLE(gps_on, ASUS_HOTK_PREFIX "SDON"); /* R2H */
+ASUS_HANDLE(gps_off, ASUS_HOTK_PREFIX "SDOF"); /* R2H */
+ASUS_HANDLE(gps_status, ASUS_HOTK_PREFIX "GPST");
+
 /*
  * This is the main structure, we can use it to store anything interesting
  * about the hotk device
@@ -278,12 +285,27 @@
 	return (hotk->status & mask) ? 1 : 0;
 }
 
+static int read_gps_status(void) {
+        ulong status;
+	acpi_status rv = AE_OK;
+
+	rv = acpi_evaluate_integer(gps_status_handle, NULL, NULL, &status);
+	if (ACPI_FAILURE(rv))
+                printk(ASUS_WARNING "Error reading GPS status\n");
+	else
+                return status ? 1 : 0;
+
+        return (hotk->status & GPS_ON) ? 1 : 0;
+}
+
 /* Generic LED functions */
 static int read_status(int mask)
 {
 	/* There is a special method for both wireless devices */
 	if (mask == BT_ON || mask == WL_ON)
 		return read_wireless_status(mask);
+	else if(mask == GPS_ON)
+                return read_gps_status();
 
 	return (hotk->status & mask) ? 1 : 0;
 }
@@ -299,6 +321,10 @@
 	case GLED_ON:
 		out = (out & 0x1) + 1;
 		break;
+	case GPS_ON:
+		handle = (out) ? gps_on_handle : gps_off_handle;
+		out = 0x02;
+		break;
 	default:
 		out &= 0x1;
 		break;
@@ -667,6 +693,21 @@
 	return rv;
 }
 
+/*
+ * GPS
+ */
+static ssize_t show_gps(struct device *dev,
+			struct device_attribute *attr, char *buf)
+{
+	return sprintf(buf, "%d\n", read_status(GPS_ON));
+}
+
+static ssize_t store_gps(struct device *dev, struct device_attribute *attr,
+			 const char *buf, size_t count)
+{
+        return store_status(buf, count, NULL, GPS_ON);
+}
+
 static void asus_hotk_notify(acpi_handle handle, u32 event, void *data)
 {
 	/* TODO Find a better way to handle events count. */
@@ -715,6 +756,7 @@
 static ASUS_CREATE_DEVICE_ATTR(ledd);
 static ASUS_CREATE_DEVICE_ATTR(ls_switch);
 static ASUS_CREATE_DEVICE_ATTR(ls_level);
+static ASUS_CREATE_DEVICE_ATTR(gps);
 
 static struct attribute *asuspf_attributes[] = {
 	&dev_attr_infos.attr,
@@ -724,6 +766,7 @@
 	&dev_attr_ledd.attr,
 	&dev_attr_ls_switch.attr,
 	&dev_attr_ls_level.attr,
+	&dev_attr_gps.attr,
 	NULL
 };
 
@@ -763,6 +806,9 @@
 		ASUS_SET_DEVICE_ATTR(ls_level, 0644, show_lslvl, store_lslvl);
 		ASUS_SET_DEVICE_ATTR(ls_switch, 0644, show_lssw, store_lssw);
 	}
+
+	if(gps_status_handle && gps_on_handle && gps_off_handle)
+		ASUS_SET_DEVICE_ATTR(gps, 0644, show_gps, store_gps);
 }
 
 static int asus_handle_init(char *name, acpi_handle * handle,
@@ -893,6 +939,10 @@
 	if (ASUS_HANDLE_INIT(ls_switch))
 		ASUS_HANDLE_INIT(ls_level);
 
+	ASUS_HANDLE_INIT(gps_on);
+	ASUS_HANDLE_INIT(gps_off);
+	ASUS_HANDLE_INIT(gps_status);
+
 	kfree(model);
 
 	return AE_OK;
@@ -981,6 +1031,9 @@
 	if (ls_level_handle)
 		set_light_sens_level(hotk->light_level);
 
+	/* GPS is on by default */
+	write_status(NULL, 1, GPS_ON);
+
       end:
 	if (result) {
 		kfree(hotk->name);
