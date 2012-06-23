From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 17/21] xo15-ebook: Use struct dev_pm_ops for power management
Date: Sat, 23 Jun 2012 23:18:51 +0200
Message-ID: <201206232318.51901.rjw@sisk.pl>
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

Make the xo15-ebook driver define its PM callbacks through
a struct dev_pm_ops object rather than by using legacy PM hooks
in struct acpi_device_ops.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/platform/x86/xo15-ebook.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

Index: linux/drivers/platform/x86/xo15-ebook.c
===================================================================
--- linux.orig/drivers/platform/x86/xo15-ebook.c
+++ linux/drivers/platform/x86/xo15-ebook.c
@@ -77,11 +77,13 @@ static void ebook_switch_notify(struct a
 	}
 }
 
-static int ebook_switch_resume(struct acpi_device *device)
+static int ebook_switch_resume(struct device *dev)
 {
-	return ebook_send_state(device);
+	return ebook_send_state(to_acpi_device(dev));
 }
 
+static SIMPLE_DEV_PM_OPS(ebook_switch_pm, NULL, ebook_switch_resume);
+
 static int ebook_switch_add(struct acpi_device *device)
 {
 	struct ebook_switch *button;
@@ -161,10 +163,10 @@ static struct acpi_driver xo15_ebook_dri
 	.ids = ebook_device_ids,
 	.ops = {
 		.add = ebook_switch_add,
-		.resume = ebook_switch_resume,
 		.remove = ebook_switch_remove,
 		.notify = ebook_switch_notify,
 	},
+	.drv.pm = &ebook_switch_pm,
 };
 
 static int __init xo15_ebook_init(void)
