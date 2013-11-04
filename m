From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH on top of 3/3] ACPI / hotplug: Remove unnecessary get_device() and put_device()
Date: Mon, 04 Nov 2013 01:41:30 +0100
Message-ID: <4764721.0I4yXO61da@vostro.rjw.lan>
References: <5839747.7HXXGHmMBd@vostro.rjw.lan> <5913958.7oJcoqqQ9l@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <5913958.7oJcoqqQ9l@vostro.rjw.lan>
Sender: linux-pci-owner@vger.kernel.org
To: ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PCI <linux-pci@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Toshi Kani <toshi.kani@hp.com>, Yinghai Lu <yinghai@kernel.org>
List-Id: linux-acpi@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The get_device() and put_device() calls made by acpi_bus_device_eject()
and acpi_scan_hot_remove(), respectively, are not necessary any more,
so remove them.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

Actually, after https://patchwork.kernel.org/patch/3134091/ the
get_device() and put_device() calls may be dropped just fine.

Thanks,
Rafael

---
 drivers/acpi/scan.c |    5 -----
 1 file changed, 5 deletions(-)

Index: linux-pm/drivers/acpi/scan.c
===================================================================
--- linux-pm.orig/drivers/acpi/scan.c
+++ linux-pm/drivers/acpi/scan.c
@@ -205,7 +205,6 @@ static int acpi_scan_hot_remove(struct a
 	/* If there is no handle, the device node has been unregistered. */
 	if (!handle) {
 		dev_dbg(&device->dev, "ACPI handle missing\n");
-		put_device(&device->dev);
 		return -EINVAL;
 	}
 
@@ -226,7 +225,6 @@ static int acpi_scan_hot_remove(struct a
 		dev_warn(errdev, "Offline disabled.\n");
 		acpi_walk_namespace(ACPI_TYPE_ANY, handle, ACPI_UINT32_MAX,
 				    acpi_bus_online, NULL, NULL, NULL);
-		put_device(&device->dev);
 		return -EPERM;
 	}
 	acpi_bus_offline(handle, 0, (void *)false, (void **)&errdev);
@@ -245,7 +243,6 @@ static int acpi_scan_hot_remove(struct a
 			acpi_walk_namespace(ACPI_TYPE_ANY, handle,
 					    ACPI_UINT32_MAX, acpi_bus_online,
 					    NULL, NULL, NULL);
-			put_device(&device->dev);
 			return -EBUSY;
 		}
 	}
@@ -256,7 +253,6 @@ static int acpi_scan_hot_remove(struct a
 	acpi_bus_trim(device);
 
 	/* Device node has been unregistered. */
-	put_device(&device->dev);
 	device = NULL;
 
 	acpi_evaluate_lck(handle, 0);
@@ -310,7 +306,6 @@ static void acpi_bus_device_eject(acpi_h
 	if (handler->hotplug.mode == AHM_CONTAINER)
 		kobject_uevent(&device->dev.kobj, KOBJ_OFFLINE);
 
-	get_device(&device->dev);
 	error = acpi_scan_hot_remove(device);
 	if (error == -EPERM) {
 		goto err_support;
