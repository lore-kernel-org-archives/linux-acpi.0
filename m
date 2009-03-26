From: Mattia Dongili <malattia@linux.it>
Subject: [PATCH 04/14] sony-laptop: Add rfkill support on new models
Date: Thu, 26 Mar 2009 21:58:15 +0900
Message-ID: <1238072305-8085-5-git-send-email-malattia@linux.it>
References: <1238072305-8085-1-git-send-email-malattia@linux.it>
 <1238072305-8085-2-git-send-email-malattia@linux.it>
 <1238072305-8085-3-git-send-email-malattia@linux.it>
 <1238072305-8085-4-git-send-email-malattia@linux.it>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from static-220-247-10-204.b-man.svips.gol.ne.jp ([220.247.10.204]:53398
	"EHLO smtp.kamineko.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751353AbZCZM62 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 26 Mar 2009 08:58:28 -0400
In-Reply-To: <1238072305-8085-4-git-send-email-malattia@linux.it>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Matthew Garrett <mjg59@srcf.ucam.org>, Matthew Garrett <mjg@redhat.com>, Mattia Dongili <malattia@linux.it>

From: Matthew Garrett <mjg59@srcf.ucam.org>

Newer Vaios provide a full featured rfkill implementation via their
platform methods. Add support for enumerating the available devices and
providing rfkill access to them. Support for the physical kill switch is
added, with the devices moving into the HARD_BLOCKED state when toggled.

Signed-off-by: Matthew Garrett <mjg@redhat.com>
Signed-off-by: Mattia Dongili <malattia@linux.it>
---
 drivers/platform/x86/sony-laptop.c |  186 ++++++++++++++++++++++++++++++++++++
 1 files changed, 186 insertions(+), 0 deletions(-)

diff --git a/drivers/platform/x86/sony-laptop.c b/drivers/platform/x86/sony-laptop.c
index f6cdc89..f458870 100644
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
@@ -123,6 +124,18 @@ MODULE_PARM_DESC(minor,
 		 "default is -1 (automatic)");
 #endif
 
+enum sony_nc_rfkill {
+	SONY_WIFI,
+	SONY_BLUETOOTH,
+	SONY_WWAN,
+	SONY_WIMAX,
+	SONY_RFKILL_MAX,
+};
+
+static struct rfkill *sony_rfkill_devices[SONY_RFKILL_MAX];
+static int sony_rfkill_address[SONY_RFKILL_MAX] = {0x300, 0x500, 0x700, 0x900};
+static void sony_nc_rfkill_update(void);
+
 /*********** Input Devices ***********/
 
 #define SONY_LAPTOP_BUF_SIZE	128
@@ -134,6 +147,7 @@ struct sony_laptop_input_s {
 	spinlock_t		fifo_lock;
 	struct workqueue_struct	*wq;
 };
+
 static struct sony_laptop_input_s sony_laptop_input = {
 	.users = ATOMIC_INIT(0),
 };
@@ -891,6 +905,9 @@ static void sony_acpi_notify(acpi_handle handle, u32 event, void *data)
 			if (!sony_nc_events[i].data)
 				printk(KERN_INFO DRV_PFX
 				       "Unknown event: %x %x\n", origev, ev);
+		} else if (sony_find_snc_handle(0x124) == ev) {
+			sony_nc_rfkill_update();
+			return;
 		}
 	}
 
@@ -973,6 +990,172 @@ static int sony_nc_resume(struct acpi_device *device)
 	return 0;
 }
 
