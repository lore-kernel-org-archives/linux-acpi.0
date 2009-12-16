From: Len Brown <lenb@kernel.org>
Subject: [PATCH 050/103] hp-wmi: improve rfkill support
Date: Wed, 16 Dec 2009 03:36:01 -0500
Message-ID: <e5fbba85a7acc2626d4fe14501816811d702f3e9.1260952472.git.len.brown@intel.com>
References: <1260952614-3152-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173019pub.verizon.net ([206.46.173.19]:47186 "EHLO
	vms173019pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761990AbZLPLFy (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Dec 2009 06:05:54 -0500
Received: from localhost.localdomain ([unknown] [74.104.151.18])
 by vms173019.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0KUQ00BZPS5OJK34@vms173019.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 16 Dec 2009 05:05:52 -0600 (CST)
In-reply-to: <1260952614-3152-1-git-send-email-lenb@kernel.org>
In-reply-to: <5f46c2f25cfbb5faca7550738ac42c4d1491ddc8.1260952471.git.len.brown@intel.com>
References: <5f46c2f25cfbb5faca7550738ac42c4d1491ddc8.1260952471.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Alan Jenkins <alan-jenkins@tuffmail.co.uk>, Len Brown <len.brown@intel.com>

From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>

1) Add support for reading the hardware blocked state.  Previously
   we read a combination of the hardware and software blocked states,
   reporting it as the software blocked state.  This caused some
   confusing behaviour.

2) The software state is persistent, mark it as such.

3) Check rfkill in the resume handler.  Both the hard and soft
   blocked states may change over hibernation.

Signed-off-by: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Acked-by: Matthew Garrett <mjg@redhat.com>
Tested-by: Maciej Rutecki <maciej.rutecki@gmail.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/platform/x86/hp-wmi.c |  139 +++++++++++++++++++++++++----------------
 1 files changed, 84 insertions(+), 55 deletions(-)

diff --git a/drivers/platform/x86/hp-wmi.c b/drivers/platform/x86/hp-wmi.c
index c284217..804cfdb 100644
--- a/drivers/platform/x86/hp-wmi.c
+++ b/drivers/platform/x86/hp-wmi.c
@@ -51,6 +51,12 @@ MODULE_ALIAS("wmi:5FB7F034-2C63-45e9-BE91-3D44E2C707E4");
 #define HPWMI_WIRELESS_QUERY 0x5
 #define HPWMI_HOTKEY_QUERY 0xc
 
+enum hp_wmi_radio {
+	HPWMI_WIFI = 0,
+	HPWMI_BLUETOOTH = 1,
+	HPWMI_WWAN = 2,
+};
+
 static int __init hp_wmi_bios_setup(struct platform_device *device);
 static int __exit hp_wmi_bios_remove(struct platform_device *device);
 static int hp_wmi_resume_handler(struct device *device);
@@ -175,8 +181,8 @@ static int hp_wmi_tablet_state(void)
 
 static int hp_wmi_set_block(void *data, bool blocked)
 {
-	unsigned long b = (unsigned long) data;
-	int query = BIT(b + 8) | ((!blocked) << b);
+	enum hp_wmi_radio r = (enum hp_wmi_radio) data;
+	int query = BIT(r + 8) | ((!blocked) << r);
 
 	return hp_wmi_perform_query(HPWMI_WIRELESS_QUERY, 1, query);
 }
@@ -185,31 +191,23 @@ static const struct rfkill_ops hp_wmi_rfkill_ops = {
 	.set_block = hp_wmi_set_block,
 };
 
-static bool hp_wmi_wifi_state(void)
-{
-	int wireless = hp_wmi_perform_query(HPWMI_WIRELESS_QUERY, 0, 0);
-
-	if (wireless & 0x100)
-		return false;
-	else
-		return true;
-}
-
-static bool hp_wmi_bluetooth_state(void)
+static bool hp_wmi_get_sw_state(enum hp_wmi_radio r)
 {
 	int wireless = hp_wmi_perform_query(HPWMI_WIRELESS_QUERY, 0, 0);
+	int mask = 0x200 << (r * 8);
 
-	if (wireless & 0x10000)
+	if (wireless & mask)
 		return false;
 	else
 		return true;
 }
 
