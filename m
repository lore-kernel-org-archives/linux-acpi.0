From: Matthew Garrett <mjg@redhat.com>
Subject: [PATCH 2/4] ACPI: Add _PLD support
Date: Mon, 12 Mar 2012 19:58:53 -0400
Message-ID: <1331596735-3690-2-git-send-email-mjg@redhat.com>
References: <1331596735-3690-1-git-send-email-mjg@redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:45078 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756870Ab2CLT6v (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 12 Mar 2012 15:58:51 -0400
In-Reply-To: <1331596735-3690-1-git-send-email-mjg@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: linux-usb@vger.kernel.org, lenb@kernel.org, gregkh@linuxfoundation.org, Matthew Garrett <mjg@redhat.com>

Add a simple helper function to allow drivers to obtain the physical
device location data.

Signed-off-by: Matthew Garrett <mjg@redhat.com>
---
 drivers/acpi/utils.c    |   29 +++++++++++++++++++++++++++++
 include/acpi/acpi_bus.h |   31 +++++++++++++++++++++++++++++++
 2 files changed, 60 insertions(+)

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
index 6cd5b64..39d7de9 100644
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
1.7.9.3

