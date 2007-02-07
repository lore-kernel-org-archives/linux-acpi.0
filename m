From: Len Brown <lenb@kernel.org>
Subject: [PATCH 30/140] asus-laptop: add base driver
Date: Wed,  7 Feb 2007 13:50:44 -0500
Message-ID: <1170874415464-git-send-email-lenb@kernel.org>
References: <11708743541314-git-send-email-lenb@kernel.org> <11708743561383-git-send-email-lenb@kernel.org> <117087435785-git-send-email-lenb@kernel.org> <11708743582090-git-send-email-lenb@kernel.org> <11708743611662-git-send-email-lenb@kernel.org> <11708743653073-git-send-email-lenb@kernel.org> <11708743674006-git-send-email-lenb@kernel.org> <11708743693386-git-send-email-lenb@kernel.org> <11708743702194-git-send-email-lenb@kernel.org> <11708743723353-git-send-email-lenb@kernel.org> <11708743783727-git-send-email-lenb@kernel.org> <11708743802558-git-send-email-lenb@kernel.org> <11708743821259-git-send-email-lenb@kernel.org> <11708743853573-git-send-email-lenb@kernel.org> <11708743871468-git-send-email-lenb@kernel.org> <1170874390715-git-send-email-lenb@kernel.org> <1170874393736-git-send-email-lenb@kernel.org> <11708743943108-git-send-email-lenb@kernel.org> <11708743962377-git-send-ema
 il-lenb@kernel.org> <11708743972593-git-send-email-lenb@kernel.org> <1170874398386-git-send-email-lenb@kernel.org> <11708743993414-git-send-email-lenb@kernel.org> <11708744003959-git-send-email-lenb@kernel.org> <11708744023872-git-send-email-lenb@kernel.org> <11708744032427-git-send-email-lenb@kernel.org> <11708744053556-git-send-email-lenb@kernel.org> <11708744062538-git-send-email-lenb@kernel.org> <11708744071019-git-send-email-lenb@kernel.org> <11708744093818-git-send-email-lenb@kernel.org> <11708744101300-git-send-email-lenb@kernel.org> <1170874412494-git-send-email-lenb@kernel.org> <11708744142658-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([143.182.124.22]:45778 "EHLO
	azsmga101.ch.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1422750AbXBGSxj (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 7 Feb 2007 13:53:39 -0500
In-Reply-To: <11708744142658-git-send-email-lenb@kernel.org>
Message-Id: <85091b718969be7b8e6f795af7e264b8afcd7a6d.1170873816.git.len.brown@intel.com>
In-Reply-To: <9e89dde2b063ca73fcdc9244fe68e2dea32c5088.1170873816.git.len.brown@intel.com>
References: <9e89dde2b063ca73fcdc9244fe68e2dea32c5088.1170873816.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Corentin Chary <corentincj@iksaif.net>, Len Brown <len.brown@intel.com>

From: Corentin Chary <corentincj@iksaif.net>

Adds the new driver and make ASUS_LAPTOP and ACPI_ASUS
incompatible.  It may be strange to use ASUS_CREATE_DEVICE_ATTR
and ASUS_SET_DEVICE_ATTR now, but these macro will be very
usefull in next patchs.  ASUS_HANDLE and ASUS_HANDLE_INIT comes
from IBM_HANDLE and IBM_HANDLE_INIT, with some modification,
and will also be used in next patchs.

Signed-off-by: Corentin Chary <corentincj@iksaif.net>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 MAINTAINERS                |    8 +
 drivers/acpi/Kconfig       |   13 +-
 drivers/misc/Kconfig       |   17 ++
 drivers/misc/Makefile      |    1 +
 drivers/misc/asus-laptop.c |  530 ++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 564 insertions(+), 5 deletions(-)
 create mode 100644 drivers/misc/asus-laptop.c

diff --git a/MAINTAINERS b/MAINTAINERS
index f0596e4..515289a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -584,6 +584,14 @@ W:	http://sourceforge.net/projects/acpi4asus
 W:	http://xf.iksaif.net/acpi4asus
 S:	Maintained
 
+ASUS LAPTOP EXTRAS DRIVER
+P:	Corentin Chary
+M:	corentincj@iksaif.net
+L:	acpi4asus-user@lists.sourceforge.net
+W:	http://sourceforge.net/projects/acpi4asus
+W:	http://xf.iksaif.net/acpi4asus
+S:	Maintained
+
 ATA OVER ETHERNET DRIVER
 P:	Ed L. Cashin
 M:	ecashin@coraid.com
diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index f4f000a..deed0de 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -186,19 +186,22 @@ config ACPI_ASUS
 
 	  Note: display switching code is currently considered EXPERIMENTAL,
 	  toying with these values may even lock your machine.
-          
+
           All settings are changed via /proc/acpi/asus directory entries. Owner
           and group for these entries can be set with asus_uid and asus_gid
           parameters.
-          
+
           More information and a userspace daemon for handling the extra buttons
           at <http://sourceforge.net/projects/acpi4asus/>.
-          
+
           If you have an ACPI-compatible ASUS laptop, say Y or M here. This
           driver is still under development, so if your laptop is unsupported or
           something works not quite as expected, please use the mailing list
-          available on the above page (acpi4asus-user@lists.sourceforge.net)
-          
+          available on the above page (acpi4asus-user@lists.sourceforge.net).
+
+	  NOTE: This driver is deprecated and will probably be removed soon,
+	  use asus-laptop instead.
+
 config ACPI_IBM
 	tristate "IBM ThinkPad Laptop Extras"
 	depends on X86
diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 00db31c..4b1e367 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -69,6 +69,23 @@ config TIFM_7XX1
           To compile this driver as a module, choose M here: the module will
 	  be called tifm_7xx1.
 
+config ASUS_LAPTOP
+        tristate "Asus Laptop Extras (EXPERIMENTAL)"
+        depends on X86
+        depends on ACPI
+	depends on EXPERIMENTAL && !ACPI_ASUS
+        ---help---
+	  This is the new Linux driver for Asus laptops. It may also support some
+	  MEDION, JVC or VICTOR laptops. It makes all the extra buttons generate
+	  standard ACPI events that go through /proc/acpi/events. It also adds
+	  support for video output switching, LCD backlight control, Bluetooth and
+	  Wlan control, and most importantly, allows you to blink those fancy LEDs.
+
+	  For more information and a userspace daemon for handling the extra
+	  buttons see <http://acpi4asus.sf.net/>.
+
+	  If you have an ACPI-compatible ASUS laptop, say Y or M here.
+
 config MSI_LAPTOP
         tristate "MSI Laptop Extras"
         depends on X86
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index c9e98ab..35da53c 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -6,6 +6,7 @@ obj- := misc.o	# Dummy rule to force built-in.o to be made
 obj-$(CONFIG_IBM_ASM)		+= ibmasm/
 obj-$(CONFIG_HDPU_FEATURES)	+= hdpuftrs/
 obj-$(CONFIG_MSI_LAPTOP)     += msi-laptop.o
+obj-$(CONFIG_ASUS_LAPTOP)     += asus-laptop.o
 obj-$(CONFIG_LKDTM)		+= lkdtm.o
 obj-$(CONFIG_TIFM_CORE)       	+= tifm_core.o
 obj-$(CONFIG_TIFM_7XX1)       	+= tifm_7xx1.o
diff --git a/drivers/misc/asus-laptop.c b/drivers/misc/asus-laptop.c
new file mode 100644
index 0000000..959b20f
--- /dev/null
+++ b/drivers/misc/asus-laptop.c
@@ -0,0 +1,530 @@
+/*
+ *  asus-laptop.c - Asus Laptop Support
+ *
+ *
+ *  Copyright (C) 2002-2005 Julien Lerouge, 2003-2006 Karol Kozimor
+ *  Copyright (C) 2006 Corentin Chary
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
+ *
+ *
+ *  The development page for this driver is located at
+ *  http://sourceforge.net/projects/acpi4asus/
+ *
+ *  Credits:
+ *  Pontus Fuchs   - Helper functions, cleanup
+ *  Johann Wiesner - Small compile fixes
+ *  John Belmonte  - ACPI code for Toshiba laptop was a good starting point.
+ *  Eric Burghard  - LED display support for W1N
+ *  Josh Green     - Light Sens support
+ *  Thomas Tuttle  - His first patch for led support was very helpfull
+ *
+ */
+
+#include <linux/autoconf.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/types.h>
+#include <linux/err.h>
+#include <linux/proc_fs.h>
+#include <linux/platform_device.h>
+#include <acpi/acpi_drivers.h>
+#include <acpi/acpi_bus.h>
+#include <asm/uaccess.h>
+
+#define ASUS_LAPTOP_VERSION "0.40"
+
+#define ASUS_HOTK_NAME          "Asus Laptop Support"
+#define ASUS_HOTK_CLASS         "hotkey"
+#define ASUS_HOTK_DEVICE_NAME   "Hotkey"
+#define ASUS_HOTK_HID           "ATK0100"
+#define ASUS_HOTK_FILE          "asus-laptop"
+#define ASUS_HOTK_PREFIX        "\\_SB.ATKD."
+
+#define ASUS_LOG    ASUS_HOTK_FILE ": "
+#define ASUS_ERR    KERN_ERR    ASUS_LOG
+#define ASUS_WARNING    KERN_WARNING    ASUS_LOG
+#define ASUS_NOTICE KERN_NOTICE ASUS_LOG
+#define ASUS_INFO   KERN_INFO   ASUS_LOG
+#define ASUS_DEBUG  KERN_DEBUG  ASUS_LOG
+
+MODULE_AUTHOR("Julien Lerouge, Karol Kozimor, Corentin Chary");
+MODULE_DESCRIPTION(ASUS_HOTK_NAME);
+MODULE_LICENSE("GPL");
+
+#define ASUS_HANDLE(object, paths...)					\
+	static acpi_handle  object##_handle = NULL;			\
+	static char *object##_paths[] = { paths }
+
+/*
+ * This is the main structure, we can use it to store anything interesting
+ * about the hotk device
+ */
+struct asus_hotk {
+	char *name; //laptop name
+	struct acpi_device *device;	//the device we are in
+	acpi_handle handle;	//the handle of the hotk device
+	char status;		//status of the hotk, for LEDs, ...
+	u16 event_count[128];	//count for each event TODO make this better
+};
+
+/*
+ * This header is made available to allow proper configuration given model,
+ * revision number , ... this info cannot go in struct asus_hotk because it is
+ * available before the hotk
+ */
+static struct acpi_table_header *asus_info;
+
+/* The actual device the driver binds to */
+static struct asus_hotk *hotk;
+
+/*
+ * The hotkey driver declaration
+ */
+static int asus_hotk_add(struct acpi_device *device);
+static int asus_hotk_remove(struct acpi_device *device, int type);
+static struct acpi_driver asus_hotk_driver = {
+	.name = ASUS_HOTK_NAME,
+	.class = ASUS_HOTK_CLASS,
+	.ids = ASUS_HOTK_HID,
+	.ops = {
+		.add = asus_hotk_add,
+		.remove = asus_hotk_remove,
+		},
+};
+
+/*
+ * This function evaluates an ACPI method, given an int as parameter, the
+ * method is searched within the scope of the handle, can be NULL. The output
+ * of the method is written is output, which can also be NULL
+ *
+ * returns 1 if write is successful, 0 else.
+ */
+static int write_acpi_int(acpi_handle handle, const char *method, int val,
+			  struct acpi_buffer *output)
+{
+	struct acpi_object_list params;	//list of input parameters (an int here)
+	union acpi_object in_obj;	//the only param we use
+	acpi_status status;
+
+	params.count = 1;
+	params.pointer = &in_obj;
+	in_obj.type = ACPI_TYPE_INTEGER;
+	in_obj.integer.value = val;
+
+	status = acpi_evaluate_object(handle, (char *)method, &params, output);
+	return (status == AE_OK);
+}
+
+static int read_acpi_int(acpi_handle handle, const char *method, int *val,
+			 struct acpi_object_list *params)
+{
+	struct acpi_buffer output;
+	union acpi_object out_obj;
+	acpi_status status;
+
+	output.length = sizeof(out_obj);
+	output.pointer = &out_obj;
+
+	status = acpi_evaluate_object(handle, (char *)method, params, &output);
+	*val = out_obj.integer.value;
+	return (status == AE_OK) && (out_obj.type == ACPI_TYPE_INTEGER);
+}
+
+/*
+ * Platform device handlers
+ */
+
+/*
+ * We write our info in page, we begin at offset off and cannot write more
+ * than count bytes. We set eof to 1 if we handle those 2 values. We return the
+ * number of bytes written in page
+ */
+static ssize_t show_infos(struct device *dev,
+			 struct device_attribute *attr, char *page)
+{
+	int len = 0;
+	int temp;
+	char buf[16];		//enough for all info
+	/*
+	 * We use the easy way, we don't care of off and count, so we don't set eof
+	 * to 1
+	 */
+
+	len += sprintf(page, ASUS_HOTK_NAME " " ASUS_LAPTOP_VERSION "\n");
+	len += sprintf(page + len, "Model reference    : %s\n", hotk->name);
+	/*
+	 * The SFUN method probably allows the original driver to get the list
+	 * of features supported by a given model. For now, 0x0100 or 0x0800
+	 * bit signifies that the laptop is equipped with a Wi-Fi MiniPCI card.
+	 * The significance of others is yet to be found.
+	 */
+	if (read_acpi_int(hotk->handle, "SFUN", &temp, NULL))
+		len +=
+		    sprintf(page + len, "SFUN value         : 0x%04x\n", temp);
+	/*
+	 * Another value for userspace: the ASYM method returns 0x02 for
+	 * battery low and 0x04 for battery critical, its readings tend to be
+	 * more accurate than those provided by _BST.
+	 * Note: since not all the laptops provide this method, errors are
+	 * silently ignored.
+	 */
+	if (read_acpi_int(hotk->handle, "ASYM", &temp, NULL))
+		len +=
+		    sprintf(page + len, "ASYM value         : 0x%04x\n", temp);
+	if (asus_info) {
+		snprintf(buf, 16, "%d", asus_info->length);
+		len += sprintf(page + len, "DSDT length        : %s\n", buf);
+		snprintf(buf, 16, "%d", asus_info->checksum);
+		len += sprintf(page + len, "DSDT checksum      : %s\n", buf);
+		snprintf(buf, 16, "%d", asus_info->revision);
+		len += sprintf(page + len, "DSDT revision      : %s\n", buf);
+		snprintf(buf, 7, "%s", asus_info->oem_id);
+		len += sprintf(page + len, "OEM id             : %s\n", buf);
+		snprintf(buf, 9, "%s", asus_info->oem_table_id);
+		len += sprintf(page + len, "OEM table id       : %s\n", buf);
+		snprintf(buf, 16, "%x", asus_info->oem_revision);
+		len += sprintf(page + len, "OEM revision       : 0x%s\n", buf);
+		snprintf(buf, 5, "%s", asus_info->asl_compiler_id);
+		len += sprintf(page + len, "ASL comp vendor id : %s\n", buf);
+		snprintf(buf, 16, "%x", asus_info->asl_compiler_revision);
+		len += sprintf(page + len, "ASL comp revision  : 0x%s\n", buf);
+	}
+
+	return len;
+}
+
+static int parse_arg(const char *buf, unsigned long count, int *val)
+{
+	if (!count)
+		return 0;
+	if (count > 31)
+		return -EINVAL;
+	if (sscanf(buf, "%i", val) != 1)
+		return -EINVAL;
+	return count;
+}
+
+static void asus_hotk_notify(acpi_handle handle, u32 event, void *data)
+{
+	/* TODO Find a better way to handle events count. */
+	if (!hotk)
+		return;
+
+	acpi_bus_generate_event(hotk->device, event,
+				hotk->event_count[event % 128]++);
+
+	return;
+}
+
+#define ASUS_CREATE_DEVICE_ATTR(_name)					\
+	struct device_attribute dev_attr_##_name = {			\
+		.attr = {						\
+			.name = __stringify(_name),			\
+			.mode = 0,					\
+			.owner = THIS_MODULE },				\
+		.show   = NULL,						\
+		.store  = NULL,						\
+	}
+
+#define ASUS_SET_DEVICE_ATTR(_name, _mode, _show, _store)		\
+	do {								\
+		dev_attr_##_name.attr.mode = _mode;			\
+		dev_attr_##_name.show = _show;				\
+		dev_attr_##_name.store = _store;			\
+	} while(0)
+
+static ASUS_CREATE_DEVICE_ATTR(infos);
+
+static struct attribute *asuspf_attributes[] = {
+        &dev_attr_infos.attr,
+        NULL
+};
+
+static struct attribute_group asuspf_attribute_group = {
+        .attrs = asuspf_attributes
+};
+
+static struct platform_driver asuspf_driver = {
+        .driver = {
+                .name = ASUS_HOTK_FILE,
+                .owner = THIS_MODULE,
+        }
+};
+
+static struct platform_device *asuspf_device;
+
+
+static void asus_hotk_add_fs(void)
+{
+	ASUS_SET_DEVICE_ATTR(infos, 0444, show_infos, NULL);
+}
+
+static int asus_handle_init(char *name, acpi_handle *handle,
+			    char **paths, int num_paths)
+{
+	int i;
+	acpi_status status;
+
+	for (i = 0; i < num_paths; i++) {
+		status = acpi_get_handle(NULL, paths[i], handle);
+		if (ACPI_SUCCESS(status))
+			return 0;
+	}
+
+	*handle = NULL;
+	return -ENODEV;
+}
+
+#define ASUS_HANDLE_INIT(object)					\
+	asus_handle_init(#object, &object##_handle, object##_paths,	\
+			 ARRAY_SIZE(object##_paths))
+
+
+/*
+ * This function is used to initialize the hotk with right values. In this
+ * method, we can make all the detection we want, and modify the hotk struct
+ */
+static int asus_hotk_get_info(void)
+{
+	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
+	struct acpi_buffer dsdt = { ACPI_ALLOCATE_BUFFER, NULL };
+	union acpi_object *model = NULL;
+	int bsts_result;
+	char *string = NULL;
+	acpi_status status;
+
+	/*
+	 * Get DSDT headers early enough to allow for differentiating between
+	 * models, but late enough to allow acpi_bus_register_driver() to fail
+	 * before doing anything ACPI-specific. Should we encounter a machine,
+	 * which needs special handling (i.e. its hotkey device has a different
+	 * HID), this bit will be moved. A global variable asus_info contains
+	 * the DSDT header.
+	 */
+	status = acpi_get_table(ACPI_TABLE_ID_DSDT, 1, &dsdt);
+	if (ACPI_FAILURE(status))
+		printk(ASUS_WARNING "Couldn't get the DSDT table header\n");
+	else
+		asus_info = dsdt.pointer;
+
+	/* We have to write 0 on init this far for all ASUS models */
+	if (!write_acpi_int(hotk->handle, "INIT", 0, &buffer)) {
+		printk(ASUS_ERR "Hotkey initialization failed\n");
+		return -ENODEV;
+	}
+
+	/* This needs to be called for some laptops to init properly */
+	if (!read_acpi_int(hotk->handle, "BSTS", &bsts_result, NULL))
+		printk(ASUS_WARNING "Error calling BSTS\n");
+	else if (bsts_result)
+		printk(ASUS_NOTICE "BSTS called, 0x%02x returned\n",
+		       bsts_result);
+
+	/*
+	 * Try to match the object returned by INIT to the specific model.
+	 * Handle every possible object (or the lack of thereof) the DSDT
+	 * writers might throw at us. When in trouble, we pass NULL to
+	 * asus_model_match() and try something completely different.
+	 */
+	if (buffer.pointer) {
+		model = buffer.pointer;
+		switch (model->type) {
+		case ACPI_TYPE_STRING:
+			string = model->string.pointer;
+			break;
+		case ACPI_TYPE_BUFFER:
+			string = model->buffer.pointer;
+			break;
+		default:
+			string = "";
+			break;
+		}
+	}
+	hotk->name = kstrdup(string, GFP_KERNEL);
+	if (!hotk->name)
+		return -ENOMEM;
+
+	if(*string)
+		printk(ASUS_NOTICE "  %s model detected\n", string);
+
+	kfree(model);
+
+	return AE_OK;
+}
+
+static int asus_hotk_check(void)
+{
+	int result = 0;
+
+	result = acpi_bus_get_status(hotk->device);
+	if (result)
+		return result;
+
+	if (hotk->device->status.present) {
+		result = asus_hotk_get_info();
+	} else {
+		printk(ASUS_ERR "Hotkey device not present, aborting\n");
+		return -EINVAL;
+	}
+
+	return result;
+}
+
+static int asus_hotk_found;
+
+static int asus_hotk_add(struct acpi_device *device)
+{
+	acpi_status status = AE_OK;
+	int result;
+
+	if (!device)
+		return -EINVAL;
+
+	printk(ASUS_NOTICE "Asus Laptop Support version %s\n",
+	       ASUS_LAPTOP_VERSION);
+
+	hotk = kmalloc(sizeof(struct asus_hotk), GFP_KERNEL);
+	if (!hotk)
+		return -ENOMEM;
+	memset(hotk, 0, sizeof(struct asus_hotk));
+
+	hotk->handle = device->handle;
+	strcpy(acpi_device_name(device), ASUS_HOTK_DEVICE_NAME);
+	strcpy(acpi_device_class(device), ASUS_HOTK_CLASS);
+	acpi_driver_data(device) = hotk;
+	hotk->device = device;
+
+	result = asus_hotk_check();
+	if (result)
+		goto end;
+
+	asus_hotk_add_fs();
+
+	/*
+	 * We install the handler, it will receive the hotk in parameter, so, we
+	 * could add other data to the hotk struct
+	 */
+	status = acpi_install_notify_handler(hotk->handle, ACPI_SYSTEM_NOTIFY,
+					     asus_hotk_notify, hotk);
+	if (ACPI_FAILURE(status))
+		printk(ASUS_ERR "Error installing notify handler\n");
+
+	asus_hotk_found = 1;
+
+      end:
+	if (result) {
+		kfree(hotk->name);
+		kfree(hotk);
+	}
+
+	return result;
+}
+
+static int asus_hotk_remove(struct acpi_device *device, int type)
+{
+	acpi_status status = 0;
+
+	if (!device || !acpi_driver_data(device))
+		return -EINVAL;
+
+	status = acpi_remove_notify_handler(hotk->handle, ACPI_SYSTEM_NOTIFY,
+					    asus_hotk_notify);
+	if (ACPI_FAILURE(status))
+		printk(ASUS_ERR "Error removing notify handler\n");
+
+	kfree(hotk->name);
+	kfree(hotk);
+
+	return 0;
+}
+
+static void __exit asus_laptop_exit(void)
+{
+	acpi_bus_unregister_driver(&asus_hotk_driver);
+        sysfs_remove_group(&asuspf_device->dev.kobj, &asuspf_attribute_group);
+        platform_device_unregister(asuspf_device);
+        platform_driver_unregister(&asuspf_driver);
+
+	kfree(asus_info);
+}
+
+static int __init asus_laptop_init(void)
+{
+	int result;
+
+	if (acpi_disabled)
+		return -ENODEV;
+
+	if (!acpi_specific_hotkey_enabled) {
+		printk(ASUS_ERR "Using generic hotkey driver\n");
+		return -ENODEV;
+	}
+
+	result = acpi_bus_register_driver(&asus_hotk_driver);
+	if (result < 0)
+		return result;
+
+	/*
+	 * This is a bit of a kludge.  We only want this module loaded
+	 * for ASUS systems, but there's currently no way to probe the
+	 * ACPI namespace for ASUS HIDs.  So we just return failure if
+	 * we didn't find one, which will cause the module to be
+	 * unloaded.
+	 */
+	if (!asus_hotk_found) {
+		acpi_bus_unregister_driver(&asus_hotk_driver);
+		return -ENODEV;
+	}
+
+        /* Register platform stuff */
+	result = platform_driver_register(&asuspf_driver);
+        if (result)
+                goto fail_platform_driver;
+
+        asuspf_device = platform_device_alloc(ASUS_HOTK_FILE, -1);
+        if (!asuspf_device) {
+                result = -ENOMEM;
+                goto fail_platform_device1;
+        }
+
+        result = platform_device_add(asuspf_device);
+        if (result)
+                goto fail_platform_device2;
+
+        result = sysfs_create_group(&asuspf_device->dev.kobj,
+				    &asuspf_attribute_group);
+        if (result)
+                goto fail_sysfs;
+
+        return 0;
+
+fail_sysfs:
+        platform_device_del(asuspf_device);
+
+fail_platform_device2:
+	platform_device_put(asuspf_device);
+
+fail_platform_device1:
+        platform_driver_unregister(&asuspf_driver);
+
+fail_platform_driver:
+
+	return result;
+}
+
+module_init(asus_laptop_init);
+module_exit(asus_laptop_exit);
-- 
1.5.0.rc3.39.gec804
