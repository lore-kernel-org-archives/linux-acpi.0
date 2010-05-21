From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH 6/7] x86 platform drivers: hp-wmi fix buffer size depending on ACPI version
Date: Fri, 21 May 2010 16:18:14 +0200
Message-ID: <1274451495-10252-7-git-send-email-trenn@suse.de>
References: <1274451495-10252-1-git-send-email-trenn@suse.de>
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <1274451495-10252-1-git-send-email-trenn@suse.de>
Sender: platform-driver-x86-owner@vger.kernel.org
To: mjg@redhat.com, trenn@suse.de
Cc: linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org, robert.moore@intel.com
List-Id: linux-acpi@vger.kernel.org

Depending on ACPI version (1.0 -> 32 bit) an integer could be
32 or 64 bit long. _WED internal concatenates two integers and
the return value will be 8 byte (2* 32 bit) or 16 byte (2* 64 bit)
long, depending on the ACPI version.

Also the data send with the WMI event is defined to be splitted into:
  - Event ID -> 4 bytes
  - Event Data -> 4 bytes

This gets messed up with new ACPI versions.
But it's a HP BIOS bug that may get fixed in the future
-> Support both, 16 and 8 byte _WED buffers.

Also the wrong assumption that from the event data sent, only the
first byte is relevant got cleaned up that it fits event_id/event_data
as described above.

Signed-off-by: Thomas Renninger <trenn@suse.de>
CC: robert.moore@intel.com
CC: mjg@redhat.com
CC: platform-driver-x86@vger.kernel.org
CC: linux-acpi@vger.kernel.org
---
 drivers/platform/x86/hp-wmi.c |   38 ++++++++++++++++++++++++++++++--------
 1 files changed, 30 insertions(+), 8 deletions(-)

diff --git a/drivers/platform/x86/hp-wmi.c b/drivers/platform/x86/hp-wmi.c
index f869fae..0ebe5de 100644
--- a/drivers/platform/x86/hp-wmi.c
+++ b/drivers/platform/x86/hp-wmi.c
@@ -352,7 +352,9 @@ static void hp_wmi_notify(u32 value, void *context)
 	struct acpi_buffer response = { ACPI_ALLOCATE_BUFFER, NULL };
 	static struct key_entry *key;
 	union acpi_object *obj;
-	int eventcode, key_code;
+	u32 event_id, event_data;
+	int key_code;
+	u32 *location;
 	acpi_status status;
 
 	status = wmi_get_event_data(value, &response);
@@ -363,15 +365,34 @@ static void hp_wmi_notify(u32 value, void *context)
 
 	obj = (union acpi_object *)response.pointer;
 
-	if (!obj || obj->type != ACPI_TYPE_BUFFER || obj->buffer.length != 8) {
-		printk(KERN_INFO PREFIX "Unknown response received\n");
+        if (obj || obj->type != ACPI_TYPE_BUFFER) {
+                printk(KERN_INFO "hp-wmi: Unknown response received %d\n",
+		       obj->type);
 		kfree(obj);
 		return;
 	}
 
-	eventcode = *((u8 *) obj->buffer.pointer);
+	/*
+	 * Depending on ACPI version the concatenation of id and event data
+	 * inside _WED function will result in a 8 or 16 byte buffer.
+	 */
+	location = (u32*)obj->buffer.pointer;
+	if (obj->buffer.length == 8) {
+		event_id = *location;
+		event_data = *(location + 1);
+	}
+	else if (obj->buffer.length == 16) {
+		event_id = *location;
+		event_data = *(location + 2);
+	} else {
+		printk(KERN_INFO "hp-wmi: Unknown buffer length %d\n",
+		       obj->buffer.length);
+                kfree(obj);
+                return;
+        }
 	kfree(obj);
-	switch (eventcode) {
+
+	switch (event_id) {
 	case HPWMI_DOCK_EVENT:
 		input_report_switch(hp_wmi_input_dev, SW_DOCK,
 				    hp_wmi_dock_state());
@@ -380,7 +401,8 @@ static void hp_wmi_notify(u32 value, void *context)
 		input_sync(hp_wmi_input_dev);
 		break;
 	case HPWMI_PARK_HDD:
-		printk(KERN_INFO PREFIX UNIMP "HDD park event detected\n");
+		printk(KERN_INFO PREFIX UNIMP "HDD park event detected -"
+		       " 0x%x\n", event_data);
 		break;
 	case HPWMI_SMART_ADAPTER:
 		printk(KERN_INFO PREFIX UNIMP "Smart adapter event detected\n");
@@ -426,8 +448,8 @@ static void hp_wmi_notify(u32 value, void *context)
 		printk(KERN_INFO PREFIX UNIMP "Lock switch event detected\n");
 		break;
 	default:
-		printk(KERN_INFO PREFIX "Unknown eventcode - %d\n",
-		       eventcode);
+		printk(KERN_INFO PREFIX "Unknown event_id - %d - 0x%x\n",
+		       event_id, event_data);
 		break;
 	}
 }
-- 
1.6.3

