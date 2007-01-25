From: Corentin CHARY <corentincj@iksaif.net>
Subject: [patch 5/7] asus-laptop: add display switching support
Date: Thu, 25 Jan 2007 12:54:56 +0100
Message-ID: <200701251254.56798.corentincj@iksaif.net>
Reply-To: corentincj@iksaif.net
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iksaif.dns26.com ([84.246.226.15]:35262 "EHLO iksaif.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932872AbXAYLzJ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 25 Jan 2007 06:55:09 -0500
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, acpi4asus-user@lists.sourceforge.net

/sys/.../asus-laptop/display can now be used to switch displays like the old
/proc/acpi/asus/disp does

Signed-off-by: Corentin Chary <corentincj@iksaif.net>
 asus-laptop.c |   82 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 82 insertions(+)
---

diff -Naur a/drivers/misc/asus-laptop.c b/drivers/misc/asus-laptop.c
--- a/drivers/misc/asus-laptop.c	2007-01-21 15:35:01.000000000 +0100
+++ b/drivers/misc/asus-laptop.c	2007-01-21 15:35:37.000000000 +0100
@@ -125,6 +125,23 @@
 	    "\\_SB.PCI0.PX40.Q10", /* S1x */
 	    "\\Q10");  /* A2x, L2D, L3D, M2E */
 
+/* Display */
+ASUS_HANDLE(display_set, ASUS_HOTK_PREFIX "SDSP");
+ASUS_HANDLE(display_get,
+	    "\\_SB.PCI0.P0P1.VGA.GETD", /*  A6B, A6K A6R A7D F3JM L4R M6R A3G
+					    M6A M6V VX-1 V6J V6V W3Z */
+	    "\\_SB.PCI0.P0P2.VGA.GETD", /* A3E A4K, A4D A4L A6J A7J A8J Z71V M9V
+					   S5A M5A z33A W1Jc W2V */
+	    "\\_SB.PCI0.P0P3.VGA.GETD", /* A6V A6Q */
+	    "\\_SB.PCI0.P0PA.VGA.GETD", /* A6T, A6M */
+	    "\\_SB.PCI0.PCI1.VGAC.NMAP", /* L3C */
+	    "\\_SB.PCI0.VGA.GETD", /* Z96F */
+	    "\\ACTD", /* A2D */
+	    "\\ADVG", /* A4G Z71A W1N W5A W5F M2N M3N M5N M6N S1N S5N */
+	    "\\DNXT", /* P30 */
+	    "\\INFB", /* A2H D1 L2D L3D L3H L2E L5D L5C M1A M2E L4L W3V */
+	    "\\SSTE"); /* A3F A6F A3N A3L M6N W3N W6A */
+
 /*
  * This is the main structure, we can use it to store anything interesting
  * about the hotk device
@@ -489,6 +506,60 @@
 	return store_led(buf, count, bt_switch_handle, BT_ON, 0);
 }
 
+/*
+ * Display
+ */
+static void set_display(int value)
+{
+	/* no sanity check needed for now */
+	if (!write_acpi_int(display_set_handle, NULL, value, NULL))
+		printk(ASUS_WARNING "Error setting display\n");
+	return;
+}
+
+static int read_display(void)
+{
+	int value = 0;
+
+	/* In most of the case, we know how to set the display, but sometime
+	   we can't read it */
+	if(display_get_handle) {
+		if (!read_acpi_int(display_get_handle, NULL, &value, NULL))
+			printk(ASUS_WARNING "Error reading display status\n");
+	}
+
+	value &= 0x0F;		/* needed for some models, shouldn't hurt others */
+
+	return value;
+}
+/*
+ * Now, *this* one could be more user-friendly, but so far, no-one has
+ * complained. The significance of bits is the same as in store_disp()
+ */
+static ssize_t show_disp(struct device *dev,
+			 struct device_attribute *attr, char *buf)
+{
+	return sprintf(buf, "%d\n", read_display());
+}
+
+/*
+ * Experimental support for display switching. As of now: 1 should activate
+ * the LCD output, 2 should do for CRT, 4 for TV-Out and 8 for DVI.
+ * Any combination (bitwise) of these will suffice. I never actually tested 4
+ * displays hooked up simultaneously, so be warned. See the acpi4asus README
+ * for more info.
+ */
+static ssize_t store_disp(struct device *dev, struct device_attribute *attr,
+			  const char *buf, size_t count)
+{
+	int rv, value;
+
+	rv = parse_arg(buf, count, &value);
+	if (rv > 0)
+		set_display(value);
+	return rv;
+}
+
 static void asus_hotk_notify(acpi_handle handle, u32 event, void *data)
 {
 	/* TODO Find a better way to handle events count. */
@@ -533,11 +604,13 @@
 static ASUS_CREATE_DEVICE_ATTR(infos);
 static ASUS_CREATE_DEVICE_ATTR(wlan);
 static ASUS_CREATE_DEVICE_ATTR(bluetooth);
+static ASUS_CREATE_DEVICE_ATTR(display);
 
 static struct attribute *asuspf_attributes[] = {
         &dev_attr_infos.attr,
         &dev_attr_wlan.attr,
         &dev_attr_bluetooth.attr,
+        &dev_attr_display.attr,
         NULL
 };
 
@@ -565,6 +638,12 @@
 	if (bt_switch_handle)
 		ASUS_SET_DEVICE_ATTR(bluetooth, 0644,
 				     show_bluetooth, store_bluetooth);
+
+	if (display_set_handle && display_get_handle)
+		ASUS_SET_DEVICE_ATTR(display, 0644, show_disp, store_disp);
+	else if(display_set_handle)
+		ASUS_SET_DEVICE_ATTR(display, 0200, NULL, store_disp);
+
 }
 
 static int asus_handle_init(char *name, acpi_handle *handle,
@@ -681,6 +760,9 @@
 
 	ASUS_HANDLE_INIT(lcd_switch);
 
+	ASUS_HANDLE_INIT(display_set);
+	ASUS_HANDLE_INIT(display_get);
+
 	kfree(model);
 
 	return AE_OK;

-- 
CHARY 'Iksaif' Corentin
http://xf.iksaif.net
