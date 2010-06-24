From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 3/6] ACPI / EC: Drop suspend and resume routines
Date: Fri, 25 Jun 2010 01:20:38 +0200
Message-ID: <201006250120.38554.rjw@sisk.pl>
References: <201006250117.45148.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:47184 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752918Ab0FXX0H (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 24 Jun 2010 19:26:07 -0400
In-Reply-To: <201006250117.45148.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "Lin, Ming M" <ming.m.lin@intel.com>, Matthew Garrett <mjg59@srcf.ucam.org>, "Moore, Robert" <robert.moore@intel.com>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, len.brown@intel.com, Alexey Starikovskiy <astarikovskiy@suse.de>

From: Rafael J. Wysocki <rjw@sisk.pl>

The suspend and resume routines provided by the EC driver are not
really necessary, because the handler of the GPE disabled by them
is not going to be executed after suspend_device_irqs() and before
resume_device_irqs() anyway.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/acpi/ec.c |   18 ------------------
 1 file changed, 18 deletions(-)

Index: linux-2.6/drivers/acpi/ec.c
===================================================================
--- linux-2.6.orig/drivers/acpi/ec.c
+++ linux-2.6/drivers/acpi/ec.c
@@ -1088,22 +1088,6 @@ error:
 	return -ENODEV;
 }
 
-static int acpi_ec_suspend(struct acpi_device *device, pm_message_t state)
-{
-	struct acpi_ec *ec = acpi_driver_data(device);
-	/* Stop using the GPE, but keep it reference counted. */
-	acpi_set_gpe(NULL, ec->gpe, ACPI_GPE_DISABLE);
-	return 0;
-}
-
-static int acpi_ec_resume(struct acpi_device *device)
-{
-	struct acpi_ec *ec = acpi_driver_data(device);
-	/* Enable the GPE again, but don't reference count it once more. */
-	acpi_set_gpe(NULL, ec->gpe, ACPI_GPE_ENABLE);
-	return 0;
-}
-
 static struct acpi_driver acpi_ec_driver = {
 	.name = "ec",
 	.class = ACPI_EC_CLASS,
@@ -1111,8 +1095,6 @@ static struct acpi_driver acpi_ec_driver
 	.ops = {
 		.add = acpi_ec_add,
 		.remove = acpi_ec_remove,
-		.suspend = acpi_ec_suspend,
-		.resume = acpi_ec_resume,
 		},
 };
 

