From: Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH V3 2/8] ACPI: Add _PLD support
Date: Wed,  9 May 2012 23:00:29 +0800
Message-ID: <1336575635-13120-3-git-send-email-tianyu.lan@intel.com>
References: <1336575635-13120-1-git-send-email-tianyu.lan@intel.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1336575635-13120-1-git-send-email-tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, sarah.a.sharp-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org, mfm-Oo0r1OC9pj9iLUuM0BA3LQ@public.gmane.org, Matthew Garrett <mjg-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

From: Matthew Garrett <mjg-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

Add a simple helper function to allow drivers to obtain the physical
device location data.

Acked-by: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Signed-off-by: Matthew Garrett <mjg-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Signed-off-by: Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 drivers/acpi/utils.c    |   30 ++++++++++++++++++++++++++++++
 include/acpi/acpi_bus.h |   31 +++++++++++++++++++++++++++++++
 2 files changed, 61 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/utils.c b/drivers/acpi/utils.c
index b002a47..adbbc1c 100644
--- a/drivers/acpi/utils.c
+++ b/drivers/acpi/utils.c
@@ -382,3 +382,33 @@ acpi_evaluate_reference(acpi_handle handle,
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
+EXPORT_SYMBOL(acpi_get_physical_device_location);
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index c909984..b0d6282 100644
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
+} __attribute__((__packed__));
+
+acpi_status
+acpi_get_physical_device_location(acpi_handle handle, struct acpi_pld *pld);
 #ifdef CONFIG_ACPI
 
 #include <linux/proc_fs.h>
-- 
1.7.6.rc2.8.g28eb

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
