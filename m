From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 20/21] ACPI / PM: Drop legacy driver PM callbacks that are not used any more
Date: Sat, 23 Jun 2012 23:21:04 +0200
Message-ID: <201206232321.05039.rjw@sisk.pl>
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

Since the legacy ACPI driver PM callbacks included into
struct acpi_device_ops are not used any more, drop them.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 include/acpi/acpi_bus.h |    4 ----
 1 file changed, 4 deletions(-)

Index: linux/include/acpi/acpi_bus.h
===================================================================
--- linux.orig/include/acpi/acpi_bus.h
+++ linux/include/acpi/acpi_bus.h
@@ -117,8 +117,6 @@ struct acpi_device;
 typedef int (*acpi_op_add) (struct acpi_device * device);
 typedef int (*acpi_op_remove) (struct acpi_device * device, int type);
 typedef int (*acpi_op_start) (struct acpi_device * device);
-typedef int (*acpi_op_suspend) (struct acpi_device * device);
-typedef int (*acpi_op_resume) (struct acpi_device * device);
 typedef int (*acpi_op_bind) (struct acpi_device * device);
 typedef int (*acpi_op_unbind) (struct acpi_device * device);
 typedef void (*acpi_op_notify) (struct acpi_device * device, u32 event);
@@ -132,8 +130,6 @@ struct acpi_device_ops {
 	acpi_op_add add;
 	acpi_op_remove remove;
 	acpi_op_start start;
-	acpi_op_suspend suspend;
-	acpi_op_resume resume;
 	acpi_op_bind bind;
 	acpi_op_unbind unbind;
 	acpi_op_notify notify;
