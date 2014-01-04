From: Alexander Mezin <mezin.alexander@gmail.com>
Subject: [PATCH] ACPI / AC: change notification handler type to ACPI_ALL_NOTIFY
Date: Sat,  4 Jan 2014 09:07:59 +0700
Message-ID: <1388801279-15502-1-git-send-email-mezin.alexander@gmail.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-la0-f49.google.com ([209.85.215.49]:48684 "EHLO
	mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753866AbaADCIf (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 3 Jan 2014 21:08:35 -0500
Received: by mail-la0-f49.google.com with SMTP id er20so8374291lab.22
        for <linux-acpi@vger.kernel.org>; Fri, 03 Jan 2014 18:08:34 -0800 (PST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: tianyu.lan@intel.com, Alexander Mezin <mezin.alexander@gmail.com>

With kernel 3.13rc5 there are no AC adapter notifications on my laptop.

Commit cc8ef52707341e67a12067d6ead991d56ea017ca
"ACPI / AC: convert ACPI ac driver to platform bus" changed the driver
to listen only to device notifications. However, aml code on my laptop
notifies the driver with zero event.

This patch changes the driver to listen to all events again.

References: https://bugzilla.kernel.org/show_bug.cgi?id=67821

Signed-off-by: Alexander Mezin <mezin.alexander@gmail.com>
---
 drivers/acpi/ac.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/ac.c b/drivers/acpi/ac.c
index 8711e37..3c2e4aa 100644
--- a/drivers/acpi/ac.c
+++ b/drivers/acpi/ac.c
@@ -207,7 +207,7 @@ static int acpi_ac_probe(struct platform_device *pdev)
 		goto end;
 
 	result = acpi_install_notify_handler(ACPI_HANDLE(&pdev->dev),
-			ACPI_DEVICE_NOTIFY, acpi_ac_notify_handler, ac);
+			ACPI_ALL_NOTIFY, acpi_ac_notify_handler, ac);
 	if (result) {
 		power_supply_unregister(&ac->charger);
 		goto end;
@@ -255,7 +255,7 @@ static int acpi_ac_remove(struct platform_device *pdev)
 		return -EINVAL;
 
 	acpi_remove_notify_handler(ACPI_HANDLE(&pdev->dev),
-			ACPI_DEVICE_NOTIFY, acpi_ac_notify_handler);
+			ACPI_ALL_NOTIFY, acpi_ac_notify_handler);
 
 	ac = platform_get_drvdata(pdev);
 	if (ac->charger.dev)
-- 
1.8.5.2

