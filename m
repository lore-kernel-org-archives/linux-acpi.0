From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: [PATCH] sony-laptop: support rfkill via ACPI interfaces
Date: Thu, 19 Mar 2009 21:28:03 +0000
Message-ID: <20090319212803.GA24782@srcf.ucam.org>
References: <20090319212123.GA24700@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:60916 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755641AbZCSV2H (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 19 Mar 2009 17:28:07 -0400
Content-Disposition: inline
In-Reply-To: <20090319212123.GA24700@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: malattia@linux.it
Cc: linux-acpi@vger.kernel.org

Enable events on all Vaios with the new-style ACPI interface, and use
it to support rfkill where available.
    
Signed-off-by: Matthew Garrett <mjg@redhat.com>

---

This one has less apostrophe abuse in the commit log. No content 
changes.

diff --git a/drivers/platform/x86/sony-laptop.c b/drivers/platform/x86/sony-laptop.c
index 537959d..c57f54c 100644
--- a/drivers/platform/x86/sony-laptop.c
+++ b/drivers/platform/x86/sony-laptop.c
@@ -64,6 +64,7 @@
 #include <asm/uaccess.h>
 #include <linux/sonypi.h>
 #include <linux/sony-laptop.h>
+#include <linux/rfkill.h>
 #ifdef CONFIG_SONYPI_COMPAT
 #include <linux/poll.h>
 #include <linux/miscdevice.h>
@@ -143,6 +144,11 @@ struct sony_laptop_keypress {
 	int key;
 };
 
+static struct rfkill *sony_wifi_rfkill;
+static struct rfkill *sony_bluetooth_rfkill;
+static struct rfkill *sony_wwan_rfkill;
+static struct rfkill *sony_wimax_rfkill;
+
 /* Correspondance table between sonypi events
  * and input layer indexes in the keymap
  */
@@ -981,6 +987,145 @@ static int sony_nc_resume(struct acpi_device *device)
 	return 0;
 }
 
