From: Corentin CHARY <corentincj@iksaif.net>
Subject: [PATCH 4/4] asus-laptop version bump and lindent
Date: Sun, 6 May 2007 14:48:22 +0200
Message-ID: <200705061448.22235.corentincj@iksaif.net>
References: <200705061445.03504.corentincj@iksaif.net>
Reply-To: corentincj@iksaif.net
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iksaif.dns26.com ([84.246.226.15]:39766 "EHLO iksaif.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933622AbXEFMsY (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 6 May 2007 08:48:24 -0400
In-Reply-To: <200705061445.03504.corentincj@iksaif.net>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org

From: Corentin Chary <corentincj@iksaif.net>

Version bump, lindent, etc ..

Signed-off-by: Corentin Chary <corentincj@iksaif.net>
---
 asus-laptop.c |   29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

--- a/drivers/misc/asus-laptop.c	2007-05-05 09:33:12.000000000 +0200
+++ b/drivers/misc/asus-laptop.c	2007-05-05 09:33:32.000000000 +0200
@@ -48,7 +48,7 @@
 #include <acpi/acpi_bus.h>
 #include <asm/uaccess.h>
 
-#define ASUS_LAPTOP_VERSION "0.41"
+#define ASUS_LAPTOP_VERSION "0.42"
 
 #define ASUS_HOTK_NAME          "Asus Laptop Support"
 #define ASUS_HOTK_CLASS         "hotkey"
@@ -83,7 +83,7 @@
 #define PLED_ON     0x20	//Phone LED
 #define GLED_ON     0x40	//Gaming LED
 #define LCD_ON      0x80	//LCD backlight
-#define GPS_ON      0x100       //GPS
+#define GPS_ON      0x100	//GPS
 
 #define ASUS_LOG    ASUS_HOTK_FILE ": "
 #define ASUS_ERR    KERN_ERR    ASUS_LOG
@@ -149,7 +149,7 @@
 ASUS_HANDLE(display_get, "\\_SB.PCI0.P0P1.VGA.GETD",	/*  A6B, A6K A6R A7D F3JM L4R M6R A3G
 							   M6A M6V VX-1 V6J V6V W3Z */
 	    "\\_SB.PCI0.P0P2.VGA.GETD",	/* A3E A4K, A4D A4L A6J A7J A8J Z71V M9V
-					   S5A M5A z33A W1Jc W2V */
+					   S5A M5A z33A W1Jc W2V G1 */
 	    "\\_SB.PCI0.P0P3.VGA.GETD",	/* A6V A6Q */
 	    "\\_SB.PCI0.P0PA.VGA.GETD",	/* A6T, A6M */
 	    "\\_SB.PCI0.PCI1.VGAC.NMAP",	/* L3C */
@@ -165,8 +165,8 @@
 
 /* GPS */
 /* R2H use different handle for GPS on/off */
-ASUS_HANDLE(gps_on, ASUS_HOTK_PREFIX "SDON"); /* R2H */
-ASUS_HANDLE(gps_off, ASUS_HOTK_PREFIX "SDOF"); /* R2H */
+ASUS_HANDLE(gps_on, ASUS_HOTK_PREFIX "SDON");	/* R2H */
+ASUS_HANDLE(gps_off, ASUS_HOTK_PREFIX "SDOF");	/* R2H */
 ASUS_HANDLE(gps_status, ASUS_HOTK_PREFIX "GPST");
 
 /*
@@ -285,17 +285,18 @@
 	return (hotk->status & mask) ? 1 : 0;
 }
 
-static int read_gps_status(void) {
-        ulong status;
+static int read_gps_status(void)
+{
+	ulong status;
 	acpi_status rv = AE_OK;
 
 	rv = acpi_evaluate_integer(gps_status_handle, NULL, NULL, &status);
 	if (ACPI_FAILURE(rv))
-                printk(ASUS_WARNING "Error reading GPS status\n");
+		printk(ASUS_WARNING "Error reading GPS status\n");
 	else
-                return status ? 1 : 0;
+		return status ? 1 : 0;
 
-        return (hotk->status & GPS_ON) ? 1 : 0;
+	return (hotk->status & GPS_ON) ? 1 : 0;
 }
 
 /* Generic LED functions */
@@ -304,8 +305,8 @@
 	/* There is a special method for both wireless devices */
 	if (mask == BT_ON || mask == WL_ON)
 		return read_wireless_status(mask);
-	else if(mask == GPS_ON)
-                return read_gps_status();
+	else if (mask == GPS_ON)
+		return read_gps_status();
 
 	return (hotk->status & mask) ? 1 : 0;
 }
@@ -705,7 +706,7 @@
 static ssize_t store_gps(struct device *dev, struct device_attribute *attr,
 			 const char *buf, size_t count)
 {
-        return store_status(buf, count, NULL, GPS_ON);
+	return store_status(buf, count, NULL, GPS_ON);
 }
 
 static void asus_hotk_notify(acpi_handle handle, u32 event, void *data)
@@ -807,7 +808,7 @@
 		ASUS_SET_DEVICE_ATTR(ls_switch, 0644, show_lssw, store_lssw);
 	}
 
-	if(gps_status_handle && gps_on_handle && gps_off_handle)
+	if (gps_status_handle && gps_on_handle && gps_off_handle)
 		ASUS_SET_DEVICE_ATTR(gps, 0644, show_gps, store_gps);
 }
 
