From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 14/21] sony-laptop: Use struct dev_pm_ops for power management
Date: Sat, 23 Jun 2012 23:17:01 +0200
Message-ID: <201206232317.01620.rjw@sisk.pl>
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

Make the sony-laptop driver define its PM callbacks through
a struct dev_pm_ops object rather than by using legacy PM hooks
in struct acpi_device_ops.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/platform/x86/sony-laptop.c |   20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

Index: linux/drivers/platform/x86/sony-laptop.c
===================================================================
--- linux.orig/drivers/platform/x86/sony-laptop.c
+++ linux/drivers/platform/x86/sony-laptop.c
@@ -1452,7 +1452,7 @@ static void sony_nc_function_resume(void
 				&result);
 }
 
-static int sony_nc_resume(struct acpi_device *device)
+static int sony_nc_resume(struct device *dev)
 {
 	struct sony_nc_value *item;
 	acpi_handle handle;
@@ -1484,6 +1484,8 @@ static int sony_nc_resume(struct acpi_de
 	return 0;
 }
 
+static SIMPLE_DEV_PM_OPS(sony_nc_pm, NULL, sony_nc_resume);
+
 static void sony_nc_rfkill_cleanup(void)
 {
 	int i;
@@ -2728,9 +2730,9 @@ static struct acpi_driver sony_nc_driver
 	.ops = {
 		.add = sony_nc_add,
 		.remove = sony_nc_remove,
-		.resume = sony_nc_resume,
 		.notify = sony_nc_notify,
 		},
+	.drv.pm = &sony_nc_pm,
 };
 
 /*********** SPIC (SNY6001) Device ***********/
@@ -4243,19 +4245,22 @@ err_free_resources:
 	return result;
 }
 
-static int sony_pic_suspend(struct acpi_device *device)
+static int sony_pic_suspend(struct device *dev)
 {
-	if (sony_pic_disable(device))
+	if (sony_pic_disable(to_acpi_device(dev)))
 		return -ENXIO;
 	return 0;
 }
 
-static int sony_pic_resume(struct acpi_device *device)
+static int sony_pic_resume(struct device *dev)
 {
-	sony_pic_enable(device, spic_dev.cur_ioport, spic_dev.cur_irq);
+	sony_pic_enable(to_acpi_device(dev),
+			spic_dev.cur_ioport, spic_dev.cur_irq);
 	return 0;
 }
 
+static SIMPLE_DEV_PM_OPS(sony_pic_pm, sony_pic_suspend, sony_pic_resume);
+
 static const struct acpi_device_id sony_pic_device_ids[] = {
 	{SONY_PIC_HID, 0},
 	{"", 0},
@@ -4269,9 +4274,8 @@ static struct acpi_driver sony_pic_drive
 	.ops = {
 		.add = sony_pic_add,
 		.remove = sony_pic_remove,
-		.suspend = sony_pic_suspend,
-		.resume = sony_pic_resume,
 		},
+	.drv.pm = &sony_pic_pm,
 };
 
 static struct dmi_system_id __initdata sonypi_dmi_table[] = {
