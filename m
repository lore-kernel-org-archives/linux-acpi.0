From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] ACPI / dock: Make 'docked' sysfs attribute work as documented
Date: Sat, 15 Feb 2014 01:53:20 +0100
Message-ID: <2379022.bUy4KDZIf7@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

After recent ACPI core changes acpi_bus_get_device() will always
succeed for dock station ACPI device objects, so show_docked()
should not use that function's return value as an indicator of
whether or not the dock device is present.

Make it use acpi_device_enumerated() for this purpose.

Fixes: 202317a573b2 (ACPI / scan: Add acpi_device objects for all device nodes in the namespace)
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

3.14 material overlooked previously.

And I actually was able to test this one some. :-)

Thanks,
Rafael

---
 drivers/acpi/dock.c |    8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

Index: linux-pm/drivers/acpi/dock.c
===================================================================
--- linux-pm.orig/drivers/acpi/dock.c
+++ linux-pm/drivers/acpi/dock.c
@@ -713,13 +713,11 @@ static acpi_status __init find_dock_devi
 static ssize_t show_docked(struct device *dev,
 			   struct device_attribute *attr, char *buf)
 {
-	struct acpi_device *tmp;
-
 	struct dock_station *dock_station = dev->platform_data;
+	struct acpi_device *adev = NULL;
 
-	if (!acpi_bus_get_device(dock_station->handle, &tmp))
-		return snprintf(buf, PAGE_SIZE, "1\n");
-	return snprintf(buf, PAGE_SIZE, "0\n");
+	acpi_bus_get_device(dock_station->handle, &adev);
+	return snprintf(buf, PAGE_SIZE, "%u\n", acpi_device_enumerated(adev));
 }
 static DEVICE_ATTR(docked, S_IRUGO, show_docked, NULL);
 
