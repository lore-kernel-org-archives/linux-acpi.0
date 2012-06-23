From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 21/21] ACPI / PM: Drop PM callbacks from the ACPI bus type
Date: Sat, 23 Jun 2012 23:22:01 +0200
Message-ID: <201206232322.02032.rjw@sisk.pl>
References: <201206232306.06602.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <201206232306.06602.rjw@sisk.pl>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Len Brown <lenb@kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>, platform-driver-x86@vger.kernel.org, Eric Piel <eric.piel@tremplin-utc.net>, Mattia Dongili <malattia@linux.it>, Harald Welte <laforge@gnumonks.org>
List-Id: linux-acpi@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

Since the ACPI bus type's PM callbacks only execute the driver ones
without doing anything else, they can be dropped, because the driver
callbacks will be executed by the PM core directly if bus type
(or other subsystem) callbacks are not present.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/acpi/scan.c |   51 ---------------------------------------------------
 1 file changed, 51 deletions(-)

Index: linux/drivers/acpi/scan.c
===================================================================
--- linux.orig/drivers/acpi/scan.c
+++ linux/drivers/acpi/scan.c
@@ -290,56 +290,6 @@ static void acpi_device_release(struct d
 	kfree(acpi_dev);
 }
 
-#define ACPI_DEV_PM_CALLBACK(dev, callback)		\
-({								\
-	struct device_driver *__drv = dev->driver;		\
-	int __ret = 0;						\
-								\
-	if (__drv && __drv->pm && __drv->pm->callback)		\
-		__ret = __drv->pm->callback(dev);		\
-								\
-	__ret;							\
-})
-
-static int acpi_pm_suspend(struct device *dev)
-{
-	return ACPI_DEV_PM_CALLBACK(dev, suspend);
-}
-
-static int acpi_pm_resume(struct device *dev)
-{
-	return ACPI_DEV_PM_CALLBACK(dev, resume);
-}
-
-static int acpi_pm_freeze(struct device *dev)
-{
-	return ACPI_DEV_PM_CALLBACK(dev, freeze);
-}
-
-static int acpi_pm_thaw(struct device *dev)
-{
-	return ACPI_DEV_PM_CALLBACK(dev, thaw);
-}
-
-static int acpi_pm_poweroff(struct device *dev)
-{
-	return ACPI_DEV_PM_CALLBACK(dev, poweroff);
-}
-
-static int acpi_pm_restore(struct device *dev)
-{
-	return ACPI_DEV_PM_CALLBACK(dev, restore);
-}
-
-static const struct dev_pm_ops acpi_bus_pm = {
-	.suspend = acpi_pm_suspend,
-	.resume = acpi_pm_resume,
-	.freeze = acpi_pm_freeze,
-	.thaw = acpi_pm_thaw,
-	.poweroff = acpi_pm_poweroff,
-	.restore = acpi_pm_restore,
-};
-
 static int acpi_bus_match(struct device *dev, struct device_driver *drv)
 {
 	struct acpi_device *acpi_dev = to_acpi_device(dev);
@@ -475,7 +425,6 @@ struct bus_type acpi_bus_type = {
 	.probe		= acpi_device_probe,
 	.remove		= acpi_device_remove,
 	.uevent		= acpi_device_uevent,
-	.pm		= &acpi_bus_pm,
 };
 
 static int acpi_device_register(struct acpi_device *device)
