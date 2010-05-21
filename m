From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH 5/7] x86 platform drivers: hp-wmi Set placeholder for unimplemented events
Date: Fri, 21 May 2010 16:18:13 +0200
Message-ID: <1274451495-10252-6-git-send-email-trenn@suse.de>
References: <1274451495-10252-1-git-send-email-trenn@suse.de>
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <1274451495-10252-1-git-send-email-trenn@suse.de>
Sender: platform-driver-x86-owner@vger.kernel.org
To: mjg@redhat.com, trenn@suse.de
Cc: linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

And tell the user that those have happened.

Signed-off-by: Thomas Renninger <trenn@suse.de>
CC: mjg@redhat.com
CC: linux-acpi@vger.kernel.org
CC: platform-driver-x86@vger.kernel.org
---
 drivers/platform/x86/hp-wmi.c |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/drivers/platform/x86/hp-wmi.c b/drivers/platform/x86/hp-wmi.c
index f3ae911..f869fae 100644
--- a/drivers/platform/x86/hp-wmi.c
+++ b/drivers/platform/x86/hp-wmi.c
@@ -53,6 +53,7 @@ MODULE_ALIAS("wmi:5FB7F034-2C63-45e9-BE91-3D44E2C707E4");
 #define HPWMI_HOTKEY_QUERY 0xc
 
 #define PREFIX "HP WMI: "
+#define UNIMP "Unimplemented "
 
 enum hp_wmi_radio {
 	HPWMI_WIFI = 0,
@@ -62,8 +63,12 @@ enum hp_wmi_radio {
 
 enum hp_wmi_event_ids {
 	HPWMI_DOCK_EVENT = 1,
+	HPWMI_PARK_HDD = 2,
+	HPWMI_SMART_ADAPTER = 3,
 	HPWMI_BEZEL_BUTTON = 4,
 	HPWMI_WIRELESS = 5,
+	HPWMI_CPU_BATTERY_THROTTLE = 6,
+	HPWMI_LOCK_SWITCH = 7,
 };
 
 static int __devinit hp_wmi_bios_setup(struct platform_device *device);
@@ -374,6 +379,12 @@ static void hp_wmi_notify(u32 value, void *context)
 				    hp_wmi_tablet_state());
 		input_sync(hp_wmi_input_dev);
 		break;
+	case HPWMI_PARK_HDD:
+		printk(KERN_INFO PREFIX UNIMP "HDD park event detected\n");
+		break;
+	case HPWMI_SMART_ADAPTER:
+		printk(KERN_INFO PREFIX UNIMP "Smart adapter event detected\n");
+		break;
 	case HPWMI_BEZEL_BUTTON:
 		key_code = hp_wmi_perform_query(HPWMI_HOTKEY_QUERY, 0,
 						 0);
@@ -407,6 +418,13 @@ static void hp_wmi_notify(u32 value, void *context)
 					  hp_wmi_get_sw_state(HPWMI_WWAN),
 					  hp_wmi_get_hw_state(HPWMI_WWAN));
 		break;
+	case HPWMI_CPU_BATTERY_THROTTLE:
+		printk(KERN_INFO PREFIX UNIMP "CPU throttle because of 3 Cell"
+		       " battery event detected\n");
+		break;
+	case HPWMI_LOCK_SWITCH:
+		printk(KERN_INFO PREFIX UNIMP "Lock switch event detected\n");
+		break;
 	default:
 		printk(KERN_INFO PREFIX "Unknown eventcode - %d\n",
 		       eventcode);
-- 
1.6.3