+static void sony_rfkill_cleanup(void)
+{
+	if (sony_wifi_rfkill)
+		rfkill_unregister(sony_wifi_rfkill);
+	if (sony_bluetooth_rfkill)
+		rfkill_unregister(sony_bluetooth_rfkill);
+	if (sony_wwan_rfkill)
+		rfkill_unregister(sony_wwan_rfkill);
+	if (sony_wimax_rfkill)
+		rfkill_unregister(sony_wimax_rfkill);
+}
+
+static int sony_nc_rfkill_get(void *data, enum rfkill_state *state)
+{
+	int result;
+
+	acpi_callsetfunc(sony_nc_acpi_handle, "SN07", 0x3 | ((long) data << 8),
+			 &result);
+	if (result & 0xf)
+		*state = RFKILL_STATE_UNBLOCKED;
+	else
+		*state = RFKILL_STATE_SOFT_BLOCKED;
+	return 0;
+}
+
+static int sony_nc_rfkill_set(void *data, enum rfkill_state state)
+{
+	int result;
+	int call = 0x3 | (((long) data + 1) << 8);
+
+	if (state == RFKILL_STATE_UNBLOCKED)
+		call |= 0xff0000;
+
+	return acpi_callsetfunc(sony_nc_acpi_handle, "SN07", call, &result);
+}
+
+static int sony_nc_setup_wifi_rfkill(struct acpi_device *device)
+{
+	int err = 0;
+
+	sony_wifi_rfkill = rfkill_allocate(&device->dev, RFKILL_TYPE_WLAN);
+	if (!sony_wifi_rfkill)
+		return -1;
+	sony_wifi_rfkill->name = "sony-wifi";
+	sony_wifi_rfkill->toggle_radio = sony_nc_rfkill_set;
+	sony_wifi_rfkill->get_state = sony_nc_rfkill_get;
+	sony_wifi_rfkill->user_claim_unsupported = 1;
+	sony_wifi_rfkill->data = (void *)3;
+	err = rfkill_register(sony_wifi_rfkill);
+	if (err)
+		rfkill_unregister(sony_wifi_rfkill);
+	return err;
+}
+
+static int sony_nc_setup_bluetooth_rfkill(struct acpi_device *device)
+{
+	int err = 0;
+
+	sony_bluetooth_rfkill = rfkill_allocate(&device->dev,
+						RFKILL_TYPE_BLUETOOTH);
+	if (!sony_bluetooth_rfkill)
+		return -1;
+	sony_bluetooth_rfkill->name = "sony-bluetooth";
+	sony_bluetooth_rfkill->toggle_radio = sony_nc_rfkill_set;
+	sony_bluetooth_rfkill->get_state = sony_nc_rfkill_get;
+	sony_bluetooth_rfkill->user_claim_unsupported = 1;
+	sony_bluetooth_rfkill->data = (void *)5;
+	err = rfkill_register(sony_bluetooth_rfkill);
+	if (err)
+		rfkill_unregister(sony_bluetooth_rfkill);
+	return err;
+}
+
+static int sony_nc_setup_wwan_rfkill(struct acpi_device *device)
+{
+	int err = 0;
+
+	sony_wwan_rfkill = rfkill_allocate(&device->dev, RFKILL_TYPE_WWAN);
+	if (!sony_wwan_rfkill)
+		return -1;
+	sony_wwan_rfkill->name = "sony-wwan";
+	sony_wwan_rfkill->toggle_radio = sony_nc_rfkill_set;
+	sony_wwan_rfkill->get_state = sony_nc_rfkill_get;
+	sony_wwan_rfkill->user_claim_unsupported = 1;
+	sony_wwan_rfkill->data = (void *)7;
+	err = rfkill_register(sony_wwan_rfkill);
+	if (err)
+		rfkill_unregister(sony_wwan_rfkill);
+	return err;
+}
+
+static int sony_nc_setup_wimax_rfkill(struct acpi_device *device)
+{
+	int err = 0;
+
+	sony_wimax_rfkill = rfkill_allocate(&device->dev, RFKILL_TYPE_WIMAX);
+	if (!sony_wimax_rfkill)
+		return -1;
+	sony_wimax_rfkill->name = "sony-wimax";
+	sony_wimax_rfkill->toggle_radio = sony_nc_rfkill_set;
+	sony_wimax_rfkill->get_state = sony_nc_rfkill_get;
+	sony_wimax_rfkill->user_claim_unsupported = 1;
+	sony_wimax_rfkill->data = (void *)9;
+	err = rfkill_register(sony_wimax_rfkill);
+	if (err)
+		rfkill_unregister(sony_wimax_rfkill);
+	return err;
+}
+
+static int sony_nc_function_setup(struct acpi_device *device)
+{
+	int result;
+
+	/* Enable all events */
+	acpi_callsetfunc(sony_nc_acpi_handle, "SN02", 0xffff, &result);
+
+	/* Setup hotkey decoding */
+	acpi_callsetfunc(sony_nc_acpi_handle, "SN07", 0x2, &result);
+
+	/* Eaable hotkey event generation */
+	acpi_callsetfunc(sony_nc_acpi_handle, "SN07", 0, &result);
+
+	/* Set BCHA, whatever /that/ does */
+	acpi_callsetfunc(sony_nc_acpi_handle, "SN07", 0x101, &result);
+
+	acpi_callsetfunc(sony_nc_acpi_handle, "SN07", 0xb03, &result);
+
+	if (result & 0x1)
+		sony_nc_setup_wifi_rfkill(device);
+	if (result & 0x2)
+		sony_nc_setup_bluetooth_rfkill(device);
+	if (result & 0x1c)
+		sony_nc_setup_wwan_rfkill(device);
+	if (result & 0x20)
+		sony_nc_setup_wimax_rfkill(device);
+
+	return 0;
+}
+
 static int sony_nc_add(struct acpi_device *device)
 {
 	acpi_status status;
@@ -1024,6 +1169,12 @@ static int sony_nc_add(struct acpi_device *device)
 			dprintk("_INI Method failed\n");
 	}
 
+	if (ACPI_SUCCESS(acpi_get_handle(sony_nc_acpi_handle, "SN07",
+					 &handle))) {
+		dprintk("Doing SNC setup\n");
+		sony_nc_function_setup(device);
+	}
+
 	/* setup input devices and helper fifo */
 	result = sony_laptop_setup_input(device);
 	if (result) {
@@ -1131,6 +1282,7 @@ static int sony_nc_add(struct acpi_device *device)
 	sony_laptop_remove_input();
 
       outwalk:
+	sony_rfkill_cleanup();
 	return result;
 }
 
@@ -1156,6 +1308,7 @@ static int sony_nc_remove(struct acpi_device *device, int type)
 
 	sony_pf_remove();
 	sony_laptop_remove_input();
+	sony_rfkill_cleanup();
 	dprintk(SONY_NC_DRIVER_NAME " removed.\n");
 
 	return 0;


-- 
Matthew Garrett | mjg59@srcf.ucam.org
