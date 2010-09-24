From: Greg KH <gregkh@suse.de>
Subject: [49/80] x86 platform drivers: hp-wmi Reorder event id processing
Date: Fri, 24 Sep 2010 09:24:37 -0700
Message-ID: <20100924162619.137250221@clark.site>
References: <20100924162706.GA7381@kroah.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100924162706.GA7381@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: stable-review@kernel.org, torvalds@linux-foundation.org, akpm@linux-foundation.org, alan@lxorguk.ukuu.org.uk, Thomas Renninger <trenn@suse.de>, Matthew Garrett <mjg@redhat.com>, linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

2.6.35-stable review patch.  If anyone has any objections, please let us know.

------------------

From: Thomas Renninger <trenn@suse.de>

commit 751ae808f6b29803228609f51aa1ae057f5c576e upstream.

Event id 0x4 defines the hotkey event.
No need (or even wrong) to query HPWMI_HOTKEY_QUERY if event id is != 0x4.

Reorder the eventcode conditionals and use switch case instead of if/else.
Use an enum for the event ids cases.

Signed-off-by: Thomas Renninger <trenn@suse.de>
Signed-off-by: Matthew Garrett <mjg@redhat.com>
CC: linux-acpi@vger.kernel.org
CC: platform-driver-x86@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/platform/x86/hp-wmi.c |   51 ++++++++++++++++++++++++++----------------
 1 file changed, 32 insertions(+), 19 deletions(-)

--- a/drivers/platform/x86/hp-wmi.c
+++ b/drivers/platform/x86/hp-wmi.c
@@ -58,6 +58,12 @@ enum hp_wmi_radio {
 	HPWMI_WWAN = 2,
 };
 
+enum hp_wmi_event_ids {
+	HPWMI_DOCK_EVENT = 1,
+	HPWMI_BEZEL_BUTTON = 4,
+	HPWMI_WIRELESS = 5,
+};
+
 static int __devinit hp_wmi_bios_setup(struct platform_device *device);
 static int __exit hp_wmi_bios_remove(struct platform_device *device);
 static int hp_wmi_resume_handler(struct device *device);
@@ -338,7 +344,7 @@ static void hp_wmi_notify(u32 value, voi
 	struct acpi_buffer response = { ACPI_ALLOCATE_BUFFER, NULL };
 	static struct key_entry *key;
 	union acpi_object *obj;
-	int eventcode;
+	int eventcode, key_code;
 	acpi_status status;
 
 	status = wmi_get_event_data(value, &response);
@@ -357,28 +363,32 @@ static void hp_wmi_notify(u32 value, voi
 
 	eventcode = *((u8 *) obj->buffer.pointer);
 	kfree(obj);
-	if (eventcode == 0x4)
-		eventcode = hp_wmi_perform_query(HPWMI_HOTKEY_QUERY, 0,
-						0);
-	key = hp_wmi_get_entry_by_scancode(eventcode);
-	if (key) {
-		switch (key->type) {
-		case KE_KEY:
-			input_report_key(hp_wmi_input_dev,
-					 key->keycode, 1);
-			input_sync(hp_wmi_input_dev);
-			input_report_key(hp_wmi_input_dev,
-					 key->keycode, 0);
-			input_sync(hp_wmi_input_dev);
-			break;
-		}
-	} else if (eventcode == 0x1) {
+	switch (eventcode) {
+	case HPWMI_DOCK_EVENT:
 		input_report_switch(hp_wmi_input_dev, SW_DOCK,
 				    hp_wmi_dock_state());
 		input_report_switch(hp_wmi_input_dev, SW_TABLET_MODE,
 				    hp_wmi_tablet_state());
 		input_sync(hp_wmi_input_dev);
-	} else if (eventcode == 0x5) {
+		break;
+	case HPWMI_BEZEL_BUTTON:
+		key_code = hp_wmi_perform_query(HPWMI_HOTKEY_QUERY, 0,
+						 0);
+		key = hp_wmi_get_entry_by_scancode(key_code);
+		if (key) {
+			switch (key->type) {
+			case KE_KEY:
+				input_report_key(hp_wmi_input_dev,
+						 key->keycode, 1);
+				input_sync(hp_wmi_input_dev);
+				input_report_key(hp_wmi_input_dev,
+						 key->keycode, 0);
+				input_sync(hp_wmi_input_dev);
+				break;
+			}
+		}
+		break;
+	case HPWMI_WIRELESS:
 		if (wifi_rfkill)
 			rfkill_set_states(wifi_rfkill,
 					  hp_wmi_get_sw_state(HPWMI_WIFI),
@@ -391,9 +401,12 @@ static void hp_wmi_notify(u32 value, voi
 			rfkill_set_states(wwan_rfkill,
 					  hp_wmi_get_sw_state(HPWMI_WWAN),
 					  hp_wmi_get_hw_state(HPWMI_WWAN));
-	} else
+		break;
+	default:
 		printk(KERN_INFO "HP WMI: Unknown key pressed - %x\n",
 			eventcode);
+		break;
+	}
 }
 
 static int __init hp_wmi_input_setup(void)
