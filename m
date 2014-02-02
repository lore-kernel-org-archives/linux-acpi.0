From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH v2 1/6] ACPI / hotplug: Fix theoretical race in acpi_hotplug_notify_cb()
Date: Sun, 02 Feb 2014 01:54:02 +0100
Message-ID: <2304222.JefaLY6VAk@vostro.rjw.lan>
References: <2217793.001RY6hKlo@vostro.rjw.lan> <1693151.2qrLZHyp0o@vostro.rjw.lan> <1519631.YS65c9Af2C@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1519631.YS65c9Af2C@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Aaron Lu <aaron.lu@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PCI <linux-pci@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>
List-Id: linux-acpi@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

There is a slight possibility for the ACPI device object pointed to
by adev in acpi_hotplug_notify_cb() to become invalid between the
acpi_bus_get_device() that it comes from and the subsequent get_device().
Namely, if acpi_scan_drop_device() runs concurrently with respect to
acpi_hotplug_notify_cb() and acpi_device_del_list is not empty,
acpi_device_del_work_fn() may delete the device object in question
without waiting for the ACPI events workqueue to drain, which very
well may happen right after a successful execution of
acpi_bus_get_device() in acpi_hotplug_notify_cb().

To prevent that from happening, run acpi_bus_get_device() and the
subsequent get_device() in acpi_hotplug_notify_cb() under
acpi_device_del_lock, so that the deletion of the given device
object cannot be queued up by acpi_scan_drop_device() between the
two.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/scan.c |   14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

Index: linux-pm/drivers/acpi/scan.c
===================================================================
--- linux-pm.orig/drivers/acpi/scan.c
+++ linux-pm/drivers/acpi/scan.c
@@ -41,6 +41,8 @@ static DEFINE_MUTEX(acpi_scan_lock);
 static LIST_HEAD(acpi_scan_handlers_list);
 DEFINE_MUTEX(acpi_device_lock);
 LIST_HEAD(acpi_wakeup_device_list);
+static LIST_HEAD(acpi_device_del_list);
+static DEFINE_MUTEX(acpi_device_del_lock);
 
 struct acpi_device_bus_id{
 	char bus_id[15];
@@ -488,9 +490,6 @@ static void acpi_hotplug_notify_cb(acpi_
 	struct acpi_device *adev;
 	acpi_status status;
 
-	if (acpi_bus_get_device(handle, &adev))
-		goto err_out;
-
 	switch (type) {
 	case ACPI_NOTIFY_BUS_CHECK:
 		acpi_handle_debug(handle, "ACPI_NOTIFY_BUS_CHECK event\n");
@@ -512,7 +511,13 @@ static void acpi_hotplug_notify_cb(acpi_
 		/* non-hotplug event; possibly handled by other handler */
 		return;
 	}
+	mutex_lock(&acpi_device_del_lock);
+	if (acpi_bus_get_device(handle, &adev)) {
+		mutex_unlock(&acpi_device_del_lock);
+		goto err_out;
+	}
 	get_device(&adev->dev);
+	mutex_unlock(&acpi_device_del_lock);
 	status = acpi_hotplug_execute(acpi_device_hotplug, adev, type);
 	if (ACPI_SUCCESS(status))
 		return;
@@ -1042,9 +1047,6 @@ static void acpi_device_del(struct acpi_
 	device_del(&device->dev);
 }
 
-static LIST_HEAD(acpi_device_del_list);
-static DEFINE_MUTEX(acpi_device_del_lock);
-
 static void acpi_device_del_work_fn(struct work_struct *work_not_used)
 {
 	for (;;) {
