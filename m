From: akpm@linux-foundation.org
Subject: [patch 3/3] dell-wmi: mask off BIS-provided garbage in scancode data
Date: Tue, 12 May 2009 13:35:27 -0700
Message-ID: <200905122054.n4CKsgZq001675@imap1.linux-foundation.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:53823 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751989AbZELVBm (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 12 May 2009 17:01:42 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, akpm@linux-foundation.org, mario_limonciello@dell.com, dtor@mail.ru, len.brown@intel.com, mjg@redhat.com

From: Mario Limonciello <mario_limonciello@dell.com>

In debugging with some future machines that actually contain BIOS level
support for dell-wmi, I've determined that the upper half of the data that
comes back from wmi_get_event_data may sometimes contain extra information
that isn't currently relevant when pulling scan codes out of the data. 
This causes dell-wmi to improperly respond to these events.

Cc: Matthew Garrett <mjg@redhat.com>
Cc: Dmitry Torokhov <dtor@mail.ru>
Cc: Len Brown <len.brown@intel.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/platform/x86/dell-wmi.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff -puN drivers/platform/x86/dell-wmi.c~dell-wmi-mask-off-bis-provided-garbage-in-scancode-data drivers/platform/x86/dell-wmi.c
--- a/drivers/platform/x86/dell-wmi.c~dell-wmi-mask-off-bis-provided-garbage-in-scancode-data
+++ a/drivers/platform/x86/dell-wmi.c
@@ -122,7 +122,7 @@ static void dell_wmi_notify(u32 value, v
 
 	if (obj && obj->type == ACPI_TYPE_BUFFER) {
 		int *buffer = (int *)obj->buffer.pointer;
-		key = dell_wmi_get_entry_by_scancode(buffer[1]);
+		key = dell_wmi_get_entry_by_scancode(0xFFFF & buffer[1]);
 		if (key) {
 			input_report_key(dell_wmi_input_dev, key->keycode, 1);
 			input_sync(dell_wmi_input_dev);
@@ -130,7 +130,7 @@ static void dell_wmi_notify(u32 value, v
 			input_sync(dell_wmi_input_dev);
 		} else
 			printk(KERN_INFO "dell-wmi: Unknown key %x pressed\n",
-			       buffer[1]);
+			       0xFFFF & buffer[1]);
 	}
 }
 
_
