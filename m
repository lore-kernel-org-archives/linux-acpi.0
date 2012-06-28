From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH missing/21] classmate-laptop: Use struct dev_pm_ops for power management
Date: Fri, 29 Jun 2012 00:11:53 +0200
Message-ID: <201206290011.53618.rjw@sisk.pl>
References: <201206232306.06602.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <201206232306.06602.rjw@sisk.pl>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Len Brown <lenb@kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>, platform-driver-x86@vger.kernel.org, Eric Piel <eric.piel@tremplin-utc.net>, Mattia Dongili <malattia@linux.it>, Harald Welte <laforge@gnumonks.org>, Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>, Daniel Oliveira Nascimento <don@syst.com.br>
List-Id: linux-acpi@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

Make the classmate-laptop driver define its PM callbacks through
a struct dev_pm_ops object rather than by using legacy PM hooks
in struct acpi_device_ops.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---

Hi all,

I overlooked the classmate-laptop driver in the ACPI conversion to PM
handling based on struct dev_pm_ops, so this one should go after [17/21] and
the next patches should be renumbered.

Thanks,
Rafael


---
 drivers/platform/x86/classmate-laptop.c |   13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

Index: linux/drivers/platform/x86/classmate-laptop.c
===================================================================
--- linux.orig/drivers/platform/x86/classmate-laptop.c
+++ linux/drivers/platform/x86/classmate-laptop.c
@@ -362,15 +362,18 @@ static int cmpc_tablet_remove(struct acp
 	return cmpc_remove_acpi_notify_device(acpi);
 }
 
-static int cmpc_tablet_resume(struct acpi_device *acpi)
+static int cmpc_tablet_resume(struct device *dev)
 {
-	struct input_dev *inputdev = dev_get_drvdata(&acpi->dev);
+	struct input_dev *inputdev = dev_get_drvdata(dev);
+
 	unsigned long long val = 0;
-	if (ACPI_SUCCESS(cmpc_get_tablet(acpi->handle, &val)))
+	if (ACPI_SUCCESS(cmpc_get_tablet(to_acpi_device(dev)->handle, &val)))
 		input_report_switch(inputdev, SW_TABLET_MODE, !val);
 	return 0;
 }
 
+static SIMPLE_DEV_PM_OPS(cmpc_tabled_pm, NULL, cmpc_tablet_resume);
+
 static const struct acpi_device_id cmpc_tablet_device_ids[] = {
 	{CMPC_TABLET_HID, 0},
 	{"", 0}
@@ -384,9 +387,9 @@ static struct acpi_driver cmpc_tablet_ac
 	.ops = {
 		.add = cmpc_tablet_add,
 		.remove = cmpc_tablet_remove,
-		.resume = cmpc_tablet_resume,
 		.notify = cmpc_tablet_handler,
-	}
+	},
+	.drv.pm = &cmpc_tabled_pm,
 };
 
 
