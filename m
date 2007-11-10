From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: [PATCH 1/3] ACPI: WMI: Add WMI-ACPI mapper driver
Date: Sat, 10 Nov 2007 15:33:57 +0000
Message-ID: <200711101533.58747.carlos@strangeworlds.co.uk>
References: <200711101532.07531.carlos@strangeworlds.co.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from slackadelic.com ([65.196.224.53]:53564 "EHLO
	mail.slackadelic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751508AbXKJPeW (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 10 Nov 2007 10:34:22 -0500
In-Reply-To: <200711101532.07531.carlos@strangeworlds.co.uk>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <lenb@kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>, "Nashif, Anas" <anas.nashif@intel.com>

From: Carlos Corbacho <cathectic@gmail.com>

The following is an implementation of the Windows Management
Instrumentation (WMI) ACPI interface mapper (PNP0C14).

What it does:

Parses the _WDG method and exports functions to process WMI method calls,
data block query/ set commands (both based on GUID) and does basic event
handling.

How: WMI presents two interfaces, an in kernel API and a userspace
sysfs API.

Kernel: (essentially, a minimal wrapper around ACPI)

(const char *guid assume the 36 character ASCII representation of
a GUID - e.g. 67C3371D-95A3-4C37-BB61-DD47B491DAAB)

wmi_evaluate_method(const char *guid, u8 instance, u32 method_id,
const struct acpi_buffer *in, struct acpi_buffer *out)

wmi_query_block(const char *guid, u8 instance,
struct acpi_buffer *out)

wmi_set_block(const char *guid, u38 instance,
const struct acpi_buffer *in)

wmi_install_notify_handler(acpi_notify_handler handler);

wmi_remove_notify_handler(void);

wmi_get_event_data(u32 event, struct acpi_buffer *out)

wmi_has_guid(const char guid*)

wmi_has_guid() is a helper function to find if a GUID exists or not on the
system (a quick and easy way for WMI dependant drivers to see if the
the method/ block they want exists, since GUIDs are supposed to be unique).

Event handling - allow a WMI based driver to register a notifier handler
with WMI. When a notification is sent to WMI, the handler registered with
WMI is then called (it is left to the caller to ask for the WMI event data,
if needed).

What it can't do:

Unicode - The MS article[1] calls for converting between ASCII and Unicode (or
vice versa) if a GUID is marked as "string". There is also another problem
in that given this specification revolves around Windows, Unicode in this
context likely means UTF-16. Since Linux doesn't use this, and since this
driver will only be called by on Linux, it may make more sense to treat
Unicode here as UTF-8 instead.

What it won't do:

Handle a MOF[1] - the WMI mapper just exports methods, data and events to
userspace. MOF handling is down to userspace.

[1] http://www.microsoft.com/whdc/system/pnppwr/wmi/wmi-acpi.mspx

===
ChangeLog
==

v1 (2007-10-02):

* Initial release

v2 (2007-10-05):

* Cleaned up code - split up super "wmi_evaluate_block" -> each external
  symbol now handles its own ACPI calls, rather than handing off to
  a "super" method (and in turn, is a lot simpler to read)
* Added a find_guid() symbol - return true if a given GUID exists on
  the system
* wmi_* functions now return type acpi_status (since they are just
  fancy wrappers around acpi_evaluate_object())
* Removed extra debug code

v3 (2007-10-27)

* More code clean up - now passes checkpatch.pl
* Change data block calls - ref MS spec, method ID is not required for
  them, so drop it from the function parameters.
* Const'ify guid in the function call parameters.
* Fix _WDG buffer handling - copy the data to our own private structure.
* Change WMI from tristate to bool - otherwise the external functions are
  not exported in linux/acpi.h if you try to build WMI as a module.
* Fix more flag comparisons.
* Add a maintainers entry - since I wrote this, I should take the blame
  for it.

v4 (2007-10-30)

* Add missing brace from after fixing checkpatch errors.
* Rewrote event handling - allow external drivers to register with WMI to
  handle WMI events
* Clean up flags and sanitise flag handling

v5 (2007-11-03)

* Add sysfs interface for userspace. Export events over netlink again.
* Remove module left overs, fully convert to built-in driver.
* Tweak in-kernel API to use u8 for instance, since this is what the GUID
  blocks use (so instance cannot be greater than u8).
* Export wmi_get_event_data() for in kernel WMI drivers.

v6 (2007-11-07)

* Split out userspace into a different patch

Signed-off-by: Carlos Corbacho <cathectic@gmail.com>
---
 MAINTAINERS           |    7 +
 drivers/acpi/Kconfig  |   11 +
 drivers/acpi/Makefile |    1 +
 drivers/acpi/wmi.c    |  576 +++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/acpi.h  |   17 ++
 5 files changed, 612 insertions(+), 0 deletions(-)
 create mode 100644 drivers/acpi/wmi.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 1c7c229..493ba64 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -261,6 +261,13 @@ L:	linux-acpi@vger.kernel.org
 W:	http://acpi.sourceforge.net/
 S:	Supported
 
+ACPI WMI DRIVER
+P:      Carlos Corbacho
+M:      cathectic@gmail.com
+L:      linux-acpi@vger.kernel.org
+W:      http://www.lesswatts.org/projects/acpi/
+S:      Supported
+
 ADM1025 HARDWARE MONITOR DRIVER
 P:	Jean Delvare
 M:	khali@linux-fr.org
diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index da3a08f..3bdcfcf 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -181,6 +181,17 @@ config ACPI_NUMA
 	depends on (X86 || IA64)
 	default y if IA64_GENERIC || IA64_SGI_SN2
 
+config ACPI_WMI
+	bool "WMI (EXPERIMENTAL)"
+	depends on EXPERIMENTAL
+	default y
+	help
+	  This driver adds support for the WMI ACPI mapper device (PNP0C14)
+	  found on some systems.
+
+	  NOTE: You will need another driver or userspace application on top of
+	  this to actually use anything defined in the WMI ACPI mapper.
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
index 0000000..88b326b
--- /dev/null
+++ b/drivers/acpi/wmi.c
@@ -0,0 +1,576 @@
+/*
+ *  WMI to ACPI mapping driver
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
+ * Handle method & data blocks flagged as ACPI_WMI_STRING:
+ *
+ * The MS spec says that we should translate the input from "UNICODE to ASCIIZ"
+ * and the output from "ASCIIZ to UNICODE". But by UNICODE, they probably mean
+ * UTF-16, where as we are using UTF-8/ ASCII here - so, what to do? Converting
+ * to UTF-16 is probably pointless, since most of the clients of this mapper
+ * will be Linux drivers using UTF-8/ ASCII anyway, not UTF-16.
+ *
+ * So, for the moment, the mapper should just convert input from UTF-8 to ASCII
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/types.h>
+#include <acpi/acpi_drivers.h>
+
+#define ACPI_WMI_CLASS "wmi"
+
+#undef PREFIX
+#define PREFIX "ACPI: WMI: "
+
+struct guid_block
+{
+	char guid[16];
+	union
+	{
+		char object_id[2];
+		struct
+		{
+			unsigned char notify_id;
+			unsigned char reserved;
+		};
+	};
+	u8 instance_count;
+	u8 flags;
+};
+
+struct guid_list
+{
+	struct guid_block *pointer;
+	int total;
+};
+
+static struct guid_list guids;
+static acpi_handle acpi_wmi_handle;
+static acpi_notify_handler wmi_external_handler;
+static void *wmi_external_data;
+
+/*
+ * If the GUID data block is marked as expensive, we must enable and
+ * explicitily disable data collection.
+ */
+#define ACPI_WMI_EXPENSIVE   0x1
+#define ACPI_WMI_METHOD      0x2	/* GUID is a method */
+
+/*
+ * Data block is a string, and must be converted from ASCII to Unicode (output)
+ * or Unicode to ASCII (input)
+ */
+#define ACPI_WMI_STRING      0x4
+#define ACPI_WMI_EVENT       0x8	/* GUID is an event */
+
+static int acpi_wmi_add(struct acpi_device *device);
+
+const static struct acpi_device_id wmi_device_ids[] = {
+	{"PNP0C14", 0},
+	{"pnp0c14", 0},
+	{"", 0},
+};
+
+static struct acpi_driver acpi_wmi_driver = {
+	.name = "wmi",
+	.class = ACPI_WMI_CLASS,
+	.ids = wmi_device_ids,
+	.ops = {
+		.add = acpi_wmi_add,
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
+	unsigned int x; /* For correct wrapping */
+	int h;
+
+	/* high part */
+	x = src[0];
+	if (x - '0' <= '9' - '0') {
+		h = x - '0';
+	} else if (x - 'a' <= 'f' - 'a') {
+		h = x - 'a' + 10;
+	} else if (x - 'A' <= 'F' - 'A') {
+		h = x - 'A' + 10;
+	} else {
+		return -1;
+	}
+	h <<= 4;
+
+	/* low part */
+	x = src[1];
+	if (x - '0' <= '9' - '0')
+		return h | (x - '0');
+	if (x - 'a' <= 'f' - 'a')
+		return h | (x - 'a' + 10);
+	if (x - 'A' <= 'F' - 'A')
+		return h | (x - 'A' + 10);
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
+	for (j = 0; j < 5; j++, src++) {
+		for (i = 0; i < size[j]; i++, src += 2, *dest++ = v) {
+			v = wmi_parse_hexbyte(src);
+			if (v < 0)
+				return false;
+		}
+	}
+
+	return true;
+}
+
+static bool find_guid(const char *guid_string, struct guid_block **out)
+{
+	char tmp[16], guid_input[16];
+	struct guid_block *block;
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
+ * Exported WMI functions
+ */
+/**
+ * wmi_evaluate_method - Evaluate a WMI method
+ * @guid_string: 36 char string of the form fa50ff2b-f2e8-45de-83fa-65417f2f49ba
+ * @instance: Instance index
+ * @method_id: Method ID to call
+ * &in: Buffer containing input for the method call
+ * &out: Empty buffer to return the method results
+ *
+ * Convert a WMI method call to an ACPI one, and return the results
+ */
+acpi_status wmi_evaluate_method(const char *guid_string, u8 instance,
+u32 method_id, const struct acpi_buffer *in, struct acpi_buffer *out)
+{
+	struct guid_block *block = NULL;
+	acpi_status status;
+	struct acpi_object_list input;
+	union acpi_object wm_params[3];
+	char method[4] = "WM";
+
+	if (!find_guid(guid_string, &block))
+		return AE_BAD_ADDRESS;
+
+	if (!block->flags & ACPI_WMI_METHOD)
+		return AE_BAD_DATA;
+
+	if (block->instance_count < instance)
+		return AE_BAD_PARAMETER;
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
+
+	status = acpi_evaluate_object(acpi_wmi_handle, method, &input, out);
+
+	if (block->flags & ACPI_WMI_STRING) {
+		/* Convert output from ASCIIZ to Unicode */
+		return AE_NOT_IMPLEMENTED;
+	}
+
+	return status;
+}
+EXPORT_SYMBOL_GPL(wmi_evaluate_method);
+
+/**
+ * wmi_query_block - Return contents of a WMI block
+ * @guid_string: 36 char string of the form fa50ff2b-f2e8-45de-83fa-65417f2f49ba
+ * @instance: Instance index
+ * &out: Empty buffer to return the contents of the data block to
+ *
+ * Return the contents of a data block to a buffer
+ */
+acpi_status wmi_query_block(const char *guid_string, u8 instance,
+struct acpi_buffer *out)
+{
+	struct guid_block *block = NULL;
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
+	if (block->instance_count < instance)
+		return AE_BAD_PARAMETER;
+
+	/* Check GUID is a data block */
+	if (block->flags & (ACPI_WMI_EVENT | ACPI_WMI_METHOD))
+		return AE_BAD_ADDRESS;
+
+	input.count = 1;
+	input.pointer = wq_params;
+	wq_params[0].type = ACPI_TYPE_INTEGER;
+	wq_params[0].integer.value = instance;
+
+	/*
+	 * If ACPI_WMI_EXPENSIVE, call the relevant WCxx method first to
+	 * enable collection
+	 */
+	if (block->flags & ACPI_WMI_EXPENSIVE) {
+		wc_input.count = 1;
+		wc_input.pointer = wc_params;
+		wc_params[0].type = ACPI_TYPE_INTEGER;
+		wc_params[0].integer.value = 1;
+
+		strncat(wc_method, block->object_id, 2);
+
+		status = acpi_evaluate_object(acpi_wmi_handle, wc_method,
+			&wc_input, NULL);
+
+		if (ACPI_FAILURE(status))
+			return AE_ERROR;
+	}
+
+	strncat(method, block->object_id, 2);
+
+	status = acpi_evaluate_object(acpi_wmi_handle, method, NULL, out);
+
+	/*
+	 * If ACPI_WMI_EXPENSIVE, call the relevant WCxx method, even if
+	 * the WQxx method failed - we should disable collection anyway
+	 */
+	if (block->flags & ACPI_WMI_EXPENSIVE) {
+		wc_params[0].integer.value = 0;
+		status = acpi_evaluate_object(acpi_wmi_handle,
+		wc_method, &wc_input, NULL);
+	}
+
+	if (ACPI_SUCCESS(status)) {
+		/* Convert output from ASCIIZ to Unicode */
+		if (block->flags & ACPI_WMI_STRING)
+			return AE_NOT_IMPLEMENTED;
+	}
+
+	return status;
+}
+EXPORT_SYMBOL_GPL(wmi_query_block);
+
+/**
+ * wmi_set_block - Write to a WMI block
+ * @guid_string: 36 char string of the form fa50ff2b-f2e8-45de-83fa-65417f2f49ba
+ * @instance: Instance index
+ * &in: Buffer containing new values for the data block
+ *
+ * Write the contents of the input buffer to ACPI
+ */
+acpi_status wmi_set_block(const char *guid_string, u8 instance,
+const struct acpi_buffer *in)
+{
+	struct guid_block *block = NULL;
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
+	if (block->instance_count < instance)
+		return AE_BAD_PARAMETER;
+
+	/* Check GUID is a data block */
+	if (block->flags & (ACPI_WMI_EVENT | ACPI_WMI_METHOD))
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
+	if (block->flags & ACPI_WMI_STRING)
+		return AE_NOT_IMPLEMENTED;
+
+	strncat(method, block->object_id, 2);
+
+	return acpi_evaluate_object(acpi_wmi_handle, method, &input, NULL);
+}
+EXPORT_SYMBOL_GPL(wmi_set_block);
+
+/**
+ * wmi_install_notify_handler - Register handler for WMI events
+ * @handler: Function to handle notifications
+ * @data: Data to be returned to handler when event is fired
+ *
+ * Register a handler for events sent to the WMI-ACPI mapper device.
+ */
+acpi_status wmi_install_notify_handler(acpi_notify_handler handler, void *data)
+{
+	if (!handler)
+		return AE_BAD_PARAMETER;
+
+	if (!wmi_external_handler)
+		return AE_ALREADY_ACQUIRED;
+
+	wmi_external_handler = handler;
+	wmi_external_data = data;
+
+	return AE_OK;
+}
+EXPORT_SYMBOL_GPL(wmi_install_notify_handler);
+
+/**
+ * wmi_uninstall_notify_handler - Unregister handler for WMI events
+ *
+ * Unregister handler for events sent to the WMI-ACPI mapper device.
+ */
+acpi_status wmi_remove_notify_handler(void)
+{
+	if (wmi_external_handler) {
+		wmi_external_handler = NULL;
+		wmi_external_data = NULL;
+		return AE_OK;
+	}
+	return AE_ERROR;
+}
+EXPORT_SYMBOL_GPL(wmi_remove_notify_handler);
+
+/**
+ * wmi_get_event_data - Get WMI data associated with an event
+ *
+ * @event - Event to find
+ * &out - Buffer to hold event data
+ *
+ * Returns extra data associated with an event in WMI.
+ */
+static acpi_status wmi_get_event_data(u32 event, struct acpi_buffer *out)
+{
+	struct acpi_object_list input;
+	union acpi_object params[1];
+
+	input.count = 1;
+	input.pointer = params;
+	params[0].type = ACPI_TYPE_INTEGER;
+	params[0].integer.value = event;
+
+	return acpi_evaluate_object(acpi_wmi_handle, "_WED", &input, out);
+}
+EXPORT_SYMBOL(wmi_get_event_data);
+
+/**
+ * wmi_has_guid - Check if a GUID is available
+ * @guid_string: 36 char string of the form fa50ff2b-f2e8-45de-83fa-65417f2f49ba
+ *
+ * Check if a given GUID is defined by _WDG
+ */
+bool wmi_has_guid(const char *guid_string)
+{
+	return find_guid(guid_string, NULL);
+}
+EXPORT_SYMBOL_GPL(wmi_has_guid);
+
+/**
+ * parse_wdg - Parse the _WDG method for the GUID data blocks
+ */
+static __init acpi_status parse_wdg(void)
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
+	guids.pointer = kzalloc(obj->buffer.length, GFP_KERNEL);
+	memcpy(guids.pointer, obj->buffer.pointer, obj->buffer.length);
+	guids.total = obj->buffer.length / sizeof(struct guid_block);
+
+	kfree(out.pointer);
+
+	return status;
+}
+
+static void acpi_wmi_notify(acpi_handle handle, u32 event, void *data)
+{
+	int i;
+	struct guid_block *block;
+	struct acpi_device *device = data;
+
+	for (i = 0; i < guids.total; i++) {
+		block = guids.pointer + i;
+
+		if ((block->flags & ACPI_WMI_EVENT) &&
+		block->notify_id == event) {
+			if (wmi_external_handler)
+				wmi_external_handler(handle, event,
+					wmi_external_data);
+
+			acpi_bus_generate_netlink_event(
+				device->pnp.device_class, device->dev.bus_id,
+				event, 0);
+			break;
+		}
+	}
+}
+
+static int __init acpi_wmi_add(struct acpi_device *device)
+{
+	acpi_status status;
+	int result = 0;
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
+	status = parse_wdg();
+
+	if (ACPI_FAILURE(status))
+		return -ENODEV;
+
+	return result;
+}
+
+static int __init acpi_wmi_init(void)
+{
+	acpi_status result;
+
+	if (acpi_disabled)
+		return -ENODEV;
+
+	result = acpi_bus_register_driver(&acpi_wmi_driver);
+
+	if (ACPI_FAILURE(result)) {
+		printk(KERN_INFO PREFIX "Interface device not found\n");
+	} else {
+		printk(KERN_INFO PREFIX "Interface device found\n");
+		printk(KERN_INFO PREFIX "Mapper loaded\n");
+	}
+
+	return result;
+}
+
+subsys_initcall(acpi_wmi_init);
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 8ccedf7..36c91b3 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -186,6 +186,23 @@ extern int ec_transaction(u8 command,
 
 #endif /*CONFIG_ACPI_EC*/
 
+#ifdef CONFIG_ACPI_WMI
+
+extern acpi_status wmi_evaluate_method(const char *guid, u8 instance,
+					u32 method_id,
+					const struct acpi_buffer *in,
+					struct acpi_buffer *out);
+extern acpi_status wmi_query_block(const char *guid, u8 instance,
+					struct acpi_buffer *out);
+extern acpi_status wmi_set_block(const char *guid, u8 instance,
+					const struct acpi_buffer *in);
+extern acpi_status wmi_install_notify_handler(acpi_notify_handler handler,
+					void *data);
+extern acpi_status wmi_remove_notify_handler(void);
+extern bool wmi_has_guid(const char *guid);
+
+#endif	/* CONFIG_ACPI_WMI */
+
 extern int acpi_blacklisted(void);
 extern void acpi_bios_year(char *s);
 
-- 
1.5.3.4