+static void sony_nc_rfkill_cleanup(void)
+{
+	int i;
+
+	for (i = 0; i < SONY_RFKILL_MAX; i++) {
+		if (sony_rfkill_devices[i])
+			rfkill_unregister(sony_rfkill_devices[i]);
+	}
+}
+
+static int sony_nc_rfkill_get(void *data, enum rfkill_state *state)
+{
+	int result;
+	int argument = sony_rfkill_address[(long) data];
+
+	sony_call_snc_handle(0x124, 0x200, &result);
+	if (result & 0x1) {
+		sony_call_snc_handle(0x124, argument, &result);
+		if (result & 0xf)
+			*state = RFKILL_STATE_UNBLOCKED;
+		else
+			*state = RFKILL_STATE_SOFT_BLOCKED;
+	} else {
+		*state = RFKILL_STATE_HARD_BLOCKED;
+	}
+
+	return 0;
+}
+
+static int sony_nc_rfkill_set(void *data, enum rfkill_state state)
+{
+	int result;
+	int argument = sony_rfkill_address[(long) data] + 0x100;
+
+	if (state == RFKILL_STATE_UNBLOCKED)
+		argument |= 0xff0000;
+
+	return sony_call_snc_handle(0x124, argument, &result);
+}
+
+static int sony_nc_setup_wifi_rfkill(struct acpi_device *device)
+{
+	int err = 0;
+	struct rfkill *sony_wifi_rfkill;
+
+	sony_wifi_rfkill = rfkill_allocate(&device->dev, RFKILL_TYPE_WLAN);
+	if (!sony_wifi_rfkill)
+		return -1;
+	sony_wifi_rfkill->name = "sony-wifi";
+	sony_wifi_rfkill->toggle_radio = sony_nc_rfkill_set;
+	sony_wifi_rfkill->get_state = sony_nc_rfkill_get;
+	sony_wifi_rfkill->user_claim_unsupported = 1;
+	sony_wifi_rfkill->data = (void *)SONY_WIFI;
+	err = rfkill_register(sony_wifi_rfkill);
+	if (err)
+		rfkill_free(sony_wifi_rfkill);
+	else
+		sony_rfkill_devices[SONY_WIFI] = sony_wifi_rfkill;
+	return err;
+}
+
+static int sony_nc_setup_bluetooth_rfkill(struct acpi_device *device)
+{
+	int err = 0;
+	struct rfkill *sony_bluetooth_rfkill;
+
+	sony_bluetooth_rfkill = rfkill_allocate(&device->dev,
+						RFKILL_TYPE_BLUETOOTH);
+	if (!sony_bluetooth_rfkill)
+		return -1;
+	sony_bluetooth_rfkill->name = "sony-bluetooth";
+	sony_bluetooth_rfkill->toggle_radio = sony_nc_rfkill_set;
+	sony_bluetooth_rfkill->get_state = sony_nc_rfkill_get;
+	sony_bluetooth_rfkill->user_claim_unsupported = 1;
+	sony_bluetooth_rfkill->data = (void *)SONY_BLUETOOTH;
+	err = rfkill_register(sony_bluetooth_rfkill);
+	if (err)
+		rfkill_free(sony_bluetooth_rfkill);
+	else
+		sony_rfkill_devices[SONY_BLUETOOTH] = sony_bluetooth_rfkill;
+	return err;
+}
+
+static int sony_nc_setup_wwan_rfkill(struct acpi_device *device)
+{
+	int err = 0;
+	struct rfkill *sony_wwan_rfkill;
+
+	sony_wwan_rfkill = rfkill_allocate(&device->dev, RFKILL_TYPE_WWAN);
+	if (!sony_wwan_rfkill)
+		return -1;
+	sony_wwan_rfkill->name = "sony-wwan";
+	sony_wwan_rfkill->toggle_radio = sony_nc_rfkill_set;
+	sony_wwan_rfkill->get_state = sony_nc_rfkill_get;
+	sony_wwan_rfkill->user_claim_unsupported = 1;
+	sony_wwan_rfkill->data = (void *)SONY_WWAN;
+	err = rfkill_register(sony_wwan_rfkill);
+	if (err)
+		rfkill_free(sony_wwan_rfkill);
+	else
+		sony_rfkill_devices[SONY_WWAN] = sony_wwan_rfkill;
+	return err;
+}
+
+static int sony_nc_setup_wimax_rfkill(struct acpi_device *device)
+{
+	int err = 0;
+	struct rfkill *sony_wimax_rfkill;
+
+	sony_wimax_rfkill = rfkill_allocate(&device->dev, RFKILL_TYPE_WIMAX);
+	if (!sony_wimax_rfkill)
+		return -1;
+	sony_wimax_rfkill->name = "sony-wimax";
+	sony_wimax_rfkill->toggle_radio = sony_nc_rfkill_set;
+	sony_wimax_rfkill->get_state = sony_nc_rfkill_get;
+	sony_wimax_rfkill->user_claim_unsupported = 1;
+	sony_wimax_rfkill->data = (void *)SONY_WIMAX;
+	err = rfkill_register(sony_wimax_rfkill);
+	if (err)
+		rfkill_free(sony_wimax_rfkill);
+	else
+		sony_rfkill_devices[SONY_WIMAX] = sony_wimax_rfkill;
+	return err;
+}
+
+static void sony_nc_rfkill_update()
+{
+	int i;
+	enum rfkill_state state;
+
+	for (i = 0; i < SONY_RFKILL_MAX; i++) {
+		if (sony_rfkill_devices[i]) {
+			sony_rfkill_devices[i]->
+				get_state(sony_rfkill_devices[i]->data,
+					  &state);
+			rfkill_force_state(sony_rfkill_devices[i], state);
+		}
+	}
+}
+
+static int sony_nc_rfkill_setup(struct acpi_device *device)
+{
+	int result, ret;
+
+	if (sony_find_snc_handle(0x124) == -1)
+		return -1;
+
+	ret = sony_call_snc_handle(0x124, 0xb00, &result);
+	if (ret) {
+		printk(KERN_INFO DRV_PFX
+		       "Unable to enumerate rfkill devices: %x\n", ret);
+		return ret;
+	}
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
@@ -1026,6 +1209,7 @@ static int sony_nc_add(struct acpi_device *device)
 					 &handle))) {
 		dprintk("Doing SNC setup\n");
 		sony_nc_function_setup(device);
+		sony_nc_rfkill_setup(device);
 	}
 
 	/* setup input devices and helper fifo */
@@ -1132,6 +1316,7 @@ static int sony_nc_add(struct acpi_device *device)
 	sony_laptop_remove_input();
 
       outwalk:
+	sony_nc_rfkill_cleanup();
 	return result;
 }
 
@@ -1157,6 +1342,7 @@ static int sony_nc_remove(struct acpi_device *device, int type)
 
 	sony_pf_remove();
 	sony_laptop_remove_input();
+	sony_nc_rfkill_cleanup();
 	dprintk(SONY_NC_DRIVER_NAME " removed.\n");
 
 	return 0;
-- 
1.6.2

