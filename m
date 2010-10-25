From: Len Brown <lenb@kernel.org>
Subject: [PATCH 18/60] ACPI: Do not export hid/modalias sysfs file for ACPI
 objects without a HID
Date: Mon, 25 Oct 2010 02:20:26 -0400
Message-ID: <2b2ae7c7f8e25043793042eb9df88aa875b4cff8.1287987547.git.len.brown@intel.com>
References: <1287987668-17584-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173007pub.verizon.net ([206.46.173.7]:38315 "EHLO
	vms173007pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754127Ab0JYJLJ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 25 Oct 2010 05:11:09 -0400
Received: from localhost.localdomain ([unknown] [74.104.161.234])
 by vms173007.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LAU004W59ICTPC0@vms173007.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Mon, 25 Oct 2010 04:11:08 -0500 (CDT)
In-reply-to: <1287987668-17584-1-git-send-email-lenb@kernel.org>
In-reply-to: <a210080195c95ebca2a517ee3057d71607aa65e0.1287987547.git.len.brown@intel.com>
References: <a210080195c95ebca2a517ee3057d71607aa65e0.1287987547.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Thomas Renninger <trenn@suse.de>, Zhang Rui <rui.zhang@intel.com>, kay.sievers@vrfy.org, Bjorn Helgaas <bjorn.helgaas@hp.com>, Len Brown <len.brown@intel.com>

From: Thomas Renninger <trenn@suse.de>

Boot and compile tested.
The fact that pnp.ids can now be empty needs testing on some
further machines, though.

This should handle a "modprobe is wrongly called by udev" issue:
https://bugzilla.kernel.org/show_bug.cgi?id=19162

Modaliase files in
/sys/devices/LNXSYSTM:00/
went down from 113 to 71 on my tested system.

This is a sysfs change, but userspace must already be able to handle it.

Also do not fill up pnp.ids list with a "struct hid"
entry. This comment:
     * This generic ID isn't useful for driver binding, but it provides
     * the useful property that "every acpi_device has an ID."
is still half way true:
Best you never touch pnp.ids list directly or make sure it can be empty,
instead use:
char *acpi_device_hid()
which always returns a value ("device" as a dummy if the object
has no hid).

Signed-off-by: Thomas Renninger <trenn@suse.de>
CC: Zhang Rui <rui.zhang@intel.com>
CC: kay.sievers@vrfy.org
CC: Bjorn Helgaas <bjorn.helgaas@hp.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/scan.c |   36 ++++++++++++++++++++----------------
 1 files changed, 20 insertions(+), 16 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index b23825e..81aec8d 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -26,6 +26,9 @@ extern struct acpi_device *acpi_root;
 
 #define ACPI_IS_ROOT_DEVICE(device)    (!(device)->parent)
 
+/* Should be const */
+static char* dummy_hid = "device";
+
 static LIST_HEAD(acpi_device_list);
 static LIST_HEAD(acpi_bus_id_list);
 DEFINE_MUTEX(acpi_device_lock);
@@ -49,6 +52,9 @@ static int create_modalias(struct acpi_device *acpi_dev, char *modalias,
 	int count;
 	struct acpi_hardware_id *id;
 
+	if (list_empty(&acpi_dev->pnp.ids))
+		return 0;
+
 	len = snprintf(modalias, size, "acpi:");
 	size -= len;
 
@@ -202,13 +208,15 @@ static int acpi_device_setup_files(struct acpi_device *dev)
 			goto end;
 	}
 
-	result = device_create_file(&dev->dev, &dev_attr_hid);
-	if (result)
-		goto end;
+	if (!list_empty(&dev->pnp.ids)) {
+		result = device_create_file(&dev->dev, &dev_attr_hid);
+		if (result)
+			goto end;
 
-	result = device_create_file(&dev->dev, &dev_attr_modalias);
-	if (result)
-		goto end;
+		result = device_create_file(&dev->dev, &dev_attr_modalias);
+		if (result)
+			goto end;
+	}
 
         /*
          * If device has _EJ0, 'eject' file is created that is used to trigger
@@ -316,6 +324,9 @@ static int acpi_device_uevent(struct device *dev, struct kobj_uevent_env *env)
 	struct acpi_device *acpi_dev = to_acpi_device(dev);
 	int len;
 
+	if (list_empty(&acpi_dev->pnp.ids))
+		return 0;
+
 	if (add_uevent_var(env, "MODALIAS="))
 		return -ENOMEM;
 	len = create_modalias(acpi_dev, &env->buf[env->buflen - 1],
@@ -1014,6 +1025,9 @@ char *acpi_device_hid(struct acpi_device *device)
 {
 	struct acpi_hardware_id *hid;
 
+	if (list_empty(&device->pnp.ids))
+		return dummy_hid;
+
 	hid = list_first_entry(&device->pnp.ids, struct acpi_hardware_id, list);
 	return hid->id;
 }
@@ -1142,16 +1156,6 @@ static void acpi_device_set_id(struct acpi_device *device)
 		acpi_add_id(device, ACPI_BUTTON_HID_SLEEPF);
 		break;
 	}
-
-	/*
-	 * We build acpi_devices for some objects that don't have _HID or _CID,
-	 * e.g., PCI bridges and slots.  Drivers can't bind to these objects,
-	 * but we do use them indirectly by traversing the acpi_device tree.
-	 * This generic ID isn't useful for driver binding, but it provides
-	 * the useful property that "every acpi_device has an ID."
-	 */
-	if (list_empty(&device->pnp.ids))
-		acpi_add_id(device, "device");
 }
 
 static int acpi_device_set_context(struct acpi_device *device)
-- 
1.7.3.2.90.gd4c43

