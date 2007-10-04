From: Carlos Corbacho <cathectic@gmail.com>
Subject: [RFC][PATCH v2] ACPI: WMI: Initial attempt at WMI ACPI interface driver
Date: Fri, 5 Oct 2007 00:37:34 +0100
Message-ID: <200710050037.35381.cathectic@slackadelic.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.174]:48679 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756252AbXJDXh2 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 4 Oct 2007 19:37:28 -0400
Received: by ug-out-1314.google.com with SMTP id z38so433903ugc
        for <linux-acpi@vger.kernel.org>; Thu, 04 Oct 2007 16:37:26 -0700 (PDT)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <lenb@kernel.org>

The following is my own basic implementation of a Windows Management
Instrumentation (WMI) ACPI interface mapper (PNP0C14).

What it does:

Parses the _WDG method and exports functions to process WMI method calls
(tested with my own hacked up version of acer_acpi), and basic data block
query/ set commands (WQxx and WSxx _not_ marked as "expensive") based on
GUID.

i.e.

wmi_evaluate_method(const char *guid, u32 instance, u32 method_id,
const struct acpi_buffer *in, struct acpi_buffer *out)

wmi_query_block(const char *guid, u32 instance, u32 method_id,
struct acpi_buffer *out)

wmi_set_block(const char *guid, u32 instance, u32 method_id, const struct
acpi_buffer *in)

It also provides a helper method to find if a GUID exists or not on the
system (a quick and easy way for WMI dependant drivers to see if the
the method/ block they want exists).

i.e.

bool find_guid(const char guid*)

Where guid is the text encoding of the guid, e.g.:

"67C3371D-95A3-4C37-BB61-DD47B491DAAB"

What it might be able to do:

Handle reading data block GUIDs marked as "expensive" (e.g. calling WCxx with
the correct arguments, before and after querying the block in question). My
DSDT does not have any such marked block methods, so this is untested.

What it can't do:

Events - I've added a notify handler, but when we get a Notify() call to
PNP0C14, what should happen next?

(The MS article[1] says something about "firing a WMI event", in conjunction
with the data from the _WED method - would the driver be expected to send an
event to proc/ netlink?).

This would also need to handle events marked as "expensive"

Unicode - The MS article calls for converting between ASCII and Unicode (or
vice versa) if a GUID is marked as "string". There is also another problem
in that given this specification revolves around Windows, Unicode in this
context likely means UTF-16. Since Linux doesn't use this, and since this
driver will only be called by other Linux drivers, it may make more sense
to treat Unicode here as UTF-8 instead.

What it doesn't do:

Try to enforce any kind of MOF 'types' on the data - it just takes and returns
acpi_buffer - interpretation is left to the caller.

[1] http://www.microsoft.com/whdc/system/pnppwr/wmi/wmi-acpi.mspx

===
ChangeLog
==

v1 (2007-10-02):

Initial release

v2 (2007-10-05):

Cleaned up code - split up super "wmi_evaluate_block" -> each external
symbol now handles its own ACPI calls, rather than handing off to
a "super" method (and in turn, is a lot simpler to read)

Added a find_guid() symbol - return true if a given GUID exists on
the system

wmi_* functions now return type acpi_status (since they are just
fancy wrappers around acpi_evaluate_object())

Removed extra debug code

