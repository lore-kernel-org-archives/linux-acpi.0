From: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
Subject: [PATCH] ACPI  : Implement ACPI_NOTIFY_EJECT_REQUEST for ACPI container
Date: Tue, 05 Jun 2012 15:26:36 +0900
Message-ID: <4FCDA69C.3040204@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:50930 "EHLO
	fgwmail5.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753693Ab2FEG0i (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 5 Jun 2012 02:26:38 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

Even if ACPI_NOTIFY_EJECT_REQUEST is notified to ACPI container, ACPI
container just calls kobject_uevent(). The patch implements a function
to remove all devices included in ACPI container.

Signed-off-by: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>

---
 drivers/acpi/container.c |   32 ++++++++++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

Index: linux-3.5-rc1/drivers/acpi/container.c
===================================================================
--- linux-3.5-rc1.orig/drivers/acpi/container.c	2012-06-05 14:01:54.000000000 +0900
+++ linux-3.5-rc1/drivers/acpi/container.c	2012-06-05 14:17:40.940836226 +0900
@@ -123,6 +123,8 @@ static int acpi_container_remove(struct
 	acpi_status status = AE_OK;
 	struct acpi_container *pc = NULL;

+	kobject_uevent(&device->dev.kobj, KOBJ_OFFLINE);
+
 	pc = acpi_driver_data(device);
 	kfree(pc);
 	return status;
@@ -152,6 +154,32 @@ static int container_device_add(struct a
 	return result;
 }

+static void container_device_remove(struct acpi_device *device,
+				    acpi_handle handle)
+{
+	struct acpi_object_list arg_list;
+	union acpi_object arg;
+	int result;
+	acpi_status status;
+
+	result = acpi_bus_trim(device, 1);
+	if (result) {
+		printk(KERN_WARNING "Removing contaier failed");
+		return;
+	}
+
+	arg_list.count = 1;
+	arg_list.pointer = &arg;
+	arg.type = ACPI_TYPE_INTEGER;
+	arg.integer.value = 1;
+
+	status = acpi_evaluate_object(handle, "_EJ0", &arg_list, NULL);
+	if (ACPI_FAILURE(status))
+		printk(KERN_WARNING "Eject device failed\n");
+
+	return;
+}
+
 static void container_notify_cb(acpi_handle handle, u32 type, void *context)
 {
 	struct acpi_device *device = NULL;
@@ -183,13 +211,13 @@ static void container_notify_cb(acpi_han
 		} else {
 			if (ACPI_SUCCESS(status)) {
 				/* device exist and this is a remove request */
-				kobject_uevent(&device->dev.kobj, KOBJ_OFFLINE);
+				container_device_remove(device, handle);
 			}
 		}
 		break;
 	case ACPI_NOTIFY_EJECT_REQUEST:
 		if (!acpi_bus_get_device(handle, &device) && device) {
-			kobject_uevent(&device->dev.kobj, KOBJ_OFFLINE);
+			container_device_remove(device, handle);
 		}
 		break;
 	default:

