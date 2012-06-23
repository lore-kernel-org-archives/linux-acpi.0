From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 4/21] ACPI: Use struct dev_pm_ops for power management in the fan driver
Date: Sat, 23 Jun 2012 23:10:38 +0200
Message-ID: <201206232310.38547.rjw@sisk.pl>
References: <201206232306.06602.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201206232306.06602.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Len Brown <lenb@kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>, platform-driver-x86@vger.kernel.org, Eric Piel <eric.piel@tremplin-utc.net>, Mattia Dongili <malattia@linux.it>, Harald Welte <laforge@gnumonks.org>
List-Id: linux-acpi@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

Make the ACPI fan driver define its PM callbacks through
a struct dev_pm_ops object rather than by using legacy PM hooks
in struct acpi_device_ops.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/acpi/fan.c |   21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

Index: linux/drivers/acpi/fan.c
===================================================================
--- linux.orig/drivers/acpi/fan.c
+++ linux/drivers/acpi/fan.c
@@ -46,8 +46,6 @@ MODULE_LICENSE("GPL");
 
 static int acpi_fan_add(struct acpi_device *device);
 static int acpi_fan_remove(struct acpi_device *device, int type);
-static int acpi_fan_suspend(struct acpi_device *device);
-static int acpi_fan_resume(struct acpi_device *device);
 
 static const struct acpi_device_id fan_device_ids[] = {
 	{"PNP0C0B", 0},
@@ -55,6 +53,10 @@ static const struct acpi_device_id fan_d
 };
 MODULE_DEVICE_TABLE(acpi, fan_device_ids);
 
+static int acpi_fan_suspend(struct device *dev);
+static int acpi_fan_resume(struct device *dev);
+static SIMPLE_DEV_PM_OPS(acpi_fan_pm, acpi_fan_suspend, acpi_fan_resume);
+
 static struct acpi_driver acpi_fan_driver = {
 	.name = "fan",
 	.class = ACPI_FAN_CLASS,
@@ -62,9 +64,8 @@ static struct acpi_driver acpi_fan_drive
 	.ops = {
 		.add = acpi_fan_add,
 		.remove = acpi_fan_remove,
-		.suspend = acpi_fan_suspend,
-		.resume = acpi_fan_resume,
 		},
+	.drv.pm = &acpi_fan_pm,
 };
 
 /* thermal cooling device callbacks */
@@ -183,24 +184,24 @@ static int acpi_fan_remove(struct acpi_d
 	return 0;
 }
 
-static int acpi_fan_suspend(struct acpi_device *device)
+static int acpi_fan_suspend(struct device *dev)
 {
-	if (!device)
+	if (!dev)
 		return -EINVAL;
 
-	acpi_bus_set_power(device->handle, ACPI_STATE_D0);
+	acpi_bus_set_power(to_acpi_device(dev)->handle, ACPI_STATE_D0);
 
 	return AE_OK;
 }
 
-static int acpi_fan_resume(struct acpi_device *device)
+static int acpi_fan_resume(struct device *dev)
 {
 	int result;
 
-	if (!device)
+	if (!dev)
 		return -EINVAL;
 
-	result = acpi_bus_update_power(device->handle, NULL);
+	result = acpi_bus_update_power(to_acpi_device(dev)->handle, NULL);
 	if (result)
 		printk(KERN_ERR PREFIX "Error updating fan power state\n");
 
