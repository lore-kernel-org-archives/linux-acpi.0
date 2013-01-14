From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 2/5] ACPI / scan: Drop the second argument of acpi_device_unregister()
Date: Mon, 14 Jan 2013 22:37:33 +0100
Message-ID: <2954236.mW9m30A4Zp@vostro.rjw.lan>
References: <3885603.ydrrB7OEKf@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:40743 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758053Ab3ANVde (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 14 Jan 2013 16:33:34 -0500
In-Reply-To: <3885603.ydrrB7OEKf@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, LKML <linux-kernel@vger.kernel.org>, Toshi Kani <toshi.kani@hp.com>, Yinghai Lu <yinghai@kernel.org>, Jiang Liu <jiang.liu@huawei.com>, Taku Izumi <izumi.taku@jp.fujitsu.com>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Drop the second argument of acpi_device_unregister(), type, which is
not used by that function.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/scan.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

Index: linux-pm/drivers/acpi/scan.c
===================================================================
--- linux-pm.orig/drivers/acpi/scan.c
+++ linux-pm/drivers/acpi/scan.c
@@ -776,7 +776,7 @@ int acpi_device_register(struct acpi_dev
 	return result;
 }
 
-static void acpi_device_unregister(struct acpi_device *device, int type)
+static void acpi_device_unregister(struct acpi_device *device)
 {
 	mutex_lock(&acpi_device_lock);
 	if (device->parent)
@@ -1436,7 +1436,7 @@ static int acpi_bus_remove(struct acpi_d
 	if (!rmdevice)
 		return 0;
 
-	acpi_device_unregister(dev, ACPI_BUS_REMOVAL_EJECT);
+	acpi_device_unregister(dev);
 
 	return 0;
 }
@@ -1750,7 +1750,7 @@ int __init acpi_scan_init(void)
 		result = acpi_bus_scan_fixed();
 
 	if (result)
-		acpi_device_unregister(acpi_root, ACPI_BUS_REMOVAL_NORMAL);
+		acpi_device_unregister(acpi_root);
 	else
 		acpi_update_all_gpes();
 
