From: Feng Tang <feng.tang@intel.com>
Subject: [PATCH V2 1/2] ACPI: Use ACPICA native way to decode the PLD buffer
Date: Wed, 22 Aug 2012 16:35:23 +0800
Message-ID: <20120822163523.2b0199bb@feng-i7>
References: <1345616676-30915-1-git-send-email-feng.tang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:16141 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751750Ab2HVIkw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 22 Aug 2012 04:40:52 -0400
In-Reply-To: <1345616676-30915-1-git-send-email-feng.tang@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: len.brown@intel.com, linux-acpi@vger.kernel.org
Cc: mjg@redhat.com, tianyu.lan@intel.com, gregkh@linuxfoundation.org, Bob Moore <robert.moore@intel.com>

>From 5304644dc5fde58289e7665ab135c74b3e302ba1 Mon Sep 17 00:00:00 2001
From: Feng Tang <feng.tang@intel.com>
Date: Tue, 21 Aug 2012 09:56:58 +0800
Subject: [PATCH V2 1/2] ACPI: Use ACPICA native way to decode the PLD buffer

This patch is on top of the ACPICA 20120816 release, which implemented
a native way to decode PLD buffer, so use it instead of leting upper
level users do the decoding.

v2: Modify the check for PLD buffer length to reject buffers whose
length < 16

Signed-off-by: Feng Tang <feng.tang@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/utils.c    |   11 +++++++----
 include/acpi/acpi_bus.h |   31 +------------------------------
 2 files changed, 8 insertions(+), 34 deletions(-)

diff --git a/drivers/acpi/utils.c b/drivers/acpi/utils.c
index 3e87c9c..462f7e3 100644
--- a/drivers/acpi/utils.c
+++ b/drivers/acpi/utils.c
@@ -384,7 +384,7 @@ acpi_evaluate_reference(acpi_handle handle,
 EXPORT_SYMBOL(acpi_evaluate_reference);
 
 acpi_status
-acpi_get_physical_device_location(acpi_handle handle, struct acpi_pld *pld)
+acpi_get_physical_device_location(acpi_handle handle, struct acpi_pld_info **pld)
 {
 	acpi_status status;
 	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
@@ -400,13 +400,16 @@ acpi_get_physical_device_location(acpi_handle handle, struct acpi_pld *pld)
 	if (!output || output->type != ACPI_TYPE_PACKAGE
 	    || !output->package.count
 	    || output->package.elements[0].type != ACPI_TYPE_BUFFER
-	    || output->package.elements[0].buffer.length > sizeof(*pld)) {
+	    || output->package.elements[0].buffer.length < ACPI_PLD_REV1_BUFFER_SIZE) {
 		status = AE_TYPE;
 		goto out;
 	}
 
-	memcpy(pld, output->package.elements[0].buffer.pointer,
-	       output->package.elements[0].buffer.length);
+	status = acpi_decode_pld_buffer(
+			output->package.elements[0].buffer.pointer,
+			output->package.elements[0].buffer.length,
+			pld);
+
 out:
 	kfree(buffer.pointer);
 	return status;
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index bde976e..0c1fcd4 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -54,37 +54,8 @@ acpi_status
 acpi_evaluate_hotplug_ost(acpi_handle handle, u32 source_event,
 			u32 status_code, struct acpi_buffer *status_buf);
 
-struct acpi_pld {
-	unsigned int revision:7; /* 0 */
-	unsigned int ignore_colour:1; /* 7 */
-	unsigned int colour:24; /* 8 */
-	unsigned int width:16; /* 32 */
-	unsigned int height:16; /* 48 */
-	unsigned int user_visible:1; /* 64 */
-	unsigned int dock:1; /* 65 */
-	unsigned int lid:1; /* 66 */
-	unsigned int panel:3; /* 67 */
-	unsigned int vertical_pos:2; /* 70 */
-	unsigned int horizontal_pos:2; /* 72 */
-	unsigned int shape:4; /* 74 */
-	unsigned int group_orientation:1; /* 78 */
-	unsigned int group_token:8; /* 79 */
-	unsigned int group_position:8; /* 87 */
-	unsigned int bay:1; /* 95 */
-	unsigned int ejectable:1; /* 96 */
-	unsigned int ospm_eject_required:1; /* 97 */
-	unsigned int cabinet_number:8; /* 98 */
-	unsigned int card_cage_number:8; /* 106 */
-	unsigned int reference:1; /* 114 */
-	unsigned int rotation:4; /* 115 */
-	unsigned int order:5; /* 119 */
-	unsigned int reserved:4; /* 124 */
-	unsigned int vertical_offset:16; /* 128 */
-	unsigned int horizontal_offset:16; /* 144 */
-} __attribute__((__packed__));
-
 acpi_status
-acpi_get_physical_device_location(acpi_handle handle, struct acpi_pld *pld);
+acpi_get_physical_device_location(acpi_handle handle, struct acpi_pld_info **pld);
 #ifdef CONFIG_ACPI
 
 #include <linux/proc_fs.h>
-- 
1.7.1
