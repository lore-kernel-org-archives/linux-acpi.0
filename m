From: akpm@linux-foundation.org
Subject: [patch 1/4] dell-wmi: mask off upper bytes of event response
Date: Wed, 10 Jun 2009 12:40:46 -0700
Message-ID: <200906101940.n5AJekR7028796@imap1.linux-foundation.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:56325 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758681AbZFJToe (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 10 Jun 2009 15:44:34 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, akpm@linux-foundation.org, mario_limonciello@dell.com, mjg@redhat.com

From: Mario Limonciello <mario_limonciello@dell.com>

In debugging with some future machines that actually contain BIOS level
support for dell-wmi, I've determined that the upper half of the data that
comes back from wmi_get_event_data may sometimes contain extra information
that isn't currently relevant when pulling scan codes out of the data. 
This causes dell-wmi to improperly respond to these events.

Signed-off-by: Mario Limonciello <mario_limonciello@dell.com>
Signed-off-by: Matthew Garrett <mjg@redhat.com>
Cc: Len Brown <lenb@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/platform/x86/dell-wmi.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff -puN drivers/platform/x86/dell-wmi.c~dell-wmi-mask-off-upper-bytes-of-event-response drivers/platform/x86/dell-wmi.c
--- a/drivers/platform/x86/dell-wmi.c~dell-wmi-mask-off-upper-bytes-of-event-response
+++ a/drivers/platform/x86/dell-wmi.c
@@ -122,7 +122,12 @@ static void dell_wmi_notify(u32 value, v
 
 	if (obj && obj->type == ACPI_TYPE_BUFFER) {
 		int *buffer = (int *)obj->buffer.pointer;
-		key = dell_wmi_get_entry_by_scancode(buffer[1]);
+		/*
+		 *  The upper bytes of the event may contain
+		 *  additional information, so mask them off for the
+		 *  scancode lookup
+		 */
+		key = dell_wmi_get_entry_by_scancode(buffer[1] & 0xFFFF);
 		if (key) {
 			input_report_key(dell_wmi_input_dev, key->keycode, 1);
 			input_sync(dell_wmi_input_dev);
_