Signed-off-by: Carlos Corbacho <cathectic@gmail.com>
---
 drivers/acpi/Kconfig  |   10 +
 drivers/acpi/Makefile |    1 +
 drivers/acpi/wmi.c    |  480 +++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/acpi.h  |   14 ++
 4 files changed, 505 insertions(+), 0 deletions(-)
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
index 0000000..76882e3
--- /dev/null
+++ b/drivers/acpi/wmi.c
@@ -0,0 +1,480 @@
+/*
+ *  wmi.c - WMI to ACPI mapping driver
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
+ * TODO:
+ *
+ * 1) Handle method & data blocks flagged as WMIACPI_FLAG_STRING
+ *
+ * The MS spec says that we should translate the input from "UNICODE to ASCIIZ"
+ * and the output from "ASCIIZ to UNICODE". But by UNICODE, they probably mean
+ * UTF-16, where as we are using UTF-8/ ASCII here - so, what to do? Converting
+ * to UTF-16 is probably pointless, since most of the clients of this mapper
+ * will be Linux drivers using UTF-8/ ASCII anyway, not UTF-16.
+ *
+ * So, for the moment, the mapper should just convert input from UTF-8 to ASCII
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
+#undef PREFIX
+#define PREFIX "ACPI: WMI: "
+
+MODULE_AUTHOR("Carlos Corbacho");
+MODULE_DESCRIPTION("WMI ACPI Interface Driver");
+MODULE_LICENSE("GPL");
+
+struct guid_block_t
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
+	struct guid_block_t *pointer;
+	int total;
+};
+
+static struct guid_list guids;
+static acpi_handle acpi_wmi_handle;
+
+/*
+ * If the GUID is a datablock, we must enable and explicitily disable data
+ * collection. If the GUID is an event, we must arm and reenable the event if
+ * required
+ */
+#define WMIACPI_FLAG_EXPENSIVE   0x1
+#define WMIACPI_FLAG_METHOD      0x2	/* GUID is a method */
+
+/*
+ * Data block is a string, and must be converted from ASCII to Unicode (output)
+ * or Unicode to Ascii (input)
+ */
+#define WMIACPI_FLAG_STRING      0x4
+#define WMIACPI_FLAG_EVENT       0x8	/* GUID is an event */
+
+static int acpi_wmi_remove(struct acpi_device *device, int type);
+static int acpi_wmi_add(struct acpi_device *device);
+
+const static struct acpi_device_id wmi_device_ids[] = {
+	{"PNP0C14", 0},
+	{"pnp0c14", 0},
+	{"", 0},
+};
+MODULE_DEVICE_TABLE(acpi, wmi_device_ids);
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
+/*
+ * GUID parsing functions
+ */
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
+static bool find_guid(const char *guid_string, struct guid_block_t **out)
+{
+	char tmp[16], guid_input[16];
+	struct guid_block_t *block;
+	int i;
+
+	wmi_parse_guid(guid_string, tmp);
+	wmi_swap_bytes(tmp, guid_input);
+
+	for (i = 0; i < guids.total; i++) {
+		block = guids.pointer + i;
+
+		if (memcmp(block->guid, guid_input, 16) == 0) {
+			if (out != NULL)
+				*out = block;
+			return 1;
+		}
+	}
+	return 0;
+}
+
+/*
+ * Externally callable WMI functions
+ */
+acpi_status wmi_evaluate_method(const char *guid_string, u32 instance,
+u32 method_id, const struct acpi_buffer *in, struct acpi_buffer *out)
+{
+	struct guid_block_t *block = NULL;
+	acpi_status status;
+	struct acpi_object_list input;
+	union acpi_object wm_params[3];
+	char method[4] = "WM";
+
+	if (!find_guid(guid_string, &block))
+		return AE_BAD_ADDRESS;
+
+	if (!block->flags & WMIACPI_FLAG_METHOD)
+		return AE_BAD_DATA;
+
+	input.count = 2;
+	input.pointer = wm_params;
+	wm_params[0].type = ACPI_TYPE_INTEGER;
+	wm_params[0].integer.value = instance;
+	wm_params[1].type = ACPI_TYPE_INTEGER;
+	wm_params[1].integer.value = method_id;
+
+	if (in != NULL) {
+		input.count = 3;
+		wm_params[2].type = ACPI_TYPE_BUFFER;
+		wm_params[2].buffer.length = in->length;
+		wm_params[2].buffer.pointer = in->pointer;
+	}
+
+	strncat(method, block->object_id, 2);
+	strcat(method, "\0");
+
+	status = acpi_evaluate_object(acpi_wmi_handle, method, &input, out);
+
+	if (block->flags & WMIACPI_FLAG_STRING) {
+		/* Convert output from ASCIIZ to Unicode */
+		return AE_NOT_IMPLEMENTED;
+	}
+
+	return status;
+}
+EXPORT_SYMBOL(wmi_evaluate_method);
+
+acpi_status wmi_query_block(const char *guid_string, u32 instance,
+u32 method_id, struct acpi_buffer *out)
+{
+	struct guid_block_t *block = NULL;
+	acpi_status status;
+	struct acpi_object_list input, wc_input;
+	union acpi_object wc_params[1], wq_params[1];
+	char method[4] = "WQ";
+	char wc_method[4] = "WC";
+
+	if (guid_string == NULL || out == NULL)
+		return AE_BAD_PARAMETER;
+
+	if (!find_guid(guid_string, &block))
+		return AE_BAD_ADDRESS;
+
+	/* Check GUID is a data block */
+	if ((block->flags & (WMIACPI_FLAG_EVENT | WMIACPI_FLAG_METHOD)) > 0)
+		return AE_BAD_ADDRESS;
+
+	input.count = 1;
+	input.pointer = wq_params;
+	wq_params[0].type = ACPI_TYPE_INTEGER;
+	wq_params[0].integer.value = instance;
+
+	/*
+	 * If WMIACPI_FLAG_EXPENSIVE, call the relevant WCxx method first to
+	 * enable collection
+	 */
+	/* FIXME - should INTEGER be STRING? */
+	if (block->flags & WMIACPI_FLAG_EXPENSIVE) {
+		wc_input.count = 1;
+		wc_input.pointer = wc_params;
+		wc_params[0].type = ACPI_TYPE_INTEGER;
+		wc_params[0].integer.value = instance;
+
+		strncat(wc_method, block->object_id, 2);
+		strcat(wc_method, "\0");
+
+		status = acpi_evaluate_object(acpi_wmi_handle, wc_method,
+			&wc_input, NULL);
+
+		if (ACPI_FAILURE(status))
+			return AE_ERROR;
+	}
+
+	strncat(method, block->object_id, 2);
+	strcat(method, "\0");
+
+	status = acpi_evaluate_object(acpi_wmi_handle, method, NULL, out);
+
+	/*
+	 * If WMIACPI_FLAG_EXPENSIVE, call the relevant WCxx method, even if
+	 * the WQxx method failed - we should disable collection anyway
+	 */
+	if ((block->flags & WMIACPI_FLAG_EXPENSIVE) > 0) {
+		wc_params[0].integer.value = 0x0;
+		status = acpi_evaluate_object(acpi_wmi_handle,
+		wc_method, &wc_input, NULL);
+	}
+
+	if (ACPI_SUCCESS(status)) {
+		/* Convert output from ASCIIZ to Unicode */
+		if ((block->flags & WMIACPI_FLAG_STRING) > 0)
+			return AE_NOT_IMPLEMENTED;
+	}
+
+	return status;
+}
+EXPORT_SYMBOL(wmi_query_block);
+
+acpi_status wmi_set_block(const char *guid_string, u32 instance, u32 method_id,
+const struct acpi_buffer *in)
+{
+	struct guid_block_t *block = NULL;
+	struct acpi_object_list input;
+	union acpi_object params[2];
+	char method[4] = "WS";
+
+	if (guid_string == NULL || in == NULL)
+		return AE_BAD_DATA;
+
+	if (!find_guid(guid_string, &block))
+		return AE_BAD_ADDRESS;
+
+	/* Check GUID is a data block */
+	if ((block->flags & (WMIACPI_FLAG_EVENT | WMIACPI_FLAG_METHOD)) > 0)
+		return AE_BAD_ADDRESS;
+
+	input.count = 2;
+	input.pointer = params;
+	params[0].type = ACPI_TYPE_INTEGER;
+	params[0].integer.value = instance;
+	params[1].type = ACPI_TYPE_BUFFER;
+	params[1].buffer.length = in->length;
+	params[1].buffer.pointer = in->pointer;
+
+	/* Convert input from Unicode to ASCIIZ */
+	if ((block->flags & WMIACPI_FLAG_STRING) > 0)
+		return AE_NOT_IMPLEMENTED;
+
+	strncat(method, block->object_id, 2);
+	strcat(method, "\0");
+
+	return acpi_evaluate_object(acpi_wmi_handle, method, &input, NULL);
+}
+EXPORT_SYMBOL(wmi_set_block);
+
+bool wmi_has_guid(char *guid_string)
+{
+	return find_guid(guid_string, NULL);
+}
+EXPORT_SYMBOL(wmi_has_guid);
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
+	if (ACPI_FAILURE(status))
+		return status;
+
+	obj = (union acpi_object *) out.pointer;
+
+	if (obj->type != ACPI_TYPE_BUFFER)
+		return AE_ERROR;
+
+	guids.pointer = (struct guid_block_t *) obj->buffer.pointer;
+	guids.total = obj->buffer.length / sizeof(struct guid_block_t);
+
+	return status;
+}
+
+static void acpi_wmi_notify(acpi_handle handle, u32 event, void *data)
+{
+	int i;
+	struct guid_block_t *block;
+
+	for (i = 0; i < guids.total; i++) {
+		block = guids.pointer + i;
+
+		/* FIXME - the last comparison may be broken */
+		if (block->flags & WMIACPI_FLAG_EVENT &&
+			block->notification_value == event) {
+			/*
+			 * Should we generate an event? And how do we pass the
+			 * results of _WED?
+			 */
+		}
+	}
+}
+
+static int acpi_wmi_add(struct acpi_device *device)
+{
+	acpi_status status;
+
+	acpi_wmi_handle = device->handle;
+
+	status = acpi_install_notify_handler(device->handle, ACPI_DEVICE_NOTIFY,
+		acpi_wmi_notify, device);
+
+	if (ACPI_FAILURE(status)) {
+		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
+				  "Error installing notify handler\n"));
+		return -ENODEV;
+	}
+
+	parse_wdg();
+
+	return 0;
+}
+
+static int acpi_wmi_remove(struct acpi_device *device, int type)
+{
+	acpi_remove_notify_handler(device->handle, ACPI_DEVICE_NOTIFY,
+		acpi_wmi_notify);
+
+	return 0;
+}
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
+	printk(KERN_INFO PREFIX "Interface device found\n");
+	printk(KERN_INFO PREFIX "Mapper loaded\n");
+
+	return 0;
+}
+
+static void __exit acpi_wmi_exit(void)
+{
+	acpi_bus_unregister_driver(&acpi_wmi_driver);
+	printk(KERN_INFO PREFIX "Mapper unloaded\n");
+}
+
+module_init(acpi_wmi_init);
+module_exit(acpi_wmi_exit);
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 8ccedf7..72c9609 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -186,6 +186,20 @@ extern int ec_transaction(u8 command,
 
 #endif /*CONFIG_ACPI_EC*/
 
+#ifdef CONFIG_ACPI_WMI
+
+extern acpi_status wmi_evaluate_method(const char *guid, u32 instance,
+					u32 method_id,
+					const struct acpi_buffer *in,
+					struct acpi_buffer *out);
+extern acpi_status wmi_query_block(const char *guid, u32 instance,
+					u32 method_id, struct acpi_buffer *out);
+extern acpi_status wmi_set_block(const char *guid, u32 instance, u32 method_id,
+					const struct acpi_buffer *in);
+extern bool wmi_has_guid(char *guid);
+
+#endif	/* CONFIG_ACPI_WMI */
+
 extern int acpi_blacklisted(void);
 extern void acpi_bios_year(char *s);
 
-- 
1.5.3.4

