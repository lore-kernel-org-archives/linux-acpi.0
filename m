From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 2/21] ACPI / PM: Make acpi_bus_type use struct dev_pm_ops for PM handling
Date: Sat, 23 Jun 2012 23:08:36 +0200
Message-ID: <201206232308.37321.rjw@sisk.pl>
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

Make the acpi_bus_type bus type define its PM callbacks through
a struct dev_pm_ops object rather than by using legacy PM hooks
in struct bus_type.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/acpi/scan.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

Index: linux/drivers/acpi/scan.c
===================================================================
--- linux.orig/drivers/acpi/scan.c
+++ linux/drivers/acpi/scan.c
@@ -290,7 +290,7 @@ static void acpi_device_release(struct d
 	kfree(acpi_dev);
 }
 
-static int acpi_device_suspend(struct device *dev, pm_message_t state)
+static int acpi_device_suspend(struct device *dev)
 {
 	struct acpi_device *acpi_dev = to_acpi_device(dev);
 	struct acpi_driver *acpi_drv = acpi_dev->driver;
@@ -310,6 +310,8 @@ static int acpi_device_resume(struct dev
 	return 0;
 }
 
+static SIMPLE_DEV_PM_OPS(acpi_bus_pm, acpi_device_suspend, acpi_device_resume);
+
 static int acpi_bus_match(struct device *dev, struct device_driver *drv)
 {
 	struct acpi_device *acpi_dev = to_acpi_device(dev);
@@ -441,12 +443,11 @@ static int acpi_device_remove(struct dev
 
 struct bus_type acpi_bus_type = {
 	.name		= "acpi",
-	.suspend	= acpi_device_suspend,
-	.resume		= acpi_device_resume,
 	.match		= acpi_bus_match,
 	.probe		= acpi_device_probe,
 	.remove		= acpi_device_remove,
 	.uevent		= acpi_device_uevent,
+	.pm		= &acpi_bus_pm,
 };
 
 static int acpi_device_register(struct acpi_device *device)