-static bool hp_wmi_wwan_state(void)
+static bool hp_wmi_get_hw_state(enum hp_wmi_radio r)
 {
 	int wireless = hp_wmi_perform_query(HPWMI_WIRELESS_QUERY, 0, 0);
+	int mask = 0x800 << (r * 8);
 
-	if (wireless & 0x1000000)
+	if (wireless & mask)
 		return false;
 	else
 		return true;
@@ -334,49 +332,55 @@ static void hp_wmi_notify(u32 value, void *context)
 	struct acpi_buffer response = { ACPI_ALLOCATE_BUFFER, NULL };
 	static struct key_entry *key;
 	union acpi_object *obj;
+	int eventcode;
 
 	wmi_get_event_data(value, &response);
 
 	obj = (union acpi_object *)response.pointer;
 
-	if (obj && obj->type == ACPI_TYPE_BUFFER && obj->buffer.length == 8) {
-		int eventcode = *((u8 *) obj->buffer.pointer);
-		if (eventcode == 0x4)
-			eventcode = hp_wmi_perform_query(HPWMI_HOTKEY_QUERY, 0,
-							 0);
-		key = hp_wmi_get_entry_by_scancode(eventcode);
-		if (key) {
-			switch (key->type) {
-			case KE_KEY:
-				input_report_key(hp_wmi_input_dev,
-						 key->keycode, 1);
-				input_sync(hp_wmi_input_dev);
-				input_report_key(hp_wmi_input_dev,
-						 key->keycode, 0);
-				input_sync(hp_wmi_input_dev);
-				break;
-			}
-		} else if (eventcode == 0x1) {
-			input_report_switch(hp_wmi_input_dev, SW_DOCK,
-					    hp_wmi_dock_state());
-			input_report_switch(hp_wmi_input_dev, SW_TABLET_MODE,
-					    hp_wmi_tablet_state());
+	if (!obj || obj->type != ACPI_TYPE_BUFFER || obj->buffer.length != 8) {
+		printk(KERN_INFO "HP WMI: Unknown response received\n");
+		return;
+	}
+
+	eventcode = *((u8 *) obj->buffer.pointer);
+	if (eventcode == 0x4)
+		eventcode = hp_wmi_perform_query(HPWMI_HOTKEY_QUERY, 0,
+						0);
+	key = hp_wmi_get_entry_by_scancode(eventcode);
+	if (key) {
+		switch (key->type) {
+		case KE_KEY:
+			input_report_key(hp_wmi_input_dev,
+					 key->keycode, 1);
+			input_sync(hp_wmi_input_dev);
+			input_report_key(hp_wmi_input_dev,
+					 key->keycode, 0);
 			input_sync(hp_wmi_input_dev);
-		} else if (eventcode == 0x5) {
-			if (wifi_rfkill)
-				rfkill_set_sw_state(wifi_rfkill,
-						    hp_wmi_wifi_state());
-			if (bluetooth_rfkill)
-				rfkill_set_sw_state(bluetooth_rfkill,
-						    hp_wmi_bluetooth_state());
-			if (wwan_rfkill)
-				rfkill_set_sw_state(wwan_rfkill,
-						    hp_wmi_wwan_state());
-		} else
-			printk(KERN_INFO "HP WMI: Unknown key pressed - %x\n",
-			       eventcode);
+			break;
+		}
+	} else if (eventcode == 0x1) {
+		input_report_switch(hp_wmi_input_dev, SW_DOCK,
+				    hp_wmi_dock_state());
+		input_report_switch(hp_wmi_input_dev, SW_TABLET_MODE,
+				    hp_wmi_tablet_state());
+		input_sync(hp_wmi_input_dev);
+	} else if (eventcode == 0x5) {
+		if (wifi_rfkill)
+			rfkill_set_states(wifi_rfkill,
+					  hp_wmi_get_sw_state(HPWMI_WIFI),
+					  hp_wmi_get_hw_state(HPWMI_WIFI));
+		if (bluetooth_rfkill)
+			rfkill_set_states(bluetooth_rfkill,
+					  hp_wmi_get_sw_state(HPWMI_BLUETOOTH),
+					  hp_wmi_get_hw_state(HPWMI_BLUETOOTH));
+		if (wwan_rfkill)
+			rfkill_set_states(wwan_rfkill,
+					  hp_wmi_get_sw_state(HPWMI_WWAN),
+					  hp_wmi_get_hw_state(HPWMI_WWAN));
 	} else
-		printk(KERN_INFO "HP WMI: Unknown response received\n");
+		printk(KERN_INFO "HP WMI: Unknown key pressed - %x\n",
+			eventcode);
 }
 
 static int __init hp_wmi_input_setup(void)
@@ -455,7 +459,11 @@ static int __init hp_wmi_bios_setup(struct platform_device *device)
 		wifi_rfkill = rfkill_alloc("hp-wifi", &device->dev,
 					   RFKILL_TYPE_WLAN,
 					   &hp_wmi_rfkill_ops,
-					   (void *) 0);
+					   (void *) HPWMI_WIFI);
+		rfkill_init_sw_state(wifi_rfkill,
+				     hp_wmi_get_sw_state(HPWMI_WIFI));
+		rfkill_set_hw_state(wifi_rfkill,
+				    hp_wmi_get_hw_state(HPWMI_WIFI));
 		err = rfkill_register(wifi_rfkill);
 		if (err)
 			goto register_wifi_error;
