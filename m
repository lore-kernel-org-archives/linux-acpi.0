From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 2/2] ACPI / hotplug: Remove containers synchronously
Date: Wed, 28 Aug 2013 15:51:41 +0200
Message-ID: <1883675.1ifF1KoWz3@vostro.rjw.lan>
References: <1543475.L7gSB7lLAu@vostro.rjw.lan> <1592448.YZbpON5n7n@vostro.rjw.lan> <26495758.n1zOCiG3iV@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <26495758.n1zOCiG3iV@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tejun Heo <tj@kernel.org>, Gu Zheng <guz.fnst@cn.fujitsu.com>, Toshi Kani <toshi.kani@hp.com>, LKML <linux-kernel@vger.kernel.org>, Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
List-Id: linux-acpi@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The current protocol for handling hot remove of containers is very
fragile and causes acpi_eject_store() to acquire acpi_scan_lock
which may deadlock with the removal of the device that it is called
for (the reason is that device sysfs attributes cannot be removed
while their callbacks are being executed and ACPI device objects
are removed under acpi_scan_lock).

The problem is related to the fact that containers are handled by
acpi_bus_device_eject() in a special way, which is to emit an
offline uevent instead of just removing the container.  Then, user
space is expected to handle that uevent and use the container's
"eject" attribute to actually remove it.  That is fragile, because
user space may fail to complete the ejection (for example, by not
using the container's "eject" attribute at all) leaving the BIOS
kind of in a limbo.  Moreover, if the eject event is not signaled
for a container itself, but for its parent device object (or
generally, for an ancestor above it in the ACPI namespace), the
container will be removed straight away without doing that whole
dance.

For this reason, modify acpi_bus_device_eject() to remove containers
synchronously like any other objects (user space will get its uevent
anyway in case it does some other things in response to it) and
remove the eject_pending ACPI device flag that is not used any more.
This way acpi_eject_store() doesn't have a reason to acquire
acpi_scan_lock any more and one possible deadlock scenario goes
away (plus the code is simplified a bit).

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reported-by: Gu Zheng <guz.fnst@cn.fujitsu.com>
---
 drivers/acpi/scan.c     |   49 ++++++++++++++----------------------------------
 include/acpi/acpi_bus.h |    3 --
 2 files changed, 16 insertions(+), 36 deletions(-)

Index: linux-pm/drivers/acpi/scan.c
===================================================================
--- linux-pm.orig/drivers/acpi/scan.c
+++ linux-pm/drivers/acpi/scan.c
@@ -287,6 +287,7 @@ static void acpi_bus_device_eject(void *
 	struct acpi_device *device = NULL;
 	struct acpi_scan_handler *handler;
 	u32 ost_code = ACPI_OST_SC_NON_SPECIFIC_FAILURE;
+	int error;
 
 	mutex_lock(&acpi_scan_lock);
 
@@ -301,17 +302,13 @@ static void acpi_bus_device_eject(void *
 	}
 	acpi_evaluate_hotplug_ost(handle, ACPI_NOTIFY_EJECT_REQUEST,
 				  ACPI_OST_SC_EJECT_IN_PROGRESS, NULL);
-	if (handler->hotplug.mode == AHM_CONTAINER) {
-		device->flags.eject_pending = true;
+	if (handler->hotplug.mode == AHM_CONTAINER)
 		kobject_uevent(&device->dev.kobj, KOBJ_OFFLINE);
-	} else {
-		int error;
 
-		get_device(&device->dev);
-		error = acpi_scan_hot_remove(device);
-		if (error)
-			goto err_out;
-	}
+	get_device(&device->dev);
+	error = acpi_scan_hot_remove(device);
+	if (error)
+		goto err_out;
 
  out:
 	mutex_unlock(&acpi_scan_lock);
@@ -496,7 +493,6 @@ acpi_eject_store(struct device *d, struc
 	struct acpi_eject_event *ej_event;
 	acpi_object_type not_used;
 	acpi_status status;
-	u32 ost_source;
 	int ret;
 
 	if (!count || buf[0] != '1')
@@ -510,43 +506,28 @@ acpi_eject_store(struct device *d, struc
 	if (ACPI_FAILURE(status) || !acpi_device->flags.ejectable)
 		return -ENODEV;
 
-	mutex_lock(&acpi_scan_lock);
-
-	if (acpi_device->flags.eject_pending) {
-		/* ACPI eject notification event. */
-		ost_source = ACPI_NOTIFY_EJECT_REQUEST;
-		acpi_device->flags.eject_pending = 0;
-	} else {
-		/* Eject initiated by user space. */
-		ost_source = ACPI_OST_EC_OSPM_EJECT;
-	}
 	ej_event = kmalloc(sizeof(*ej_event), GFP_KERNEL);
 	if (!ej_event) {
 		ret = -ENOMEM;
 		goto err_out;
 	}
-	acpi_evaluate_hotplug_ost(acpi_device->handle, ost_source,
+	acpi_evaluate_hotplug_ost(acpi_device->handle, ACPI_OST_EC_OSPM_EJECT,
 				  ACPI_OST_SC_EJECT_IN_PROGRESS, NULL);
 	ej_event->device = acpi_device;
-	ej_event->event = ost_source;
+	ej_event->event = ACPI_OST_EC_OSPM_EJECT;
 	get_device(&acpi_device->dev);
 	status = acpi_os_hotplug_execute(acpi_bus_hot_remove_device, ej_event);
-	if (ACPI_FAILURE(status)) {
-		put_device(&acpi_device->dev);
-		kfree(ej_event);
-		ret = status == AE_NO_MEMORY ? -ENOMEM : -EAGAIN;
-		goto err_out;
-	}
-	ret = count;
+	if (ACPI_SUCCESS(status))
+		return count;
 
- out:
-	mutex_unlock(&acpi_scan_lock);
-	return ret;
+	put_device(&acpi_device->dev);
+	kfree(ej_event);
+	ret = status == AE_NO_MEMORY ? -ENOMEM : -EAGAIN;
 
  err_out:
-	acpi_evaluate_hotplug_ost(acpi_device->handle, ost_source,
+	acpi_evaluate_hotplug_ost(acpi_device->handle, ACPI_OST_EC_OSPM_EJECT,
 				  ACPI_OST_SC_NON_SPECIFIC_FAILURE, NULL);
-	goto out;
+	return ret;
 }
 
 static DEVICE_ATTR(eject, 0200, NULL, acpi_eject_store);
Index: linux-pm/include/acpi/acpi_bus.h
===================================================================
--- linux-pm.orig/include/acpi/acpi_bus.h
+++ linux-pm/include/acpi/acpi_bus.h
@@ -167,9 +167,8 @@ struct acpi_device_flags {
 	u32 removable:1;
 	u32 ejectable:1;
 	u32 power_manageable:1;
-	u32 eject_pending:1;
 	u32 match_driver:1;
-	u32 reserved:26;
+	u32 reserved:27;
 };
 
 /* File System */
