From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: [PATCH 6/7] acer-wmi: Add debugfs file for device detection
Date: Sat, 21 Jun 2008 09:09:53 +0100
Message-ID: <20080621080953.26920.62288.stgit@pacifica>
References: <20080621080903.26920.14225.stgit@pacifica>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from bb-87-81-255-5.ukonline.co.uk ([87.81.255.5]:38509 "EHLO
	pacifica" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755172AbYFUIgQ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 21 Jun 2008 04:36:16 -0400
In-Reply-To: <20080621080903.26920.14225.stgit@pacifica>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: lenb@kernel.org

Add a debugfs file for showing the full results of the method we use to
detect devices on WMID laptops.

This should be useful in the case that a Linux user gets an Acer laptop
with 3G support (and/ or people who enjoy ripping their wireless cards out)
so we can get some feedback on how this value changes in these cases.

(At the moment, we always enable the wireless and 3G control. In the case
of the former, this is fairly safe. In the case of the latter though,
trying to toggle this device if it doesn't exist on a laptop causes ACPI
warnings/ errors).

To summarise: If you have an Acer laptop with a built in 3G card, please
report back the value from this file.

Signed-off-by: Carlos Corbacho <carlos@strangeworlds.co.uk>
---

 drivers/misc/acer-wmi.c |   66 +++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 66 insertions(+), 0 deletions(-)


diff --git a/drivers/misc/acer-wmi.c b/drivers/misc/acer-wmi.c
index dd0b8d8..d8b8574 100644
--- a/drivers/misc/acer-wmi.c
+++ b/drivers/misc/acer-wmi.c
@@ -35,6 +35,7 @@
 #include <linux/platform_device.h>
 #include <linux/acpi.h>
 #include <linux/i8042.h>
+#include <linux/debugfs.h>
 
 #include <acpi/acpi_drivers.h>
 
@@ -152,6 +153,12 @@ struct acer_data {
 	int brightness;
 };
 
+struct acer_debug {
+	struct dentry *root;
+	struct dentry *devices;
+	u32 wmid_devices;
+};
+
 /* Each low-level interface must define at least some of the following */
 struct wmi_interface {
 	/* The WMI device type */
@@ -162,6 +169,9 @@ struct wmi_interface {
 
 	/* Private data for the current interface */
 	struct acer_data data;
+
+	/* debugfs entries associated with this interface */
+	struct acer_debug debug;
 };
 
 /* The static interface pointer, points to the currently detected interface */
@@ -956,6 +966,28 @@ static DEVICE_ATTR(interface, S_IWUGO | S_IRUGO | S_IWUSR,
 	show_interface, NULL);
 
 /*
+ * debugfs functions
+ */
+static u32 get_wmid_devices(void)
+{
+	struct acpi_buffer out = {ACPI_ALLOCATE_BUFFER, NULL};
+	union acpi_object *obj;
+	acpi_status status;
+
+	status = wmi_query_block(WMID_GUID2, 1, &out);
+	if (ACPI_FAILURE(status))
+		return 0;
+
+	obj = (union acpi_object *) out.pointer;
+	if (obj && obj->type == ACPI_TYPE_BUFFER &&
+		obj->buffer.length == sizeof(u32)) {
+		return *((u32 *) obj->buffer.pointer);
+	} else {
+		return 0;
+	}
+}
+
+/*
  * Platform device
  */
 static int __devinit acer_platform_probe(struct platform_device *device)
@@ -1114,6 +1146,33 @@ error_sysfs:
 	return retval;
 }
 
+static void remove_debugfs(void)
+{
+	debugfs_remove(interface->debug.devices);
+	debugfs_remove(interface->debug.root);
+}
+
+static int create_debugfs(void)
+{
+	interface->debug.root = debugfs_create_dir("acer-wmi", NULL);
+	if (!interface->debug.root) {
+		printk(ACER_ERR "Failed to create debugfs directory");
+		return -ENOMEM;
+	}
+
+	interface->debug.devices = debugfs_create_u32("devices", S_IRUGO,
+					interface->debug.root,
+					&interface->debug.wmid_devices);
+	if (!interface->debug.devices)
+		goto error_debugfs;
+
+	return 0;
+
+error_debugfs:
+		remove_debugfs();
+	return -ENOMEM;
+}
+
 static int __init acer_wmi_init(void)
 {
 	int err;
@@ -1173,6 +1232,13 @@ static int __init acer_wmi_init(void)
 	if (err)
 		return err;
 
+	if (wmi_has_guid(WMID_GUID2)) {
+		interface->debug.wmid_devices = get_wmid_devices();
+		err = create_debugfs();
+		if (err)
+			return err;
+	}
+
 	/* Override any initial settings with values from the commandline */
 	acer_commandline_init();
 

