From: Lan Tianyu <tianyu.lan@intel.com>
Subject: [Resend PATCH V2 1/7] ACPI: Add _PLD support
Date: Fri,  4 May 2012 11:06:37 +0800
Message-ID: <1336100803-28353-2-git-send-email-tianyu.lan@intel.com>
References: <1336100803-28353-1-git-send-email-tianyu.lan@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:16894 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751000Ab2EDDMr (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 3 May 2012 23:12:47 -0400
In-Reply-To: <1336100803-28353-1-git-send-email-tianyu.lan@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org, gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org, linux-acpi@vger.kernel.org, stern@rowland.harvard.edu, sarah.a.sharp@linux.intel.com, mjg59@srcf.ucam.org, mfm@muteddisk.com, Matthew Garrett <mjg@redhat.com>

From: Matthew Garrett <mjg@redhat.com>

Add a simple helper function to allow drivers to obtain the physical
device location data.

Signed-off-by: Matthew Garrett <mjg@redhat.com>
---
 drivers/acpi/utils.c    |   29 +++++++++++++++++++++++++++++
 include/acpi/acpi_bus.h |   31 +++++++++++++++++++++++++++++++
 2 files changed, 60 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/utils.c b/drivers/acpi/utils.c
index b002a47..5c320a0 100644
--- a/drivers/acpi/utils.c
+++ b/drivers/acpi/utils.c
@@ -382,3 +382,32 @@ acpi_evaluate_reference(acpi_handle handle,
 }
 
 EXPORT_SYMBOL(acpi_evaluate_reference);
+
+acpi_status
+acpi_get_physical_device_location(acpi_handle handle, struct acpi_pld *pld)
+{
+	acpi_status status;
+	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
+	union acpi_object *output;
+
+	status = acpi_evaluate_object(handle, "_PLD", NULL, &buffer);
+
+	if (ACPI_FAILURE(status))
+		return status;
+
+	output = buffer.pointer;
+
+	if (!output || output->type != ACPI_TYPE_PACKAGE
+	    || !output->package.count
+	    || output->package.elements[0].type != ACPI_TYPE_BUFFER
+	    || output->package.elements[0].buffer.length > sizeof(*pld)) {
+		status = AE_TYPE;
+		goto out;
+	}
+
+	memcpy(pld, output->package.elements[0].buffer.pointer,
+	       output->package.elements[0].buffer.length);
+out:
+	kfree(buffer.pointer);
+	return status;
+}
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index f1c8ca6..2642744 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -51,6 +51,37 @@ acpi_evaluate_reference(acpi_handle handle,
 			struct acpi_object_list *arguments,
 			struct acpi_handle_list *list);
 
+struct acpi_pld {
+	unsigned int revision:7; /* 0 */
+	unsigned int ignore_colour:1; /* 7 */
+	unsigned int colour:24; /* 8 */
+	unsigned int width:16; /* 32 */
+	unsigned int height:16; /* 48 */
+	unsigned int user_visible:1; /* 64 */
+	unsigned int dock:1; /* 65 */
+	unsigned int lid:1; /* 66 */
+	unsigned int panel:3; /* 67 */
+	unsigned int vertical_pos:2; /* 70 */
+	unsigned int horizontal_pos:2; /* 72 */
+	unsigned int shape:4; /* 74 */
+	unsigned int group_orientation:1; /* 78 */
+	unsigned int group_token:8; /* 79 */
+	unsigned int group_position:8; /* 87 */
+	unsigned int bay:1; /* 95 */
+	unsigned int ejectable:1; /* 96 */
+	unsigned int ospm_eject_required:1; /* 97 */
+	unsigned int cabinet_number:8; /* 98 */
+	unsigned int card_cage_number:8; /* 106 */
+	unsigned int reference:1; /* 114 */
+	unsigned int rotation:4; /* 115 */
+	unsigned int order:5; /* 119 */
+	unsigned int reserved:4; /* 124 */
+	unsigned int vertical_offset:16; /* 128 */
+	unsigned int horizontal_offset:16; /* 144 */
+};
+
+acpi_status
+acpi_get_physical_device_location(acpi_handle handle, struct acpi_pld *pld);
 #ifdef CONFIG_ACPI
 
 #include <linux/proc_fs.h>
-- 
1.7.6.rc2.8.g28eb

