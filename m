From: Len Brown <lenb@kernel.org>
Subject: [PATCH 35/140] asus-laptop: add ledd support
Date: Wed,  7 Feb 2007 13:50:49 -0500
Message-ID: <1170874421658-git-send-email-lenb@kernel.org>
References: <11708743541314-git-send-email-lenb@kernel.org> <11708743561383-git-send-email-lenb@kernel.org> <117087435785-git-send-email-lenb@kernel.org> <11708743582090-git-send-email-lenb@kernel.org> <11708743611662-git-send-email-lenb@kernel.org> <11708743653073-git-send-email-lenb@kernel.org> <11708743674006-git-send-email-lenb@kernel.org> <11708743693386-git-send-email-lenb@kernel.org> <11708743702194-git-send-email-lenb@kernel.org> <11708743723353-git-send-email-lenb@kernel.org> <11708743783727-git-send-email-lenb@kernel.org> <11708743802558-git-send-email-lenb@kernel.org> <11708743821259-git-send-email-lenb@kernel.org> <11708743853573-git-send-email-lenb@kernel.org> <11708743871468-git-send-email-lenb@kernel.org> <1170874390715-git-send-email-lenb@kernel.org> <1170874393736-git-send-email-lenb@kernel.org> <11708743943108-git-send-email-lenb@kernel.org> <11708743962377-git-send-ema
 il-lenb@kernel.org> <11708743972593-git-send-email-lenb@kernel.org> <1170874398386-git-send-email-lenb@kernel.org> <11708743993414-git-send-email-lenb@kernel.org> <11708744003959-git-send-email-lenb@kernel.org> <11708744023872-git-send-email-lenb@kernel.org> <11708744032427-git-send-email-lenb@kernel.org> <11708744053556-git-send-email-lenb@kernel.org> <11708744062538-git-send-email-lenb@kernel.org> <11708744071019-git-send-email-lenb@kernel.org> <11708744093818-git-send-email-lenb@kernel.org> <11708744101300-git-send-email-lenb@kernel.org> <1170874412494-git-send-email-lenb@kernel.org> <11708744142658-git-send-email-lenb@kernel.org> <1170874415464-git-send-email-lenb@kernel.org> <1170874417392-git-send-email-lenb@kernel.org> <1170874418134-git-send-email-lenb@kernel.org> <11708744191642-git-send-email-lenb@kernel.org> <11708744203492-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([143.182.124.22]:20544 "EHLO
	azsmga101.ch.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1422756AbXBGSxx (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 7 Feb 2007 13:53:53 -0500
In-Reply-To: <11708744203492-git-send-email-lenb@kernel.org>
Message-Id: <722ad97153015aaf5becba3084565e98e71a2aed.1170873816.git.len.brown@intel.com>
In-Reply-To: <9e89dde2b063ca73fcdc9244fe68e2dea32c5088.1170873816.git.len.brown@intel.com>
References: <9e89dde2b063ca73fcdc9244fe68e2dea32c5088.1170873816.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Corentin Chary <corentincj@iksaif.net>, Len Brown <len.brown@intel.com>

From: Corentin Chary <corentincj@iksaif.net>

Ledd is a special led ... /sys/.../asus-laptop/ledd works like
/proc/acpi/asus/ledd

Signed-off-by: Corentin Chary <corentincj@iksaif.net>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/misc/asus-laptop.c |   38 ++++++++++++++++++++++++++++++++++++++
 1 files changed, 38 insertions(+), 0 deletions(-)

diff --git a/drivers/misc/asus-laptop.c b/drivers/misc/asus-laptop.c
index 979daa6..bd963c6 100644
--- a/drivers/misc/asus-laptop.c
+++ b/drivers/misc/asus-laptop.c
@@ -104,6 +104,9 @@ ASUS_HANDLE(tled_set, ASUS_HOTK_PREFIX "TLED");
 ASUS_HANDLE(rled_set, ASUS_HOTK_PREFIX "RLED"); /* W1JC */
 ASUS_HANDLE(pled_set, ASUS_HOTK_PREFIX "PLED"); /* A7J */
 
+/* LEDD */
+ASUS_HANDLE(ledd_set, ASUS_HOTK_PREFIX "SLCM");
+
 /* Bluetooth and WLAN
  * WLED and BLED are not handled like other XLED, because in some dsdt
  * they also control the WLAN/Bluetooth device.
@@ -151,6 +154,7 @@ struct asus_hotk {
 	struct acpi_device *device;	//the device we are in
 	acpi_handle handle;	//the handle of the hotk device
 	char status;		//status of the hotk, for LEDs, ...
+	u32 ledd_status;	//status of the LED display
 	u16 event_count[128];	//count for each event TODO make this better
 };
 
@@ -479,6 +483,30 @@ static ssize_t store_status(const char *buf, size_t count,
 }
 
 /*
+ * LEDD display
+ */
+static ssize_t show_ledd(struct device *dev,
+			 struct device_attribute *attr, char *buf)
+{
+	return sprintf(buf, "0x%08x\n", hotk->ledd_status);
+}
+
+static ssize_t store_ledd(struct device *dev, struct device_attribute *attr,
+			  const char *buf, size_t count)
+{
+	int rv, value;
+
+	rv = parse_arg(buf, count, &value);
+	if (rv > 0) {
+		if (!write_acpi_int(ledd_set_handle, NULL, value, NULL))
+			printk(ASUS_WARNING "LED display write failed\n");
+		else
+			hotk->ledd_status = (u32) value;
+	}
+	return rv;
+}
+
+/*
  * WLAN
  */
 static ssize_t show_wlan(struct device *dev,
@@ -607,12 +635,14 @@ static ASUS_CREATE_DEVICE_ATTR(infos);
 static ASUS_CREATE_DEVICE_ATTR(wlan);
 static ASUS_CREATE_DEVICE_ATTR(bluetooth);
 static ASUS_CREATE_DEVICE_ATTR(display);
+static ASUS_CREATE_DEVICE_ATTR(ledd);
 
 static struct attribute *asuspf_attributes[] = {
         &dev_attr_infos.attr,
         &dev_attr_wlan.attr,
         &dev_attr_bluetooth.attr,
         &dev_attr_display.attr,
+        &dev_attr_ledd.attr,
         NULL
 };
 
@@ -646,6 +676,9 @@ static void asus_hotk_add_fs(void)
 	else if(display_set_handle)
 		ASUS_SET_DEVICE_ATTR(display, 0200, NULL, store_disp);
 
+	if (ledd_set_handle)
+		ASUS_SET_DEVICE_ATTR(ledd, 0644, show_ledd, store_ledd);
+
 }
 
 static int asus_handle_init(char *name, acpi_handle *handle,
@@ -741,6 +774,8 @@ static int asus_hotk_get_info(void)
 	ASUS_HANDLE_INIT(rled_set);
 	ASUS_HANDLE_INIT(pled_set);
 
+	ASUS_HANDLE_INIT(ledd_set);
+
 	/*
 	 * The HWRS method return informations about the hardware.
 	 * 0x80 bit is for WLAN, 0x100 for Bluetooth.
@@ -836,6 +871,9 @@ static int asus_hotk_add(struct acpi_device *device)
 	/* LCD Backlight is on by default */
 	write_status(NULL, 1, LCD_ON, 0);
 
+	/* LED display is off by default */
+	hotk->ledd_status = 0xFFF;
+
       end:
 	if (result) {
 		kfree(hotk->name);
-- 
1.5.0.rc3.39.gec804
