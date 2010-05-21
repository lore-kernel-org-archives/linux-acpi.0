From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH 3/7] x86 platform drivers: hp-wmi Use consistent prefix string for messages.
Date: Fri, 21 May 2010 16:18:11 +0200
Message-ID: <1274451495-10252-4-git-send-email-trenn@suse.de>
References: <1274451495-10252-1-git-send-email-trenn@suse.de>
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <1274451495-10252-1-git-send-email-trenn@suse.de>
Sender: platform-driver-x86-owner@vger.kernel.org
To: mjg@redhat.com, trenn@suse.de
Cc: linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Signed-off-by: Thomas Renninger <trenn@suse.de>
CC: mjg@redhat.com
CC: linux-acpi@vger.kernel.org
CC: platform-driver-x86@vger.kernel.org
---
 drivers/platform/x86/hp-wmi.c |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/hp-wmi.c b/drivers/platform/x86/hp-wmi.c
index 7b086dd..e04715a 100644
--- a/drivers/platform/x86/hp-wmi.c
+++ b/drivers/platform/x86/hp-wmi.c
@@ -52,6 +52,8 @@ MODULE_ALIAS("wmi:5FB7F034-2C63-45e9-BE91-3D44E2C707E4");
 #define HPWMI_WIRELESS_QUERY 0x5
 #define HPWMI_HOTKEY_QUERY 0xc
 
+#define PREFIX "HP WMI: "
+
 enum hp_wmi_radio {
 	HPWMI_WIFI = 0,
 	HPWMI_BLUETOOTH = 1,
@@ -349,14 +351,14 @@ static void hp_wmi_notify(u32 value, void *context)
 
 	status = wmi_get_event_data(value, &response);
 	if (status != AE_OK) {
-		printk(KERN_INFO "hp-wmi: bad event status 0x%x\n", status);
+		printk(KERN_INFO PREFIX "bad event status 0x%x\n", status);
 		return;
 	}
 
 	obj = (union acpi_object *)response.pointer;
 
 	if (!obj || obj->type != ACPI_TYPE_BUFFER || obj->buffer.length != 8) {
-		printk(KERN_INFO "HP WMI: Unknown response received\n");
+		printk(KERN_INFO PREFIX "Unknown response received\n");
 		kfree(obj);
 		return;
 	}
@@ -387,7 +389,7 @@ static void hp_wmi_notify(u32 value, void *context)
 				break;
 			}
 		} else
-			printk(KERN_INFO "HP WMI: Unknown key code - 0x%x\n",
+			printk(KERN_INFO PREFIX "Unknown key code - 0x%x\n",
 			       key_code);
 		break;
 	case HPWMI_WIRELESS:
@@ -405,7 +407,7 @@ static void hp_wmi_notify(u32 value, void *context)
 					  hp_wmi_get_hw_state(HPWMI_WWAN));
 		break;
 	default:
-		printk(KERN_INFO "HP WMI: Unknown eventcode - %d\n",
+		printk(KERN_INFO PREFIX "Unknown eventcode - %d\n",
 		       eventcode);
 		break;
 	}
-- 
1.6.3