@@ -465,7 +473,11 @@ static int __init hp_wmi_bios_setup(struct platform_device *device)
 		bluetooth_rfkill = rfkill_alloc("hp-bluetooth", &device->dev,
 						RFKILL_TYPE_BLUETOOTH,
 						&hp_wmi_rfkill_ops,
-						(void *) 1);
+						(void *) HPWMI_BLUETOOTH);
+		rfkill_init_sw_state(bluetooth_rfkill,
+				     hp_wmi_get_sw_state(HPWMI_BLUETOOTH));
+		rfkill_set_hw_state(bluetooth_rfkill,
+				    hp_wmi_get_hw_state(HPWMI_BLUETOOTH));
 		err = rfkill_register(bluetooth_rfkill);
 		if (err)
 			goto register_bluetooth_error;
@@ -475,7 +487,11 @@ static int __init hp_wmi_bios_setup(struct platform_device *device)
 		wwan_rfkill = rfkill_alloc("hp-wwan", &device->dev,
 					   RFKILL_TYPE_WWAN,
 					   &hp_wmi_rfkill_ops,
-					   (void *) 2);
+					   (void *) HPWMI_WWAN);
+		rfkill_init_sw_state(wwan_rfkill,
+				     hp_wmi_get_sw_state(HPWMI_WWAN));
+		rfkill_set_hw_state(wwan_rfkill,
+				    hp_wmi_get_hw_state(HPWMI_WWAN));
 		err = rfkill_register(wwan_rfkill);
 		if (err)
 			goto register_wwan_err;
@@ -533,6 +549,19 @@ static int hp_wmi_resume_handler(struct device *device)
 		input_sync(hp_wmi_input_dev);
 	}
 
+	if (wifi_rfkill)
+		rfkill_set_states(wifi_rfkill,
+				  hp_wmi_get_sw_state(HPWMI_WIFI),
+				  hp_wmi_get_hw_state(HPWMI_WIFI));
+	if (bluetooth_rfkill)
+		rfkill_set_states(bluetooth_rfkill,
+				  hp_wmi_get_sw_state(HPWMI_BLUETOOTH),
+				  hp_wmi_get_hw_state(HPWMI_BLUETOOTH));
+	if (wwan_rfkill)
+		rfkill_set_states(wwan_rfkill,
+				  hp_wmi_get_sw_state(HPWMI_WWAN),
+				  hp_wmi_get_hw_state(HPWMI_WWAN));
+
 	return 0;
 }
 
-- 
1.6.0.6

