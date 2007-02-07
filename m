From: Len Brown <lenb@kernel.org>
Subject: [PATCH 34/140] asus-laptop: add display switching support
Date: Wed,  7 Feb 2007 13:50:48 -0500
Message-ID: <11708744203492-git-send-email-lenb@kernel.org>
References: <11708743541314-git-send-email-lenb@kernel.org> <11708743561383-git-send-email-lenb@kernel.org> <117087435785-git-send-email-lenb@kernel.org> <11708743582090-git-send-email-lenb@kernel.org> <11708743611662-git-send-email-lenb@kernel.org> <11708743653073-git-send-email-lenb@kernel.org> <11708743674006-git-send-email-lenb@kernel.org> <11708743693386-git-send-email-lenb@kernel.org> <11708743702194-git-send-email-lenb@kernel.org> <11708743723353-git-send-email-lenb@kernel.org> <11708743783727-git-send-email-lenb@kernel.org> <11708743802558-git-send-email-lenb@kernel.org> <11708743821259-git-send-email-lenb@kernel.org> <11708743853573-git-send-email-lenb@kernel.org> <11708743871468-git-send-email-lenb@kernel.org> <1170874390715-git-send-email-lenb@kernel.org> <1170874393736-git-send-email-lenb@kernel.org> <11708743943108-git-send-email-lenb@kernel.org> <11708743962377-git-send-ema
 il-lenb@kernel.org> <11708743972593-git-send-email-lenb@kernel.org> <1170874398386-git-send-email-lenb@kernel.org> <11708743993414-git-send-email-lenb@kernel.org> <11708744003959-git-send-email-lenb@kernel.org> <11708744023872-git-send-email-lenb@kernel.org> <11708744032427-git-send-email-lenb@kernel.org> <11708744053556-git-send-email-lenb@kernel.org> <11708744062538-git-send-email-lenb@kernel.org> <11708744071019-git-send-email-lenb@kernel.org> <11708744093818-git-send-email-lenb@kernel.org> <11708744101300-git-send-email-lenb@kernel.org> <1170874412494-git-send-email-lenb@kernel.org> <11708744142658-git-send-email-lenb@kernel.org> <1170874415464-git-send-email-lenb@kernel.org> <1170874417392-git-send-email-lenb@kernel.org> <1170874418134-git-send-email-lenb@kernel.org> <11708744191642-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([143.182.124.22]:20544 "EHLO
	azsmga101.ch.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1422753AbXBGSxw (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 7 Feb 2007 13:53:52 -0500
In-Reply-To: <11708744191642-git-send-email-lenb@kernel.org>
Message-Id: <78127b4a90469d6973de2837d483f80f3709e6e0.1170873816.git.len.brown@intel.com>
In-Reply-To: <9e89dde2b063ca73fcdc9244fe68e2dea32c5088.1170873816.git.len.brown@intel.com>
References: <9e89dde2b063ca73fcdc9244fe68e2dea32c5088.1170873816.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Corentin Chary <corentincj@iksaif.net>, Len Brown <len.brown@intel.com>

From: Corentin Chary <corentincj@iksaif.net>

/sys/.../asus-laptop/display can now be used to switch displays
like the old /proc/acpi/asus/disp does

Signed-off-by: Corentin Chary <corentincj@iksaif.net>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/misc/asus-laptop.c |   82 ++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 82 insertions(+), 0 deletions(-)

diff --git a/drivers/misc/asus-laptop.c b/drivers/misc/asus-laptop.c
index 58ab44d..979daa6 100644
--- a/drivers/misc/asus-laptop.c
+++ b/drivers/misc/asus-laptop.c
@@ -125,6 +125,23 @@ ASUS_HANDLE(lcd_switch, "\\_SB.PCI0.SBRG.EC0._Q10", /* All new models */
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
@@ -491,6 +508,60 @@ static ssize_t store_bluetooth(struct device *dev, struct device_attribute *attr
 	return store_status(buf, count, bt_switch_handle, BT_ON, 0);
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
@@ -535,11 +606,13 @@ static void asus_hotk_notify(acpi_handle handle, u32 event, void *data)
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
 
@@ -567,6 +640,12 @@ static void asus_hotk_add_fs(void)
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
@@ -683,6 +762,9 @@ static int asus_hotk_get_info(void)
 
 	ASUS_HANDLE_INIT(lcd_switch);
 
+	ASUS_HANDLE_INIT(display_set);
+	ASUS_HANDLE_INIT(display_get);
+
 	kfree(model);
 
 	return AE_OK;
-- 
1.5.0.rc3.39.gec804
