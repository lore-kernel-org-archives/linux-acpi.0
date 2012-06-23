From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 12/21] toshiba_acpi: Use struct dev_pm_ops for power management
Date: Sat, 23 Jun 2012 23:15:39 +0200
Message-ID: <201206232315.40150.rjw@sisk.pl>
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

Make the toshiba_acpi driver define its PM callbacks through
a struct dev_pm_ops object rather than by using legacy PM hooks
in struct acpi_device_ops.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/platform/x86/toshiba_acpi.c |   14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

Index: linux/drivers/platform/x86/toshiba_acpi.c
===================================================================
--- linux.orig/drivers/platform/x86/toshiba_acpi.c
+++ linux/drivers/platform/x86/toshiba_acpi.c
@@ -1296,9 +1296,9 @@ static void toshiba_acpi_notify(struct a
 	}
 }
 
-static int toshiba_acpi_suspend(struct acpi_device *acpi_dev)
+static int toshiba_acpi_suspend(struct device *device)
 {
-	struct toshiba_acpi_dev *dev = acpi_driver_data(acpi_dev);
+	struct toshiba_acpi_dev *dev = acpi_driver_data(to_acpi_device(device));
 	u32 result;
 
 	if (dev->hotkey_dev)
@@ -1307,9 +1307,9 @@ static int toshiba_acpi_suspend(struct a
 	return 0;
 }
 
-static int toshiba_acpi_resume(struct acpi_device *acpi_dev)
+static int toshiba_acpi_resume(struct device *device)
 {
-	struct toshiba_acpi_dev *dev = acpi_driver_data(acpi_dev);
+	struct toshiba_acpi_dev *dev = acpi_driver_data(to_acpi_device(device));
 	u32 result;
 
 	if (dev->hotkey_dev)
@@ -1318,6 +1318,9 @@ static int toshiba_acpi_resume(struct ac
 	return 0;
 }
 
+static SIMPLE_DEV_PM_OPS(toshiba_acpi_pm,
+			 toshiba_acpi_suspend, toshiba_acpi_resume);
+
 static struct acpi_driver toshiba_acpi_driver = {
 	.name	= "Toshiba ACPI driver",
 	.owner	= THIS_MODULE,
@@ -1327,9 +1330,8 @@ static struct acpi_driver toshiba_acpi_d
 		.add		= toshiba_acpi_add,
 		.remove		= toshiba_acpi_remove,
 		.notify		= toshiba_acpi_notify,
-		.suspend	= toshiba_acpi_suspend,
-		.resume		= toshiba_acpi_resume,
 	},
+	.drv.pm	= &toshiba_acpi_pm,
 };
 
 static int __init toshiba_acpi_init(void)
