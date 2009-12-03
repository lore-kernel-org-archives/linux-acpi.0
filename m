From: Corentin Chary <corentincj@iksaif.net>
Subject: [PATCH 03/33] asus-acpi: Remove redundant NULL checks
Date: Thu,  3 Dec 2009 08:44:47 +0100
Message-ID: <1259826317-18809-4-git-send-email-corentincj@iksaif.net>
References: <1259826317-18809-1-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-2-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-3-git-send-email-corentincj@iksaif.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iksaif.net ([88.191.73.63]:44211 "EHLO iksaif.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751020AbZLCHob (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 3 Dec 2009 02:44:31 -0500
In-Reply-To: <1259826317-18809-3-git-send-email-corentincj@iksaif.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Alan Jenkins <alan-jenkins@tuffmail.co.uk>

From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>

The acpi device callbacks add, start, remove, suspend and resume can
never be called with a NULL acpi_device. Each callsite in acpi/scan.c
has to dereference the device in order to get the ops structure, e.g.

    struct acpi_device *acpi_dev = to_acpi_device(dev);
    struct acpi_driver *acpi_drv = acpi_dev->driver;

    if (acpi_drv && acpi_drv->ops.suspend)
        return acpi_drv->ops.suspend(acpi_dev, state);

Remove all checks for acpi_dev == NULL within these callbacks.

Also remove the checks for acpi_driver_data(acpi_dev) == NULL. None of
these checks could fail unless the driver does something strange
(which none of them do), the acpi core did something terribly wrong,
or we have a memory corruption issue. If this does happen then it's
best to dereference the pointer and crash noisily.

Signed-off-by: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
---
 drivers/platform/x86/asus_acpi.c |    6 ------
 1 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/drivers/platform/x86/asus_acpi.c b/drivers/platform/x86/asus_acpi.c
index ddf5240..25a7d57 100644
--- a/drivers/platform/x86/asus_acpi.c
+++ b/drivers/platform/x86/asus_acpi.c
@@ -1334,9 +1334,6 @@ static int asus_hotk_add(struct acpi_device *device)
 	acpi_status status = AE_OK;
 	int result;
 
-	if (!device)
-		return -EINVAL;
-
 	printk(KERN_NOTICE "Asus Laptop ACPI Extras version %s\n",
 	       ASUS_ACPI_VERSION);
 
@@ -1392,9 +1389,6 @@ end:
 
 static int asus_hotk_remove(struct acpi_device *device, int type)
 {
-	if (!device || !acpi_driver_data(device))
-		return -EINVAL;
-
 	asus_hotk_remove_fs(device);
 
 	kfree(hotk);
-- 
1.6.5.3

