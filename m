From: Carlos Corbacho <cathectic@gmail.com>
Subject: [RFC][PATCH] ACPI: wmi: Initial attempt at WMI ACPI support
Date: Tue, 2 Oct 2007 11:37:25 +0100
Message-ID: <200710021137.25519.cathectic@slackadelic.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.186]:30656 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751738AbXJBKhd (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 2 Oct 2007 06:37:33 -0400
Received: by nf-out-0910.google.com with SMTP id g13so3198223nfb
        for <linux-acpi@vger.kernel.org>; Tue, 02 Oct 2007 03:37:31 -0700 (PDT)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <lenb@kernel.org>

The following is my own basic implementation of the Windows Management 
Instrumentation (WMI) ACPI interface.

What it does:

Parses the _WDG method and exports functions to process WMI method calls 
(tested with my own hacked up version of acer_acpi), and basic query/ set 
commands (WQxx and WSxx _not_ marked as "expensive") based on GUID.

i.e.

wmi_evaluate_method(char *guid, u32 instance, u32 method_id, const struct 
acpi_buffer *in, struct acpi_buffer *out)

wmi_query_block(char *guid, u32 instance, u32 method_id, struct acpi_buffer 
*out)

wmi_set_block(char *guid, u32 instance, u32 method_id, const struct 
acpi_buffer *in)

Where guid is the text encoding of the guid, e.g.:

"67C3371D-95A3-4C37-BB61-DD47B491DAAB"

What it might be able to do:

Handle reading data block GUIDs marked as "expensive" (e.g. calling WCxx with 
the correct arguments, before and after querying the block in question). My 
DSDT does not have any, so this is untested.

What it can't do:

Events - I've added a notify handler, but when we get a Notify() call to 
PNP0C14, what should happen next?

(The MS article[1] says something about "firing a WMI event", in conjunction 
with the data from the _WED method - would the driver be expected to send an 
event to proc/ netlink?).

This would also need to handle events marked as "expensive"

Unicode - The MS article calls for converting between ASCII and Unicode (or 
vice versa) if a GUID is marked as "string".

What it doesn't do:

Try to enforce any kind of MOF 'types' on the data - it just takes and returns 
acpi_buffer - interpretation is left to the end user.

What I would like to add:

A function that would return true if a given GUID exists on the system (for 
acer_acpi, this would make it much easier to distinguish between the two 
different WMI ACPI interfaces we support, rather than having to use 
wmi_evaluate_method(), which is overkill).

e.g.

bool wmi_guid_exists(char *guid)

[1] http://www.microsoft.com/whdc/system/pnppwr/wmi/wmi-acpi.mspx

Signed-off-by: Carlos Corbacho <cathectic@gmail.com>
---
 drivers/acpi/Kconfig  |   10 +
 drivers/acpi/Makefile |    1 +
 drivers/acpi/wmi.c    |  502 
+++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/acpi.h  |   11 +
 4 files changed, 524 insertions(+), 0 deletions(-)
 create mode 100644 drivers/acpi/wmi.c

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 9685b75..b2074c3 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -179,6 +179,16 @@ config ACPI_NUMA
 	depends on (X86 || IA64)
 	default y if IA64_GENERIC || IA64_SGI_SN2
 
+config ACPI_WMI
+	tristate "WMI ACPI Interface (EXPERIMENTAL)"
+	depends on EXPERIMENTAL
+	help
+	  This driver adds support for the WMI ACPI device (PNP0C14) found on
+	  some systems.
+
+	  NOTE: You will need another driver on top of this to actually use
+	  anything defined in the WMI ACPI device.
+
 config ACPI_ASUS
         tristate "ASUS/Medion Laptop Extras"
 	depends on X86
diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index 54e3ab0..9e9aa39 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -55,6 +55,7 @@ obj-$(CONFIG_ACPI_THERMAL)	+= thermal.o
 obj-$(CONFIG_ACPI_SYSTEM)	+= system.o event.o
 obj-$(CONFIG_ACPI_DEBUG)	+= debug.o
 obj-$(CONFIG_ACPI_NUMA)		+= numa.o
+obj-$(CONFIG_ACPI_WMI)		+= wmi.o
 obj-$(CONFIG_ACPI_ASUS)		+= asus_acpi.o
 obj-$(CONFIG_ACPI_TOSHIBA)	+= toshiba_acpi.o
 obj-$(CONFIG_ACPI_HOTPLUG_MEMORY)	+= acpi_memhotplug.o
diff --git a/drivers/acpi/wmi.c b/drivers/acpi/wmi.c
new file mode 100644
index 0000000..f0a56c3
--- /dev/null
+++ b/drivers/acpi/wmi.c
@@ -0,0 +1,502 @@
+/*
+ *  wmi.c - WMI ACPI interface device
+ *
+ *  Copyright (C) 2007 Carlos Corbacho <cathectic@gmail.com>
+ *
+ *  GUID parsing code from ldm.c is:
+ *   Copyright (C) 2001,2002 Richard Russon <ldm@flatcap.org>
+ *   Copyright (c) 2001-2007 Anton Altaparmakov
+ *   Copyright (C) 2001,2002 Jakob Kemi <jakob.kemi@telia.com>
+ *
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or (at
+ *  your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful, but
+ *  WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.
+ *
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ *
+ * TODO -
+ *
+ * 1) Handle WMIACPI_FLAG_STRING
+ *
+ * 2) Handle WMIACPI_FLAG_EVENT - What should we do with the events? We would
+ *    also need to handle WExx (expensive events)
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/types.h>
+#include <acpi/acpi_drivers.h>
+
+#define ACPI_WMI_CLASS			"wmi"
+
+#define WMI_LOGPREFIX "wmi: "
+#define WMI_ERR KERN_ERR WMI_LOGPREFIX
+#define WMI_NOTICE KERN_NOTICE WMI_LOGPREFIX
+#define WMI_INFO KERN_INFO WMI_LOGPREFIX
+
+#define DEBUG(level, message...) { \
+	if (debug >= level) \
+		printk(KERN_DEBUG WMI_LOGPREFIX message);\
+}
+
+MODULE_AUTHOR("Carlos Corbacho");
+MODULE_DESCRIPTION("ACPI WMI Interface Driver");
+MODULE_LICENSE("GPL");
+
+struct guid_mapping
+{
+	char guid[16];
+	union
+	{
+		char object_id[2];
+		struct
+		{
+			unsigned char notification_value;
+			unsigned char reserved;
+		};
+	};
+	u8 instance_count;
+	u8 flags;
+};
+
+struct guid_list
+{
+	struct guid_mapping *pointer;
+	int total;
+};
+
+static struct guid_list guids;
+static acpi_handle acpi_wmi_handle;
+static int debug;
+
+module_param(debug, int, 0664);
+MODULE_PARM_DESC(debug, "Debugging verbosity level (0=least 2=most)");
+
+/*
+ * If the GUID is a datablock, we must enable and explicitily disable data
+ * collection. If the GUID is an event, we must arm and reenable the event if
+ * required
+ */
+#define WMIACPI_FLAG_EXPENSIVE   0x1
+
+/* Set if GUID is a method (not an event or data block) */
+#define WMIACPI_FLAG_METHOD      0x2
+
+/*
+ * Set if data block is a string, and must be converted from ASCII to Unicode
+ * (output) or Unicode to Ascii (input)
+ */
+#define WMIACPI_FLAG_STRING      0x04
+
+/* Set if GUID is an event (not a method or data block) */
+#define WMIACPI_FLAG_EVENT       0x08
+
+/**
+ * wmi_parse_hexbyte - Convert a ASCII hex number to a byte
+ * @src:  Pointer to at least 2 characters to convert.
+ *
+ * Convert a two character ASCII hex string to a number.
+ *
+ * Return:  0-255  Success, the byte was parsed correctly
+ *          -1     Error, an invalid character was supplied
+ */
+static int wmi_parse_hexbyte(const u8 *src)
+{
+	unsigned int x;		/* For correct wrapping */
+	int h;
+
+	/* high part */
+	if      ((x = src[0] - '0') <= '9'-'0') h = x;
+	else if ((x = src[0] - 'a') <= 'f'-'a') h = x+10;
+	else if ((x = src[0] - 'A') <= 'F'-'A') h = x+10;
+	else return -1;
+	h <<= 4;
+
+	/* low part */
+	if ((x = src[1] - '0') <= '9'-'0') return h | x;
+	if ((x = src[1] - 'a') <= 'f'-'a') return h | (x+10);
+	if ((x = src[1] - 'A') <= 'F'-'A') return h | (x+10);
+	return -1;
+}
+
+/**
+ * wmi_swap_bytes - Rearrange GUID bytes to match GUID binary
+ * @src:   Memory block holding binary GUID (16 bytes)
+ * @dest:  Memory block to hold byte swapped binary GUID (16 bytes)
+ *
+ * Byte swap a binary GUID to match it's real GUID value
+ */
+static void wmi_swap_bytes(u8 *src, u8 *dest)
+{
+	int i;
+
+	for (i = 0; i <= 3; i++)
+		memcpy(dest + i, src + (3 - i), 1);
+
+	for (i = 0; i <= 1; i++)
+		memcpy(dest + 4 + i, src + (5 - i), 1);
+
+	for (i = 0; i <= 1; i++)
+		memcpy(dest + 6 + i, src + (7 - i), 1);
+
+	memcpy(dest + 8, src + 8, 8);
+}
+
+/**
+ * wmi_parse_guid - Convert GUID from ASCII to binary
+ * @src:   36 char string of the form fa50ff2b-f2e8-45de-83fa-65417f2f49ba
+ * @dest:  Memory block to hold binary GUID (16 bytes)
+ *
+ * N.B. The GUID need not be NULL terminated.
+ *
+ * Return:  'true'   @dest contains binary GUID
+ *          'false'  @dest contents are undefined
+ */
+static bool wmi_parse_guid(const u8 *src, u8 *dest)
+{
+	static const int size[] = { 4, 2, 2, 2, 6 };
+	int i, j, v;
+
+	if (src[8]  != '-' || src[13] != '-' ||
+		src[18] != '-' || src[23] != '-')
+		return false;
+
+	for (j = 0; j < 5; j++, src++)
+		for (i = 0; i < size[j]; i++, src += 2, *dest++ = v)
+			if ((v = wmi_parse_hexbyte (src)) < 0)
+				return false;
+
+	return true;
+}
+
+const static struct acpi_device_id wmi_device_ids[] = {
+	{"PNP0C14", 0},
+	{"pnp0c14", 0},
+	{"", 0},
+};
+MODULE_DEVICE_TABLE(acpi, wmi_device_ids);
+
+static acpi_status wmi_evaluate_object(struct guid_mapping *block, u32 
instance,
+	u32 method_id, const struct acpi_buffer *in, struct acpi_buffer *out)
+{
+	acpi_status status;
+	struct acpi_object_list input, wc_input;
+	union acpi_object wm_params[3], wc_params[1], wq_params[1],
+		ws_params[2];
+	char method[4] = "";
+	char wc_method[4] = "";
+
+	if (block->flags & WMIACPI_FLAG_METHOD) {
+		strcat(method, "WM");
+		input.count = 3;
+		input.pointer = wm_params;
+		wm_params[0].type = ACPI_TYPE_INTEGER;
+		wm_params[0].integer.value = instance;
+		wm_params[1].type = ACPI_TYPE_INTEGER;
+		wm_params[1].integer.value = method_id;
+
+		if (in != NULL) {
+			wm_params[2].type = ACPI_TYPE_BUFFER;
+			wm_params[2].buffer.length = in->length;
+			wm_params[2].buffer.pointer = in->pointer;
+		}
+	} else {
+		/* Data block */
+		if (in == NULL) {
+			/* Query/ collection */
+
+			strcat(method, "WQ");
+			input.count = 1;
+			input.pointer = wq_params;
+			wq_params[0].type = ACPI_TYPE_INTEGER;
+			wq_params[0].integer.value = instance;
+
+			/*
+	 		 * If WMIACPI_FLAG_EXPENSIVE, call the relevant WCxx
+	 		 * method first to enable collection
+	 		 */
+			/* FIXME - should INTEGER be STRING? */
+			if (block->flags & WMIACPI_FLAG_EXPENSIVE) {
+				wc_input.count = 1;
+				wc_input.pointer = wc_params;
+				wc_params[0].type = ACPI_TYPE_INTEGER;
+				wc_params[0].integer.value = instance;
+
+				strcat(wc_method, "WC");
+				strncat(wc_method, block->object_id, 2);
+
+				status = acpi_evaluate_object(acpi_wmi_handle,
+					wc_method, &wc_input, NULL);
+			}
+		} else if (out == NULL) {
+			/* Set */
+
+			strcat(method, "WS");
+			input.count = 2;
+			input.pointer = ws_params;
+			ws_params[0].type = ACPI_TYPE_INTEGER;
+			ws_params[0].integer.value = instance;
+			ws_params[1].type = ACPI_TYPE_BUFFER;
+			ws_params[1].buffer.length = in->length;
+			ws_params[1].buffer.pointer = in->pointer;
+
+			if (block->flags & WMIACPI_FLAG_STRING) {
+				/* Convert input from Unicode to ASCIIZ */
+			return AE_NOT_IMPLEMENTED;
+			}
+		}
+	}
+
+	strncat(method, block->object_id, 2);
+	DEBUG(2, "Object to call is %s \n", method);
+
+	status = acpi_evaluate_object(acpi_wmi_handle, method, &input, out);
+
+	if (in == NULL) {
+		/* If WMIACPI_FLAG_EXPENSIVE, call the relevant WCxx method */
+		if (block->flags & WMIACPI_FLAG_EXPENSIVE) {
+			wc_params[0].integer.value = 0x0;
+
+			status = acpi_evaluate_object(acpi_wmi_handle,
+				wc_method, &wc_input, NULL);
+		}
+
+		if (block->flags & WMIACPI_FLAG_STRING) {
+			/* Convert output from ASCIIZ to Unicode */
+		return AE_NOT_IMPLEMENTED;
+		}
+	}
+
+	return status;
+}
+
+static acpi_status wmi_evaluate_block(char *guid_string, u32 instance,
+	u32 method_id, const struct acpi_buffer *in,
+	struct acpi_buffer *out, bool query)
+{
+	char tmp[16], guid_input[16];
+	struct guid_mapping *block;
+	int i;
+
+	DEBUG(2, "Passing GUID to parser\n");
+	wmi_parse_guid(guid_string, tmp);
+	wmi_swap_bytes(tmp, guid_input);
+
+	for (i = 0; i < guids.total; i++) {
+		block = guids.pointer + i;
+
+		if (memcmp(block->guid, guid_input, 16) == 0) {
+			if (!(block->flags & WMIACPI_FLAG_EVENT) &&
+					!(block->flags & WMIACPI_FLAG_METHOD)) {
+				DEBUG(2, "GUID is a data block\n");
+				if (query) {
+					return wmi_evaluate_object(block,
+						instance, method_id, NULL, out);
+				} else {
+					return wmi_evaluate_object(block,
+						instance, method_id, in, NULL);
+				}
+			} else {
+				DEBUG(2, "GUID is not a data block\n");
+				return AE_BAD_DATA;
+			}
+		} else {
+			DEBUG(0, "Failed to match GUID\n");
+		}
+	}
+
+	DEBUG(2, "Unable to match GUID\n");
+	return AE_BAD_ADDRESS;
+}
+
+/*
+ * Externally callable WMI functions
+ */
+int wmi_evaluate_method(char *guid_string, u32 instance, u32 method_id,
+	const struct acpi_buffer *in, struct acpi_buffer *out)
+{
+	char tmp[16], guid_input[16];
+	struct guid_mapping *block;
+	int i;
+
+	DEBUG(2, "Passing GUID to parser\n");
+	wmi_parse_guid(guid_string, tmp);
+	wmi_swap_bytes(tmp, guid_input);
+
+	for (i = 0; i < guids.total; i++) {
+		block = guids.pointer + i;
+
+		if (memcmp(block->guid, guid_input, 16) == 0) {
+			if (block->flags & WMIACPI_FLAG_METHOD) {
+				DEBUG(2, "GUID is a method\n");
+				return wmi_evaluate_object(block, instance,
+					method_id, in, out);
+			} else {
+				DEBUG(2, "GUID is not a method\n");
+				return AE_BAD_DATA;
+			}
+		}
+	}
+
+	DEBUG(2, "Unable to match GUID\n");
+	return AE_BAD_ADDRESS;
+}
+EXPORT_SYMBOL(wmi_evaluate_method);
+
+int wmi_query_block(char *guid_string, u32 instance, u32 method_id,
+	struct acpi_buffer *out)
+{
+	return wmi_evaluate_block(guid_string, instance,
+		method_id, NULL, out, 1);
+}
+EXPORT_SYMBOL(wmi_query_block);
+
+int wmi_set_block(char *guid_string, u32 instance, u32 method_id,
+	const struct acpi_buffer *in)
+{
+	return wmi_evaluate_block(guid_string, instance,
+		method_id, in, NULL, 0);
+}
+EXPORT_SYMBOL(wmi_set_block);
+
+/*
+ * Parse the _WDG method for the data blocks
+ */
+static int parse_wdg(void)
+{
+	struct acpi_buffer out = {ACPI_ALLOCATE_BUFFER, NULL};
+	union acpi_object *obj;
+	acpi_status status;
+
+	status = acpi_evaluate_object(acpi_wmi_handle, "_WDG", NULL, &out);
+
+	if (ACPI_FAILURE(status)) {
+		DEBUG(2, "Problem with evaluating _WDG\n");
+		return status;
+	}
+
+	obj = (union *acpi_object) out.pointer;
+
+	if (obj->type != ACPI_TYPE_BUFFER) {
+		DEBUG(2, "Output is not a buffer\n");
+		return AE_ERROR;
+	}
+
+	DEBUG(2, "Size of _WDG output is %d bytes\n", obj->buffer.length);
+
+	guids.pointer = (struct *guid_mapping) obj->buffer.pointer;
+
+	DEBUG(2, "GUID blocks = %lu \n", obj->buffer.length /
+		sizeof(struct guid_mapping));
+	guids.total = obj->buffer.length / sizeof(struct guid_mapping);
+	return AE_OK;
+}
+
+static void acpi_wmi_notify(acpi_handle handle, u32 event, void *data)
+{
+	int i;
+	struct guid_mapping *block;
+	struct acpi_device *device = NULL;
+
+	DEBUG(1, "Notifier triggered\n");
+
+	for (i = 0; i < guids.total; i++) {
+		block = guids.pointer + i;
+
+		/* FIXME - the last comparison may be broken */
+		if (block->flags & WMIACPI_FLAG_EVENT
+			&& block->notification_value == event)
+			/*
+			 * What now? Should we generate an event? And how do we
+			 * pass the results of _WED?
+			 */
+	}
+}
+
+static int acpi_wmi_add(struct acpi_device *device)
+{
+	acpi_status status;
+
+	DEBUG(2, "acpi_wmi_add called\n");
+	acpi_wmi_handle = device->handle;
+	parse_wdg();
+
+	status = acpi_install_notify_handler(device->handle, ACPI_DEVICE_NOTIFY,
+		acpi_wmi_notify, device);
+
+	if (ACPI_FAILURE(status)) {
+		DEBUG(1, "Error installing notify handler\n");
+		/* FIXME - Is this critical enough to justify bailing out? */
+	} else {
+		DEBUG(1, "Notify handler installed\n");
+	}
+
+	return AE_OK;
+}
+
+static int acpi_wmi_remove(struct acpi_device *device, int type)
+{
+	acpi_status status;
+
+	status = acpi_remove_notify_handler(device->handle, ACPI_DEVICE_NOTIFY,
+		acpi_wmi_notify);
+
+	if (ACPI_FAILURE(status)) {
+		DEBUG(1, "Error removing notification handler\n");
+	} else {
+		DEBUG(1, "Notification handler installed\n");
+	}
+
+	return AE_OK;
+}
+
+static struct acpi_driver acpi_wmi_driver = {
+	.name = "wmi",
+	.class = ACPI_WMI_CLASS,
+	.ids = wmi_device_ids,
+	.ops = {
+		.add = acpi_wmi_add,
+		.remove = acpi_wmi_remove,
+		},
+};
+
+static int __init acpi_wmi_init(void)
+{
+	int result;
+
+	if (acpi_disabled)
+		return -ENODEV;
+
+	result = acpi_bus_register_driver(&acpi_wmi_driver);
+
+	if (result < 0)
+		return -ENODEV;
+
+	DEBUG(1, "WMI succesfully loaded\n");
+
+	return 0;
+}
+
+static void __exit acpi_wmi_exit(void)
+{
+	acpi_bus_unregister_driver(&acpi_wmi_driver);
+	DEBUG(1, "WMI unloaded\n");
+
+	return;
+}
+
+module_init(acpi_wmi_init);
+module_exit(acpi_wmi_exit);
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index bf5e000..1017c26 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -186,6 +186,17 @@ extern int ec_transaction(u8 command,
 
 #endif /*CONFIG_ACPI_EC*/
 
+#ifdef CONFIG_ACPI_WMI
+
+extern int wmi_evaluate_method(char *guid, u32 instance, u32 methodId,
+	const struct acpi_buffer *in, struct acpi_buffer *out);
+extern int wmi_query_block(char *guid, u32 instance, u32 methodId,
+	struct acpi_buffer *out);
+extern int wmi_set_block(char *guid, u32 instance, u32 methodId,
+	const struct acpi_buffer *in);
+
+#endif	/* CONFIG_ACPI_WMI */
+
 extern int acpi_blacklisted(void);
 extern void acpi_bios_year(char *s);
 
-- 
1.5.2.2






