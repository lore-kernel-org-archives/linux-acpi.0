From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: [PATCH 2/4] acer-wmi: Add driver for newer Acer laptops
Date: Tue, 18 Dec 2007 23:51:49 +0000
Message-ID: <20071218235148.12838.25048.stgit@localhost>
References: <20071218235137.12838.75397.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from bb-87-81-255-5.ukonline.co.uk ([87.81.255.5]:42107 "EHLO
	pacifica." rhost-flags-OK-OK-FAIL-FAIL) by vger.kernel.org with ESMTP
	id S1753904AbXLRXwT (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 18 Dec 2007 18:52:19 -0500
In-Reply-To: <20071218235137.12838.75397.stgit@localhost>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Carlos Corbacho <carlos@strangeworlds.co.uk>, Len Brown <lenb@kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>

This is a driver for newer Acer (and Wistron) laptops. It adds wireless
radio and bluetooth control, and on some laptops, exposes the mail LED and
LCD backlight.

v1:

* Initial release

v2:

* Replace left over ACPI references with WMI
* Add GUID based autoloading (depends on future work to WMI)
* Add DMI based autoloading (backup solution until WMI sysfs/ class
  work is available)
* Checkpatch fixes

v3:

* Add new EC quirks for Aspire 3100 & 5100, and Extensa 5220

Signed-off-by: Carlos Corbacho <carlos@strangeworlds.co.uk>
CC: Len Brown <lenb@kernel.org>
CC: Matthew Garrett <mjg59@srcf.ucam.org>
---

 drivers/misc/Kconfig    |   16 +
 drivers/misc/Makefile   |    1 
 drivers/misc/acer-wmi.c | 1009 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 1026 insertions(+), 0 deletions(-)
 create mode 100644 drivers/misc/acer-wmi.c


diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index b1f9a40..d72acbf 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -92,6 +92,22 @@ config TIFM_7XX1
           To compile this driver as a module, choose M here: the module will
 	  be called tifm_7xx1.
 
+config ACER_WMI
+        tristate "Acer Laptop WMI-ACPI Extras (EXPERIMENTAL)"
+	depends on X86
+	depends on EXPERIMENTAL
+	depends on ACPI
+	depends on ACPI_WMI
+	depends on LEDS_CLASS
+	depends on BACKLIGHT_CLASS_DEVICE
+	---help---
+	  This is a driver for newer Acer (and Wistron) laptops. It adds
+	  wireless radio and bluetooth control, and on some laptops,
+	  exposes the mail LED and LCD backlight.
+
+	  If you have an ACPI-WMI compatible Acer/ Wistron laptop, say Y or M
+	  here.
+
 config ASUS_LAPTOP
         tristate "Asus Laptop Extras (EXPERIMENTAL)"
         depends on X86
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index 87f2685..3da1491 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -6,6 +6,7 @@ obj- := misc.o	# Dummy rule to force built-in.o to be made
 obj-$(CONFIG_IBM_ASM)		+= ibmasm/
 obj-$(CONFIG_HDPU_FEATURES)	+= hdpuftrs/
 obj-$(CONFIG_MSI_LAPTOP)     += msi-laptop.o
+obj-$(CONFIG_ACER_WMI)     += acer-wmi.o
 obj-$(CONFIG_ASUS_LAPTOP)     += asus-laptop.o
 obj-$(CONFIG_ATMEL_SSC)		+= atmel-ssc.o
 obj-$(CONFIG_LKDTM)		+= lkdtm.o
diff --git a/drivers/misc/acer-wmi.c b/drivers/misc/acer-wmi.c
new file mode 100644
index 0000000..ebdf70c
--- /dev/null
+++ b/drivers/misc/acer-wmi.c
@@ -0,0 +1,1009 @@
+/*
+ *  Acer Laptop WMI Extras
+ *
+ *  Copyright (C) 2007		Carlos Corbacho <carlos@strangeworlds.co.uk>
+ *
+ *  Based on acer_acpi:
+ *    Copyright (C) 2005-2007	E.M. Smith
+ *    Copyright (C) 2007	Carlos Corbacho <cathectic@gmail.com>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#define ACER_WMI_VERSION	"0.1"
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/types.h>
+#include <linux/dmi.h>
+#include <linux/backlight.h>
+#include <linux/leds.h>
+#include <linux/platform_device.h>
+#include <linux/acpi.h>
+#include <linux/i8042.h>
+
+#include <acpi/acpi_drivers.h>
+
+MODULE_AUTHOR("Carlos Corbacho");
+MODULE_DESCRIPTION("Acer Laptop WMI Extras Driver");
+MODULE_LICENSE("GPL");
+
+#define ACER_LOGPREFIX "acer-wmi: "
+#define ACER_ERR KERN_ERR ACER_LOGPREFIX
+#define ACER_NOTICE KERN_NOTICE ACER_LOGPREFIX
+#define ACER_INFO KERN_INFO ACER_LOGPREFIX
+
+/*
+ * The following defines quirks to get some specific functions to work
+ * which are known to not be supported over ACPI (such as the mail LED
+ * on WMID based Acer's)
+ */
+struct acer_quirks {
+	const char *vendor;
+	const char *model;
+	u16 quirks;
+};
+
+/*
+ * Magic Number
+ * Meaning is unknown - this number is required for writing to ACPI for AMW0
+ * (it's also used in acerhk when directly accessing the EC)
+ */
+#define ACER_AMW0_WRITE	0x9610
+
+/*
+ * Bit masks for the old AMW0 interface
+ */
+#define ACER_AMW0_WIRELESS_MASK  0x35
+#define ACER_AMW0_BLUETOOTH_MASK 0x34
+#define ACER_AMW0_MAILLED_MASK   0x31
+
+/*
+ * Method IDs for new WMID interface
+ */
+#define ACER_WMID_GET_WIRELESS_METHODID		1
+#define ACER_WMID_GET_BLUETOOTH_METHODID	2
+#define ACER_WMID_GET_BRIGHTNESS_METHODID	3
+#define ACER_WMID_SET_WIRELESS_METHODID		4
+#define ACER_WMID_SET_BLUETOOTH_METHODID	5
+#define ACER_WMID_SET_BRIGHTNESS_METHODID	6
+#define ACER_WMID_GET_THREEG_METHODID		10
+#define ACER_WMID_SET_THREEG_METHODID		11
+
+/*
+ * Acer ACPI method GUIDs
+ */
+#define AMW0_GUID1		"67C3371D-95A3-4C37-BB61-DD47B491DAAB"
+#define WMID_GUID1		"6AF4F258-B401-42fd-BE91-3D4AC2D7C0D3"
+
+MODULE_ALIAS("wmi:67C3371D-95A3-4C37-BB61-DD47B491DAAB");
+MODULE_ALIAS("wmi:6AF4F258-B401-42fd-BE91-3D4AC2D7C0D3");
+
+/* Temporary workaround until the WMI sysfs interface goes in */
+MODULE_ALIAS("dmi:*:*Acer*:*:");
+
+/*
+ * Interface capability flags
+ */
+#define ACER_CAP_MAILLED		(1<<0)
+#define ACER_CAP_WIRELESS		(1<<1)
+#define ACER_CAP_BLUETOOTH		(1<<2)
+#define ACER_CAP_BRIGHTNESS		(1<<3)
+#define ACER_CAP_THREEG			(1<<4)
+#define ACER_CAP_ANY			(0xFFFFFFFF)
+
+/*
+ * Interface type flags
+ */
+enum interface_flags {
+	ACER_AMW0,
+	ACER_AMW0_V2,
+	ACER_WMID,
+};
+
+#define ACER_DEFAULT_WIRELESS  0
+#define ACER_DEFAULT_BLUETOOTH 0
+#define ACER_DEFAULT_MAILLED   0
+#define ACER_DEFAULT_THREEG    0
+
+static int max_brightness = 0xF;
+
+static int wireless = -1;
+static int bluetooth = -1;
+static int mailled = -1;
+static int brightness = -1;
+static int threeg = -1;
+static int force_series;
+
+module_param(mailled, int, 0444);
+module_param(wireless, int, 0444);
+module_param(bluetooth, int, 0444);
+module_param(brightness, int, 0444);
+module_param(threeg, int, 0444);
+module_param(force_series, int, 0444);
+MODULE_PARM_DESC(wireless, "Set initial state of Wireless hardware");
+MODULE_PARM_DESC(bluetooth, "Set initial state of Bluetooth hardware");
+MODULE_PARM_DESC(mailled, "Set initial state of Mail LED");
+MODULE_PARM_DESC(brightness, "Set initial LCD backlight brightness");
+MODULE_PARM_DESC(threeg, "Set initial state of 3G hardware");
+MODULE_PARM_DESC(force_series, "Force a different laptop series");
+
+struct acer_data {
+	int mailled;
+	int wireless;
+	int bluetooth;
+	int threeg;
+	int brightness;
+};
+
+/* Each low-level interface must define at least some of the following */
+struct wmi_interface {
+	/*
+	 * The WMI device type
+	 */
+	u32 type;
+
+	/*
+	 * The capabilities this interface provides
+	 */
+	u32 capability;
+
+	/*
+	 * Private data for the current interface
+	 */
+	struct acer_data data;
+};
+
+/* The static interface pointer, points to the currently detected interface */
+static struct wmi_interface *interface;
+
+/*
+ * Embedded Controller quirks
+ * Some laptops require us to directly access the EC to either enable or query
+ * features that are not available through WMI.
+ */
+
+struct quirk_entry {
+	u8 wireless;
+	u8 mailled;
+	u8 brightness;
+	u8 bluetooth;
+	u8 max_brightness;
+};
+
+static struct quirk_entry *quirks;
+
+static void set_quirks(void)
+{
+	if (quirks->mailled != 0)
+		interface->capability |= ACER_CAP_MAILLED;
+
+	if (quirks->brightness != 0)
+		interface->capability |= ACER_CAP_BRIGHTNESS;
+
+	if (quirks->bluetooth != 0)
+		interface->capability |= ACER_CAP_BLUETOOTH;
+
+	if (quirks->wireless != 0)
+		interface->capability |= ACER_CAP_WIRELESS;
+
+	if (quirks->max_brightness != 0)
+		max_brightness = quirks->max_brightness;
+}
+
+static int dmi_matched(const struct dmi_system_id *dmi)
+{
+	quirks = dmi->driver_data;
+	return 0;
+}
+
+static struct quirk_entry quirk_unknown = {
+};
+
+static struct quirk_entry quirk_acer_travelmate_2490 = {
+	.mailled = 1,
+};
+
+static struct quirk_entry quirk_acer_travelmate_5720 = {
+	.max_brightness = 0x9,
+};
+
+static struct dmi_system_id acer_quirks[] = {
+	{
+		.callback = dmi_matched,
+		.ident = "Acer Aspire 3100",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire 3100"),
+		},
+		.driver_data = &quirk_acer_travelmate_2490,
+	},
+	{
+		.callback = dmi_matched,
+		.ident = "Acer Aspire 5100",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire 5100"),
+		},
+		.driver_data = &quirk_acer_travelmate_2490,
+	},
+	{
+		.callback = dmi_matched,
+		.ident = "Acer Aspire 5630",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire 5630"),
+		},
+		.driver_data = &quirk_acer_travelmate_2490,
+	},
+	{
+		.callback = dmi_matched,
+		.ident = "Acer Aspire 5650",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire 5650"),
+		},
+		.driver_data = &quirk_acer_travelmate_2490,
+	},
+	{
+		.callback = dmi_matched,
+		.ident = "Acer Aspire 5680",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire 5680"),
+		},
+		.driver_data = &quirk_acer_travelmate_2490,
+	},
+	{
+		.callback = dmi_matched,
+		.ident = "Acer Extensa 5220",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Extensa 5220"),
+		},
+		.driver_data = &quirk_acer_travelmate_5720,
+	},
+	{
+		.callback = dmi_matched,
+		.ident = "Acer TravelMate 2490",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "TravelMate 2490"),
+		},
+		.driver_data = &quirk_acer_travelmate_2490,
+	},
+	{
+		.callback = dmi_matched,
+		.ident = "Acer TravelMate 5720",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "TravelMate 5720"),
+		},
+		.driver_data = &quirk_acer_travelmate_5720,
+	},
+	{}
+};
+
+/* Find which quirks are needed for a particular vendor/ model pair */
+static void find_quirks(void)
+{
+	if (!force_series) {
+		dmi_check_system(acer_quirks);
+	} else if (force_series == 2490) {
+		quirks = &quirk_acer_travelmate_2490;
+	}
+
+	if (quirks == NULL)
+		quirks = &quirk_unknown;
+
+	set_quirks();
+}
+
+/*
+ * General interface convenience methods
+ */
+
+static bool has_cap(u32 cap)
+{
+	if ((interface->capability & cap) != 0)
+		return 1;
+
+	return 0;
+}
+
+/*
+ * Old interface (now known as the AMW0 interface)
+ */
+struct wmab_args {
+	u32 eax;
+	u32 ebx;
+	u32 ecx;
+	u32 edx;
+};
+
+static acpi_status WMAB_execute(struct wmab_args *regbuf,
+struct acpi_buffer *result)
+{
+	struct acpi_buffer input;
+	acpi_status status;
+	input.length = sizeof(struct wmab_args);
+	input.pointer = (u8 *)regbuf;
+
+	status = wmi_evaluate_method(AMW0_GUID1, 1, 1, &input, result);
+
+	return status;
+}
+
+static acpi_status AMW0_get_bool(bool *value, u32 cap,
+struct wmi_interface *iface)
+{
+	u8 result;
+
+	switch (cap) {
+	case ACER_CAP_MAILLED:
+		switch (quirks->mailled) {
+		default:
+			ec_read(0x0A, &result);
+			*value = (result >> 7) & 0x01;
+			return 0;
+		}
+		break;
+	case ACER_CAP_WIRELESS:
+		switch (quirks->wireless) {
+		default:
+			ec_read(0x0A, &result);
+			*value = (result >> 2) & 0x01;
+			return 0;
+		}
+		break;
+	case ACER_CAP_BLUETOOTH:
+		switch (quirks->bluetooth) {
+		default:
+			ec_read(0x0A, &result);
+			*value = (result >> 4) & 0x01;
+			return 0;
+		}
+		break;
+	default:
+		return AE_BAD_ADDRESS;
+	}
+	return AE_OK;
+}
+
+static acpi_status AMW0_set_bool(bool value, u32 cap,
+struct wmi_interface *iface)
+{
+	struct wmab_args args;
+
+	args.eax = ACER_AMW0_WRITE;
+	args.ebx = value ? (1<<8) : 0;
+	args.ecx = args.edx = 0;
+
+	switch (cap) {
+	case ACER_CAP_MAILLED:
+		args.ebx |= ACER_AMW0_MAILLED_MASK;
+		break;
+	case ACER_CAP_WIRELESS:
+		args.ebx |= ACER_AMW0_WIRELESS_MASK;
+		break;
+	case ACER_CAP_BLUETOOTH:
+		args.ebx |= ACER_AMW0_BLUETOOTH_MASK;
+		break;
+	default:
+		return AE_BAD_ADDRESS;
+	}
+
+	/* Actually do the set */
+	return WMAB_execute(&args, NULL);
+}
+
+static acpi_status AMW0_get_u8(u8 *value, u32 cap, struct wmi_interface *iface)
+{
+	switch (cap) {
+	case ACER_CAP_BRIGHTNESS:
+		switch (quirks->brightness) {
+		default:
+			return ec_read(0x83, value);
+		}
+		break;
+	default:
+		return AE_BAD_ADDRESS;
+	}
+	return AE_OK;
+}
+
+static acpi_status AMW0_set_u8(u8 value, u32 cap, struct wmi_interface *iface)
+{
+	switch (cap) {
+	case ACER_CAP_BRIGHTNESS:
+		switch (quirks->brightness) {
+		default:
+			return ec_write(0x83, value);
+		break;
+		}
+	default:
+		return AE_BAD_ADDRESS;
+	}
+	return AE_OK;
+}
+
+static struct wmi_interface AMW0_interface = {
+	.type = ACER_AMW0,
+	.capability = (
+		ACER_CAP_MAILLED |
+		ACER_CAP_WIRELESS |
+		ACER_CAP_BLUETOOTH
+	),
+};
+
+static struct wmi_interface AMW0_V2_interface = {
+	.type = ACER_AMW0_V2,
+	.capability = (
+		ACER_CAP_MAILLED |
+		ACER_CAP_WIRELESS |
+		ACER_CAP_BLUETOOTH |
+		ACER_CAP_BRIGHTNESS
+	),
+};
+
+/*
+ * New interface (The WMID interface)
+ */
+static acpi_status
+WMI_execute_u32(u32 method_id, u32 in, u32 *out)
+{
+	struct acpi_buffer input = { (acpi_size) sizeof(u32), (void *)(&in) };
+	struct acpi_buffer result = { ACPI_ALLOCATE_BUFFER, NULL };
+	union acpi_object *obj;
+	u32 tmp;
+	acpi_status status;
+
+	status = wmi_evaluate_method(WMID_GUID1, 1, method_id, &input, &result);
+
+	if (ACPI_FAILURE(status))
+		return status;
+
+	obj = (union acpi_object *) result.pointer;
+	if (obj && obj->type == ACPI_TYPE_BUFFER &&
+		obj->buffer.length == sizeof(u32)) {
+		tmp = *((u32 *) obj->buffer.pointer);
+	} else {
+		tmp = 0;
+	}
+
+	if (out)
+		*out = tmp;
+
+	if (result.length > 0 && result.pointer)
+		kfree(result.pointer);
+
+	return status;
+}
+
+static acpi_status WMID_get_u8(u8 *value, u32 cap, struct wmi_interface *iface)
+{
+	acpi_status status;
+	u32 result;
+	u32 method_id = 0;
+
+	switch (cap) {
+	case ACER_CAP_WIRELESS:
+		method_id = ACER_WMID_GET_WIRELESS_METHODID;
+		break;
+	case ACER_CAP_BLUETOOTH:
+		method_id = ACER_WMID_GET_BLUETOOTH_METHODID;
+		break;
+	case ACER_CAP_BRIGHTNESS:
+		method_id = ACER_WMID_GET_BRIGHTNESS_METHODID;
+		break;
+	case ACER_CAP_THREEG:
+		method_id = ACER_WMID_GET_THREEG_METHODID;
+		break;
+	case ACER_CAP_MAILLED:
+		switch (quirks->mailled) {
+		case 1:
+			ec_read(0x9f, value);
+			*value &= 0x01;
+			return 0;
+		default:
+			return AE_BAD_ADDRESS;
+		}
+	default:
+		return AE_BAD_ADDRESS;
+	}
+	status = WMI_execute_u32(method_id, 0, &result);
+
+	if (ACPI_SUCCESS(status))
+		*value = (u8) result;
+
+	return status;
+}
+
+static acpi_status WMID_set_u8(u8 value, u32 cap, struct wmi_interface *iface)
+{
+	u32 method_id = 0;
+	char param;
+
+	switch (cap) {
+	case ACER_CAP_BRIGHTNESS:
+		method_id = ACER_WMID_SET_BRIGHTNESS_METHODID;
+		break;
+	case ACER_CAP_WIRELESS:
+		method_id = ACER_WMID_SET_WIRELESS_METHODID;
+		break;
+	case ACER_CAP_BLUETOOTH:
+		method_id = ACER_WMID_SET_BLUETOOTH_METHODID;
+		break;
+	case ACER_CAP_THREEG:
+		method_id = ACER_WMID_SET_THREEG_METHODID;
+		break;
+	case ACER_CAP_MAILLED:
+		switch (quirks->mailled) {
+		case 1:
+			param = value? 0x92 : 0x93;
+			i8042_command(&param, 0x1059);
+			return 0;
+		default:
+			return AE_BAD_ADDRESS;
+		}
+	default:
+		return AE_BAD_ADDRESS;
+	}
+	return WMI_execute_u32(method_id, (u32)value, NULL);
+}
+
+
+static struct wmi_interface wmid_interface = {
+	.type = ACER_WMID,
+	.capability = (
+		ACER_CAP_WIRELESS
+		| ACER_CAP_BRIGHTNESS
+		| ACER_CAP_BLUETOOTH
+		| ACER_CAP_THREEG
+	),
+};
+
+/*
+ * Generic Device (interface-independent)
+ */
+
+static acpi_status get_bool(bool *value, u32 cap)
+{
+	acpi_status status = AE_BAD_ADDRESS;
+	u8 tmp = 0;
+
+	switch (interface->type) {
+	case ACER_AMW0:
+		status = AMW0_get_bool(value, cap, interface);
+		break;
+	case ACER_AMW0_V2:
+		if (cap == ACER_CAP_MAILLED) {
+			status = AMW0_get_bool(value, cap, interface);
+			break;
+		}
+	case ACER_WMID:
+		status = WMID_get_u8(&tmp, cap, interface);
+		*value = (tmp == 1) ? 1 : 0;
+		break;
+	}
+	return status;
+}
+
+static acpi_status set_bool(int value, u32 cap)
+{
+	acpi_status status = AE_BAD_PARAMETER;
+
+	if ((value == 0 || value == 1) && (interface->capability & cap)) {
+		switch (interface->type) {
+		case ACER_AMW0:
+			status = AMW0_set_bool(value == 1, cap, interface);
+			break;
+		case ACER_AMW0_V2:
+			if (cap == ACER_CAP_MAILLED) {
+				status = AMW0_set_bool(value == 1, cap,
+					interface);
+				break;
+			}
+		case ACER_WMID:
+			status = WMID_set_u8(value == 1, cap, interface);
+			break;
+		}
+	}
+	return status;
+}
+
+static acpi_status get_u8(u8 *value, u32 cap)
+{
+	switch (interface->type) {
+	case ACER_AMW0:
+		return AMW0_get_u8(value, cap, interface);
+		break;
+	case ACER_AMW0_V2:
+	case ACER_WMID:
+		return WMID_get_u8(value, cap, interface);
+		break;
+	default:
+		return AE_BAD_ADDRESS;
+	}
+}
+
+static acpi_status set_u8(u8 value, u8 min, u8 max, u32 cap)
+{
+	if ((value >= min && value <= max) && (interface->capability & cap)) {
+		switch (interface->type) {
+		case ACER_AMW0:
+			return AMW0_set_u8(value, cap, interface);
+		case ACER_AMW0_V2:
+		case ACER_WMID:
+			return WMID_set_u8(value, cap, interface);
+		default:
+			return AE_BAD_PARAMETER;
+		}
+	}
+	return AE_BAD_PARAMETER;
+}
+
+/* Each _u8 needs a small wrapper that sets the boundary values */
+static acpi_status set_brightness(u8 value)
+{
+	return set_u8(value, 0, max_brightness, ACER_CAP_BRIGHTNESS);
+}
+
+static void __init acer_commandline_init(void)
+{
+	/*
+	 * These will all fail silently if the value given is invalid, or the
+	 * capability isn't available on the given interface
+	 */
+	set_bool(mailled, ACER_CAP_MAILLED);
+	set_bool(wireless, ACER_CAP_WIRELESS);
+	set_bool(bluetooth, ACER_CAP_BLUETOOTH);
+	set_bool(threeg, ACER_CAP_THREEG);
+	set_brightness((u8)brightness);
+}
+
+/*
+ * LED device (Mail LED only, no other LEDs known yet)
+ */
+static void mail_led_set(struct led_classdev *led_cdev,
+enum led_brightness value)
+{
+	bool tmp = value;
+	set_bool(tmp, ACER_CAP_MAILLED);
+}
+
+static struct led_classdev mail_led = {
+	.name = "acer-mail:green",
+	.brightness_set = mail_led_set,
+};
+
+static void acer_led_init(struct device *dev)
+{
+	led_classdev_register(dev, &mail_led);
+}
+
+static void acer_led_exit(void)
+{
+	led_classdev_unregister(&mail_led);
+}
+
+/*
+ * Backlight device
+ */
+static struct backlight_device *acer_backlight_device;
+
+static int read_brightness(struct backlight_device *bd)
+{
+	u8 value;
+	get_u8(&value, ACER_CAP_BRIGHTNESS);
+	return value;
+}
+
+static int update_bl_status(struct backlight_device *bd)
+{
+	set_brightness(bd->props.brightness);
+	return 0;
+}
+
+static struct backlight_ops acer_bl_ops = {
+	.get_brightness = read_brightness,
+	.update_status = update_bl_status,
+};
+
+static int __init acer_backlight_init(struct device *dev)
+{
+	struct backlight_device *bd;
+
+	bd = backlight_device_register("acer-wmi", dev, NULL, &acer_bl_ops);
+	if (IS_ERR(bd)) {
+		printk(ACER_ERR "Could not register Acer backlight device\n");
+		acer_backlight_device = NULL;
+		return PTR_ERR(bd);
+	}
+
+	acer_backlight_device = bd;
+
+	bd->props.max_brightness = max_brightness;
+	bd->props.brightness = read_brightness(NULL);
+	backlight_update_status(bd);
+	return 0;
+}
+
+static void __exit acer_backlight_exit(void)
+{
+	backlight_device_unregister(acer_backlight_device);
+}
+
+/*
+ * Read/ write bool sysfs macro
+ */
+#define show_set_bool(value, cap) \
+static ssize_t \
+show_bool_##value(struct device *dev, struct device_attribute *attr, \
+	char *buf) \
+{ \
+	bool result; \
+	acpi_status status = get_bool(&result, cap); \
+	if (ACPI_SUCCESS(status)) \
+		return sprintf(buf, "%d\n", result); \
+	return sprintf(buf, "Read error\n"); \
+} \
+\
+static ssize_t \
+set_bool_##value(struct device *dev, struct device_attribute *attr, \
+	const char *buf, size_t count) \
+{ \
+	bool tmp = simple_strtoul(buf, NULL, 10); \
+	acpi_status status = set_bool(tmp, cap); \
+		if (ACPI_FAILURE(status)) \
+			return -EINVAL; \
+	return count; \
+} \
+static DEVICE_ATTR(value, S_IWUGO | S_IRUGO | S_IWUSR, \
+	show_bool_##value, set_bool_##value);
+
+show_set_bool(wireless, ACER_CAP_WIRELESS);
+show_set_bool(bluetooth, ACER_CAP_BLUETOOTH);
+show_set_bool(threeg, ACER_CAP_THREEG);
+
+/*
+ * Read interface sysfs macro
+ */
+static ssize_t show_interface(struct device *dev, struct device_attribute *attr,
+	char *buf)
+{
+	switch (interface->type) {
+	case ACER_AMW0:
+		return sprintf(buf, "AMW0\n");
+	case ACER_AMW0_V2:
+		return sprintf(buf, "AMW0 v2\n");
+	case ACER_WMID:
+		return sprintf(buf, "WMID\n");
+	default:
+		return sprintf(buf, "Error!\n");
+	}
+}
+
+static DEVICE_ATTR(interface, S_IWUGO | S_IRUGO | S_IWUSR,
+	show_interface, NULL);
+
+/*
+ * Platform device
+ */
+static int __devinit acer_platform_probe(struct platform_device *device)
+{
+	if (has_cap(ACER_CAP_MAILLED))
+		acer_led_init(&device->dev);
+	if (has_cap(ACER_CAP_BRIGHTNESS))
+		acer_backlight_init(&device->dev);
+	return 0;
+}
+
+static int acer_platform_remove(struct platform_device *device)
+{
+	if (has_cap(ACER_CAP_MAILLED))
+		acer_led_exit();
+	if (has_cap(ACER_CAP_BRIGHTNESS))
+		acer_backlight_exit();
+	return 0;
+}
+
+static int acer_platform_suspend(struct platform_device *dev,
+pm_message_t state)
+{
+	bool value;
+	u8 u8value;
+	struct acer_data *data = &interface->data;
+
+	if (!data)
+		return -ENOMEM;
+
+	if (has_cap(ACER_CAP_WIRELESS)) {
+		get_bool(&value, ACER_CAP_WIRELESS);
+		data->wireless = value;
+	}
+
+	if (has_cap(ACER_CAP_BLUETOOTH)) {
+		get_bool(&value, ACER_CAP_BLUETOOTH);
+		data->bluetooth = value;
+	}
+
+	if (has_cap(ACER_CAP_MAILLED)) {
+		get_bool(&value, ACER_CAP_MAILLED);
+		data->mailled = value;
+	}
+
+	if (has_cap(ACER_CAP_BRIGHTNESS)) {
+		get_u8(&u8value, ACER_CAP_BRIGHTNESS);
+		data->brightness = value;
+	}
+
+	return 0;
+}
+
+static int acer_platform_resume(struct platform_device *device)
+{
+	struct acer_data *data = &interface->data;
+
+	if (!data)
+		return -ENOMEM;
+
+	if (has_cap(ACER_CAP_WIRELESS))
+		set_bool(data->wireless, ACER_CAP_WIRELESS);
+
+	if (has_cap(ACER_CAP_BLUETOOTH))
+		set_bool(data->bluetooth, ACER_CAP_BLUETOOTH);
+
+	if (has_cap(ACER_CAP_THREEG))
+		set_bool(data->threeg, ACER_CAP_THREEG);
+
+	if (has_cap(ACER_CAP_MAILLED))
+		set_bool(data->mailled, ACER_CAP_MAILLED);
+
+	if (has_cap(ACER_CAP_BRIGHTNESS))
+		set_brightness((u8)data->brightness);
+
+	return 0;
+}
+
+static struct platform_driver acer_platform_driver = {
+	.driver = {
+		.name = "acer-wmi",
+		.owner = THIS_MODULE,
+	},
+	.probe = acer_platform_probe,
+	.remove = acer_platform_remove,
+	.suspend = acer_platform_suspend,
+	.resume = acer_platform_resume,
+};
+
+static struct platform_device *acer_platform_device;
+
+static int remove_sysfs(struct platform_device *device)
+{
+	if (has_cap(ACER_CAP_WIRELESS))
+		device_remove_file(&device->dev, &dev_attr_wireless);
+
+	if (has_cap(ACER_CAP_BLUETOOTH))
+		device_remove_file(&device->dev, &dev_attr_bluetooth);
+
+	if (has_cap(ACER_CAP_THREEG))
+		device_remove_file(&device->dev, &dev_attr_threeg);
+
+	device_remove_file(&device->dev, &dev_attr_interface);
+
+	return 0;
+}
+
+static int create_sysfs(void)
+{
+	int retval = -ENOMEM;
+
+	if (has_cap(ACER_CAP_WIRELESS)) {
+		retval = device_create_file(&acer_platform_device->dev,
+			&dev_attr_wireless);
+		if (retval)
+			goto error;
+	}
+
+	if (has_cap(ACER_CAP_BLUETOOTH)) {
+		retval = device_create_file(&acer_platform_device->dev,
+			&dev_attr_bluetooth);
+		if (retval)
+			goto error;
+	}
+
+	if (has_cap(ACER_CAP_THREEG)) {
+		retval = device_create_file(&acer_platform_device->dev,
+			&dev_attr_threeg);
+		if (retval)
+			goto error;
+	}
+
+	retval = device_create_file(&acer_platform_device->dev,
+		&dev_attr_interface);
+	if (retval)
+		goto error;
+
+	return 0;
+
+error:
+		remove_sysfs(acer_platform_device);
+	return retval;
+}
+
+static int __init acer_wmi_init(void)
+{
+	printk(ACER_INFO "Acer Laptop ACPI-WMI Extras version %s\n",
+			ACER_WMI_VERSION);
+
+	find_quirks();
+
+	/*
+	 * Detect which ACPI-WMI interface we're using.
+	 */
+	if (wmi_has_guid(AMW0_GUID1)) {
+		interface = &AMW0_interface;
+
+		if (!quirks)
+			return -ENOMEM;
+
+		if (wmi_has_guid(WMID_GUID1)) {
+			interface = &AMW0_V2_interface;
+		} else {
+			if (!quirks->brightness) {
+				quirks->brightness = 1;
+				interface->capability |= ACER_CAP_BRIGHTNESS;
+			}
+		}
+	} else if (wmi_has_guid(WMID_GUID1)) {
+		interface = &wmid_interface;
+	} else {
+		printk(ACER_ERR "No or unsupported WMI interface, unable to ");
+		printk(KERN_CONT "load.\n");
+		return -ENODEV;
+	}
+
+	if (platform_driver_register(&acer_platform_driver)) {
+		printk(ACER_ERR "Unable to register platform driver.\n");
+		goto error_platform_register;
+	}
+	acer_platform_device = platform_device_alloc("acer-wmi", -1);
+	platform_device_add(acer_platform_device);
+
+	create_sysfs();
+
+	/* Override any initial settings with values from the commandline */
+	acer_commandline_init();
+
+	return 0;
+
+error_platform_register:
+	return -ENODEV;
+}
+
+static void __exit acer_wmi_exit(void)
+{
+	remove_sysfs(acer_platform_device);
+	platform_device_del(acer_platform_device);
+	platform_driver_unregister(&acer_platform_driver);
+
+	printk(ACER_INFO "Acer Laptop WMI Extras unloaded\n");
+	return;
+}
+
+module_init(acer_wmi_init);
+module_exit(acer_wmi_exit);

